% create the data for the monochromatic sound field plots
clear all
addpath('../../matlab');
create_dir('data');

%% ===== Configuration ===================================================
X = [-1.75 1.75]; % / m
Y = [-1.75 1.75]; % / m
Z = 0; % / m
xs = [0 -1 0];
src = 'pw';

%% ===== Toolbox settings ================================================
conf = SFS_config;
conf.resolution = 1000; % / samples
conf.usetapwin = false;
conf.showprogress = true;

%% ===== Secondary Sources ===============================================
conf.secondary_sources.size = 3; % / m
conf.secondary_sources.center = [0 0 0]; % / m
conf.secondary_sources.geometry = 'circle';
conf.secondary_sources.number = 64;

%% ===== without aliasing ================================================
f = 1000; % / Hz
[P,x,y,~,x0] = sound_field_mono_nfchoa(X,Y,Z,xs,src,f,conf);
gp_save_matrix('data/sound_field_nfchoa_1000Hz.dat',x,y,real(P));
gp_save_loudspeakers('data/array.txt',x0);

%% ===== with aliasing ===================================================
f = 2000; % / Hz
[P,x,y] = sound_field_mono_nfchoa(X,Y,Z,xs,src,f,conf);
gp_save_matrix('data/sound_field_nfchoa_2000Hz.dat',x,y,real(P));
f = 5000; % / Hz
[P,x,y] = sound_field_mono_nfchoa(X,Y,Z,xs,src,f,conf);
gp_save_matrix('data/sound_field_nfchoa_5000Hz.dat',x,y,real(P));

rmpath('../../matlab');
