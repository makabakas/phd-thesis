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
conf.nfchoa.order = 100;

%% ===== Secondary Sources ===============================================
conf.secondary_sources.size = 3; % / m
conf.secondary_sources.center = [0 0 0]; % / m
conf.secondary_sources.geometry = 'circle';
conf.secondary_sources.number = 64;

%% ===== Without aliasing ================================================
f = 1000; % / Hz
[P,x,y,~,x0] = sound_field_mono_nfchoa(X,Y,Z,xs,src,f,conf);
gp_save_matrix('data/sound_field_nfchoa_1000Hz.dat',x,y,real(P));
gp_save_loudspeakers('data/array.txt',x0);


%% ===== With aliasing ===================================================
f = 2000; % / Hz
[P,x,y] = sound_field_mono_nfchoa(X,Y,Z,xs,src,f,conf);
gp_save_matrix('data/sound_field_nfchoa_2000Hz.dat',x,y,real(P));
f = 2000; % / Hz
conf.phase = -0.2*pi/2;
[P,x,y,~,x0] = sound_field_mono_wfs(X,Y,Z,xs,src,f,conf);
gp_save_matrix('data/sound_field_wfs_2000Hz.dat',x,y,real(P));
gp_save_loudspeakers('data/array_wfs.txt',x0);

rmpath('../../matlab');
