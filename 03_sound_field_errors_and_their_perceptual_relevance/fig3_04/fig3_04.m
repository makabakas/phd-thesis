% Create sound field simulations for a linear array and WFS with and without
% tapering window to show the edge waves
clear all;
addpath('../../matlab');
create_dir('data');

%% ===== Configuration ===================================================
conf = SFS_config;
X = [-1.25 1.25]; % / m
Y = [-2.25 0.25]; % / m
Z = 0; % / m
t = 205/conf.fs; % / s
xs = [0 -1 0];
src = 'pw';

%% ===== Toolbox settings ================================================
conf.resolution = 1000; % / samples
conf.xref = [4.5 -2 0]; % / m
conf.N = 1024;
conf.wfs.hprefhigh = 20000;
conf.tapwinlen = 0.06;
conf.showprogress = true;

%% ===== Secondary Sources ===============================================
conf.secondary_sources.size = 10;
conf.secondary_sources.number = 1000;
conf.secondary_sources.geometry = 'line';
conf.secondary_sources.center = [4.5 0 0];
x0 = secondary_source_positions(conf);
x0 = secondary_source_selection(x0,xs,src);
gp_save_loudspeakers('data/array.txt',x0);

%% ===== Time signal ======================================================
% Get time signal to visualize driving signals
pulse = [hann_window(5,5,10); zeros(50,1); ...
         hann_window(5,5,10); zeros(50,1); hann_window(5,5,10)];

%% ===== Get driving signals =============================================
d = driving_function_imp_wfs(x0,xs,src,conf);
d = convolution(d,pulse);

%% Without tapering ======================================================
conf.usetapwin = false;
[p,x,y] = sound_field_imp(X,Y,Z,x0,'ps',d,t,conf);
gp_save_matrix('data/wfs_notapering.dat',x,y,real(p));

%% With tapering =========================================================
conf.usetapwin = true;
x0 = secondary_source_tapering(x0,conf);
[p,x,y] = sound_field_imp(X,Y,Z,x0,'ps',d,t,conf);
gp_save_matrix('data/wfs_tapering.dat',x,y,real(p));

rmpath('../../matlab');
