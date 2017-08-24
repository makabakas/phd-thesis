clear all
addpath('../../matlab');
create_dir('data');

%% ===== Configuration ===================================================
X = [-1.75 1.75]; % / m
Y = [-1.75 1.75]; % / m
Z = 0; % / m
xs = [0 -1 0];
src = 'pw';
f = 1000; % / Hz

%% ===== Toolbox settings ================================================
conf = SFS_config;
conf.resolution = 1000; % / samples
conf.showprogress = true;

%% ===== Secondary Sources ===============================================
conf.secondary_sources.size = 3; % / m
conf.secondary_sources.center = [0 0 0]; % / m
conf.secondary_sources.geometry = 'circle';
conf.secondary_sources.number = 1000;
% store complete array and repeat the first loudspeaker in order to draw a
% complete circle
x0 = secondary_source_positions(conf);
gp_save_loudspeakers('data/array.txt',[x0; x0(1,:)]);

%% ===== Near-field compensated higer order Ambisonics ===================
[P,x,y] = sound_field_mono_nfchoa(X,Y,Z,xs,src,f,conf);
file = sprintf('data/sound_field_nfchoa_pw_f%iHz_nls%i.dat',f, ...
               conf.secondary_sources.number);
gp_save_matrix(file,x,y,real(P));

rmpath('../../matlab');
