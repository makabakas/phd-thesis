% Create sound field simulations for a linear array and WFS with and without
% tapering window to show the edge waves
clear all;
addpath('../../matlab');
create_dir('data');

%% ===== Configuration ===================================================
X = [-2.1 2.1]; % / m
Y = [-3.5 0.5]; % / m
Z = 0; % / m
f = 3000; % / Hz
xs = [0 -1 0];
src = 'pw';

%% ===== Toolbox settings ================================================
conf = SFS_config;
conf.resolution = 1000; % / samples
conf.xref = [0 -2 0]; % / m
conf.usetapwin = false;
conf.showprogress = true;

%% ===== Truncated =======================================================
conf.secondary_sources.center = [0 0 0]; % / m
conf.secondary_sources.geometry = 'line';
conf.secondary_sources.size = 1.8; % / m
conf.secondary_sources.number = 900;
[P,x,y,~,x0] = sound_field_mono_wfs(X,Y,Z,xs,src,f,conf);
gp_save_loudspeakers('data/array_truncated.txt',x0);
gp_save_matrix('data/sound_field_truncated.dat',x,y,db(abs(P)));

%% ===== Non-truncated ===================================================
conf.secondary_sources.size = 1000; % / m
conf.secondary_sources.number = 100000;
[P,x,y,~,x0] = sound_field_mono_wfs(X,Y,Z,xs,src,f,conf);
gp_save_loudspeakers('data/array_inf.txt',x0);
gp_save_matrix('data/sound_field_inf.dat',x,y,db(abs(P)));

%% ===== Truncated with round edge =======================================
% Create a circle
conf.secondary_sources.size = 0.6;
conf.secondary_sources.number = 942;
conf.secondary_sources.geometry = 'circle';
conf.secondary_sources.center = [-0.6 -0.3 0];
x0_circ = secondary_source_positions(conf);
% Create a line
conf.secondary_sources.size = 1.2;
conf.secondary_sources.number = 600;
conf.secondary_sources.geometry = 'line';
conf.secondary_sources.center = [0 0 0];
x0_line = secondary_source_positions(conf);
% Combine them
x0 = [x0_circ(472:-1:236,:); ...
    x0_line; ...
    bsxfun(@plus,x0_circ(236:-1:1,:),[1.2 0 0 0 0 0 0])];
conf.secondary_sources.geometry = 'custom';
conf.secondary_sources.x0 = x0;
[P,x,y] = sound_field_mono_wfs(X,Y,Z,xs,src,f,conf);
gp_save_loudspeakers('data/array_truncated_round.txt',x0);
gp_save_matrix('data/sound_field_truncated_round.dat',x,y,db(abs(P)));

rmpath('../../matlab');
