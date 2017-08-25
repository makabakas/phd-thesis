% create sound field simulations for a linear array and WFS with and without
% tapering window to show the edge waves
clear all;
addpath('../../matlab');
create_dir('data');

%% ===== Configuration ===================================================
conf = SFS_config;
X = [-1.75 1.75]; % / m
Y = [-1.75 1.75]; % / m
Z = 0; % / m
t = 205/conf.fs; % / s
xs = [0 -1 0];
src = 'pw';

%% ===== Toolbox settings ================================================
conf.resolution = 1000; % / samples
conf.N = 1024;
conf.wfs.hprefhigh = 20000;
conf.usetapwin = false;

%% ===== Secondary Sources ===============================================
conf.secondary_sources.size = 3;
conf.secondary_sources.geometry = 'circle';
conf.secondary_sources.center = [0 0 0];

%% ===== Time signal ======================================================
% get time signal to visualize driving signals
pulse = hann_window(5,5,10);

%% ===== Continuous secondary sources =====================================
conf.secondary_sources.number = 500;
conf.nfchoa.order = 250;
x0 = secondary_source_positions(conf);
% --- NFCHOA
d = driving_function_imp_nfchoa(x0,xs,src,conf);
d = convolution(d,pulse);
[p,x,y] = sound_field_imp(X,Y,Z,x0,'ps',d,t,conf);
progress_bar(1,5);
gp_save_loudspeakers('data/array.txt',x0);
gp_save_matrix('data/nfchoa.dat',x,y,real(p));
% --- WFS
x0 = secondary_source_selection(x0,xs,src);
x0 = secondary_source_tapering(x0,conf);
d = driving_function_imp_wfs(x0,xs,src,conf);
d = convolution(d,pulse);
[p,x,y] = sound_field_imp(X,Y,Z,x0,'ps',d,t+64/conf.fs,conf);
progress_bar(2,5);
gp_save_loudspeakers('data/array_wfs.txt',x0);
gp_save_matrix('data/wfs.dat',x,y,real(p));

%% ===== Sampled swecondary sources ======================================
conf.secondary_sources.number = 64;
x0 = secondary_source_positions(conf);
% --- NFCHOA
d = driving_function_imp_nfchoa(x0,xs,src,conf);
d = convolution(d,pulse);
[p,x,y] = sound_field_imp(X,Y,Z,x0,'ps',d,t,conf);
progress_bar(3,5);
gp_save_loudspeakers('data/array_nls64.txt',x0);
gp_save_matrix('data/nfchoa_nls64.dat',x,y,real(p));
% --- NFCHOA band limited
conf.nfchoa.order = [];
d = driving_function_imp_nfchoa(x0,xs,src,conf);
d = convolution(d,pulse);
[p,x,y] = sound_field_imp(X,Y,Z,x0,'ps',d,t,conf);
progress_bar(4,5);
gp_save_matrix('data/nfchoa_nls64_band_limited.dat',x,y,real(p));
% --- WFS
x0 = secondary_source_selection(x0,xs,src);
x0 = secondary_source_tapering(x0,conf);
d = driving_function_imp_wfs(x0,xs,src,conf);
d = convolution(d,pulse);
[p,x,y] = sound_field_imp(X,Y,Z,x0,'ps',d,t+64/conf.fs,conf);
progress_bar(5,5);
gp_save_loudspeakers('data/array_wfs_nls64.txt',x0);
gp_save_matrix('data/wfs_nls64.dat',x,y,real(p));

rmpath('../../matlab');
