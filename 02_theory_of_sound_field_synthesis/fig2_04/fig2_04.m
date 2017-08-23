clear all;
addpath('../../matlab');
create_dir('data');

%% ===== Configuration ===================================================
X = [-2 2];
Y = [-2 2];
Z = 0;
xs = [1 1 0];
f = 800;

%% ===== Toolbox settings ================================================
conf = SFS_config;
conf.resolution = 1000;
conf.xref = [0 1 0];

%% ===== Main ============================================================
[P,x,y,z] = sound_field_mono_plane_wave(X,Y,Z,xs,f,conf);
gp_save_matrix('data/sound_field_plane_wave.dat',x,y,real(P));

rmpath('../../matlab');
