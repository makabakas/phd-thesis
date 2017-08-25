clear all;
addpath('../../matlab');
create_dir('data');

%% ===== Configuration ===================================================
conf = SFS_config;
X = [0 0.75 0]; % / m
Y = [0 0 -0.75]; % / m
Z = [0 0 0]; % / m
t = (1:500)'/conf.fs; % / samples
xs = [0 0.5 0 0 -1 0];
src = 'fs';

%% ===== Toolbox settings ================================================
conf.resolution = 1000; % / samples
conf.N = 1024;
conf.wfs.hpreflow = 1;
conf.wfs.hprefhigh = 20000;
conf.usetapwin = false;
conf.delayline.resampling = 'pm';
conf.delayline.resamplingfactor = 8;
conf.delayline.resamplingorder = 64;
conf.delayline.filter = 'lagrange';
conf.delayline.filterorder = 9;  

%% ===== Secondary Sources ===============================================
conf.secondary_sources.size = 3;
conf.secondary_sources.geometry = 'circle';
conf.secondary_sources.center = [0 0 0];

%% ===== Time signal ======================================================
% Get time signal to visualize driving signals
pulse = hann_window(5,5,10);

%% ===== Continuous secondary sources =====================================
conf.secondary_sources.number = 500;
x0 = secondary_source_positions(conf);
% --- WFS ---
x0 = secondary_source_selection(x0,xs,src);
x0 = secondary_source_tapering(x0,conf);
d = driving_function_imp_wfs(x0,xs,src,conf);
d = convolution(d,pulse);
for jj=1:length(X)
    p = zeros(size(t));
    for ii=1:length(t)
        progress_bar(ii,length(t))
        % Add 64 samples offset to the time because of the pre-equalization
        % filter
        p(ii) = sound_field_imp(X(jj),Y(jj),Z(jj),x0,'ps',d,t(ii)+64/conf.fs,conf);
    end
    gp_save(sprintf('data/wfs_X%.2f_Y%.2f.txt',X(jj),Y(jj)),[t p]);
end

%% ===== Sampled swecondary sources ======================================
conf.secondary_sources.number = 64;
x0 = secondary_source_positions(conf);
% --- WFS ---
x0 = secondary_source_selection(x0,xs,src);
x0 = secondary_source_tapering(x0,conf);
d = driving_function_imp_wfs(x0,xs,src,conf);
d = convolution(d,pulse);
for jj=1:length(X)
    p = zeros(size(t));
    for ii=1:length(t)
        progress_bar(ii,length(t))
        % Add 64 samples offset to the time because of the pre-equalization
        % filter
        p(ii) = sound_field_imp(X(jj),Y(jj),Z(jj),x0,'ps',d,t(ii)+64/conf.fs,conf);
    end
    gp_save(sprintf('data/wfs_X%.2f_Y%.2f_nls64.txt',X(jj),Y(jj)),[t p]);
end

rmpath('../../matlab');
