clear all;
addpath('../../matlab');
create_dir('data');

%% ===== Configuration ===================================================
X = [0 0 2]; % / m
Y = [-4 -2 -2]; % / m
Z = 0; % / m
f = 1000; % / Hz
xsy{1} = [8:-0.01:-3.9];
xsy{2} = [8:-0.01:-1.9];
xsy{3} = [8:-0.01:-1.9];

%% ===== Toolbox settings ================================================
conf = SFS_config;
conf.resolution = 1000; % / samples
conf.xref = [0 -2 0]; % / m
conf.dimension = '2D';
conf.usetapwin = false;

%% ===== Secondary Sources ===============================================
conf.secondary_sources.size = 100; % / m
conf.secondary_sources.center = [0 0 0]; % / m
conf.secondary_sources.geometry = 'line';
conf.secondary_sources.number = 1000;

for jj=1:length(Y)

    P_ls = [];
    P_ps = [];
    P_wfs_ls = [];
    P_wfs_ps = [];
    P_wfs_ps2 = [];

    for ii=1:length(xsy{jj})

        xs = [0 xsy{jj}(ii) 0];

        %% ===== Reference Sources ========================================
        % --- line and point source ---
        P_ls(ii) = sound_field_mono_line_source(X(jj),Y(jj),Z,xs,f,conf);
        P_ps(ii) = sound_field_mono_point_source(X(jj),Y(jj),Z,xs,f,conf);
        
        %% ===== Wave Field Synthesis ====================================
        conf.driving_functions = 'default';
        if xsy{jj}(ii)>conf.secondary_sources.center(2)+0.1
            % --- line and point source ---
            xs = [0 xsy{jj}(ii) 0];
            conf.dimension = '2D';
            P_wfs_ls(ii) = sound_field_mono_wfs(X(jj),Y(jj),Z,xs,'ls',f,conf);
            conf.dimension = '2.5D';
            P_wfs_ps(ii) = sound_field_mono_wfs(X(jj),Y(jj),Z,xs,'ps',f,conf);
            conf.driving_functions = 'point_source';
            P_wfs_ps2(ii) = sound_field_mono_wfs(X(jj),Y(jj),Z,xs,'ps',f,conf);
        elseif xsy{jj}(ii)<conf.secondary_sources.center(2)-0.1
            % --- focused source ---
            xs = [0 xsy{jj}(ii) 0 0 -1 0];
            conf.dimension = '2D';
            P_wfs_ls(ii) = sound_field_mono_wfs(X(jj),Y(jj),Z,xs,'fs',f,conf);
            conf.dimension = '2.5D';
            P_wfs_ps(ii) = sound_field_mono_wfs(X(jj),Y(jj),Z,xs,'fs',f,conf);
            conf.driving_functions = 'point_sink';
            P_wfs_ps2(ii) = sound_field_mono_wfs(X(jj),Y(jj),Z,xs,'fs',f,conf);
        else
            P_wfs_ls(ii) = NaN;
            P_wfs_ps(ii) = NaN;
            P_wfs_ps2(ii) = NaN;
            continue;
        end

        progress_bar(ii+(jj-1)*length(xsy{jj}),length(Y)*length(xsy{jj}))
    end

    % --- smooth focused source ---
    % Find index of first focused source entry
    idx = find(xsy{jj}<-0.1,1,'first');
    [b,a] = butter(4,700/22050,'low');
    P_wfs_ls_low_pass = P_wfs_ls;
    P_wfs_ls_low_pass(idx:end) = filtfilt(b,a,db(abs(P_wfs_ls(idx:end)')));
    P_wfs_ps_low_pass = P_wfs_ps;
    P_wfs_ps_low_pass(idx:end) = filtfilt(b,a,db(abs(P_wfs_ps(idx:end)')));
    P_wfs_ps2_low_pass = P_wfs_ps2;
    P_wfs_ps2_low_pass(idx:end) = P_wfs_ps_low_pass(idx:end);

    %% ===== Save to File ====================================================
    M = [xsy{jj}' db(abs(P_ls')) db(abs(P_wfs_ls')) P_wfs_ls_low_pass'];
    header = 'y line_source WFS_2D_line_source WFS_2D_line_source_low_pass';
    file = sprintf('data/amplitudes_moving_source_2D_X%.1f_Y%.1f.txt',X(jj),Y(jj));
    gp_save(file,M,header);
	M = [xsy{jj}' db(abs(P_ps')) db(abs(P_wfs_ps')) P_wfs_ps_low_pass'];
    header = 'y point_source WFS_25D_point_source';
    file = sprintf('data/amplitudes_moving_source_25D_X%.1f_Y%.1f.txt',X(jj),Y(jj));
    gp_save(file,M,header);
	M = [xsy{jj}' db(abs(P_ps')) db(abs(P_wfs_ps2')) P_wfs_ps2_low_pass'];
    header = 'y point_source WFS_25D_point_source';
    file = sprintf('data/amplitudes_moving_source_25D_ps_X%.1f_Y%.1f.txt',X(jj),Y(jj));
    gp_save(file,M,header);
end

rmpath('../../matlab');
