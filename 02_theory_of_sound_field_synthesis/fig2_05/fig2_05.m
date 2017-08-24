clear all;
addpath('../../matlab');
create_dir('data');

%% ===== Configuration ===================================================
X = [-2 2];
Y = [-2 2];
Z = 0;
xs = [0 0 0];
f = 800;

%% ===== Toolbox settings ================================================
conf = SFS_config;
conf.resolution = 1000;
conf.xref = [0 1 0];

%% ===== Main ============================================================
[P,x,y,z] = sound_field_mono_point_source(X,Y,Z,xs,f,conf);
P = normalization(P,'point');
gp_save_matrix('data/sound_field_point_source.dat',x,y,real(P));

rmpath('../../matlab');
