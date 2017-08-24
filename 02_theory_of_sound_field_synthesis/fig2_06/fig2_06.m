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
conf.phase = -0.8;

%% ===== Main ============================================================
[P,x,y,z] = sound_field_mono_line_source(X,Y,Z,xs,f,conf);
P = normalization(P,'line',f,conf);
gp_save_matrix('data/sound_field_line_source.dat',x,y,real(P));

rmpath('../../matlab');
