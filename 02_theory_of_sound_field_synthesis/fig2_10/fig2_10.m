clear all
addpath('../../matlab');
create_dir('data');

%% ===== Configuration ===================================================
X = [-1.75 1.75]; % / m
Y = [-1.75 1.75]; % / m
Z = 0; % / m
xs = [0 2.5 0];
src = 'ps';
f = 1000; % / Hz

%% ===== Toolbox settings ================================================
conf = SFS_config;
conf.resolution = 1000; % / samples
conf.usetapwin = false;
conf.showprogress = true;

%% ===== Secondary Sources ===============================================
conf.secondary_sources.size = 3; % / m
conf.secondary_sources.center = [0 0 0]; % / m
conf.secondary_sources.geometry = 'circle';
conf.secondary_sources.number = 1000;
% Store complete array and repeat the first loudspeaker in order to draw a
% complete circle
x0 = secondary_source_positions(conf);
gp_save_loudspeakers('data/array.txt',[x0; x0(1,:)]);

%% ===== Wave Field Synthesis ============================================
[P,x,y,~,x0] = sound_field_mono_wfs(X,Y,Z,xs,src,f,conf);
P = normalization(P,'point');
file = sprintf('data/sound_field_wfs_ps_f%iHz_nls%i.dat',f,conf.secondary_sources.number);
gp_save_matrix(file,x,y,real(P));
gp_save_loudspeakers('data/array_wfs_ps.txt',x0);

rmpath('../../matlab');
