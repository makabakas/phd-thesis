clear all
addpath('../../matlab');
create_dir('data');

%% ===== Configuration ===================================================
X = 0; % / m
Y = [-5.5 1.5]; % / m
Z = 0; % / m
f = 1000; % / Hz
xs_ps = [ 0  1  0]; % / m
xs_ls = [ 0  1  0]; % / m
xs_pw = [ 0 -1  0]; % / m
xs_fs = [ 0 -1  0  0 -1  0]; % / m

%% ===== Toolbox settings ================================================
conf = SFS_config;
conf.resolution = 1000; % / samples
conf.xref = [0 -2 0]; % / m
conf.usetapwin = false;

%% ===== Secondary Sources ===============================================
conf.secondary_sources.size = 100000; % / m
conf.secondary_sources.center = [0 0 0]; % / m
conf.secondary_sources.geometry = 'line';
conf.secondary_sources.number = 1000000;

%% ===== Reference Sources ===============================================
% --- point source ---
[P_ps,~,y] = sound_field_mono_point_source(X,Y,Z,xs_ps,f,conf);
% --- line source ---
[P_ls,~,y] = sound_field_mono_line_source(X,Y,Z,xs_ls,f,conf);
% --- plane wave ---
[P_pw,~,y] = sound_field_mono_plane_wave(X,Y,Z,xs_pw,f,conf);
% --- focused source ---
[P_fs_2D,~,y] = sound_field_mono_line_source(X,Y,Z,xs_fs(1:3),f,conf);
[P_fs_3D,~,y] = sound_field_mono_point_source(X,Y,Z,xs_fs(1:3),f,conf);

%% ===== Wave Field Synthesis ============================================
dimensions = {'2D','2.5D'};
for ii=1:length(dimensions)
    conf.dimension = dimensions{ii};
    % --- point source ---
    [P_wfs_ps,~,y] = sound_field_mono_wfs(X,Y,Z,xs_ps,'ps',f,conf);
    progress_bar(1+(ii-1)*5,10);
    conf.driving_functions = 'point_source';
    [P_wfs_ps2,~,y] = sound_field_mono_wfs(X,Y,Z,xs_ps,'ps',f,conf);
    conf.driving_functions = 'default';
    progress_bar(2+(ii-1)*5,10);
    % --- line source ---
    [P_wfs_ls,~,y] = sound_field_mono_wfs(X,Y,Z,xs_ls,'ls',f,conf);
    progress_bar(3+(ii-1)*5,10);
    % --- plane wave ---
    [P_wfs_pw,~,y] = sound_field_mono_wfs(X,Y,Z,xs_pw,'pw',f,conf);
    progress_bar(4+(ii-1)*5,10);
    % --- focused source ---   
    [P_wfs_fs,~,y] = sound_field_mono_wfs(X,Y,Z,xs_fs,'fs',f,conf);
    % Apply low pass filter to focused source to get rid of diffraction effects
    [b,a] = butter(4,600/22050,'low');
    P_wfs_fs_filtered = filtfilt(b,a,db(abs(P_wfs_fs)));
    progress_bar(5+(ii-1)*5,10);

    %% ===== Save to File ====================================================
    if strcmp(dimensions{ii},'2D')
        P_fs = P_fs_2D;
    elseif strcmp(dimensions{ii},'2.5D')
        P_fs = P_fs_3D;
    end
    M = [y db(abs([P_ps P_ls P_pw P_fs P_wfs_ps P_wfs_ls P_wfs_pw P_wfs_fs])) P_wfs_fs_filtered db(abs(P_wfs_ps2))];
    header = sprintf('y point_source line_source plane_wave focused source ', ...
                     'WFS_%s_point_source WFS_%s_line_source WFS_%s_plane_wave ', ...
                     'WFS_%s_focused_source WFS_%s_focused_source_low_pass ', ...
                     'WFS_%s_point_source_wo_approx',dimensions{ii});
    gp_save(sprintf('data/amplitudes_%s.txt',dimensions{ii}),M,header);
end

rmpath('../../matlab');
