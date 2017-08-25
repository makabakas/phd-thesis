% create sound field simulations for a linear array and WFS with and without
% tapering window to show the edge waves
clear all;
addpath('../../matlab');
create_dir('data');

%% ===== Configuration ===================================================
conf = SFS_config;
X = [0 0.75 0]; % / m
Y = [0 0 0.75]; % / m
Z = 0; % / m
t = (1:500)'/conf.fs; % / s
xs = [0 -1 0];
src = 'pw';
runs = length(X)*length(t);

%% ===== Toolbox settings ================================================
conf.resolution = 1000; % / samples
conf.N = 1024;
conf.wfs.hpreflow = 10;
conf.wfs.hprefhigh = 20000;
conf.usebandpass = true;
conf.usetapwin = false;
conf.showprogress = false;
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
% get time signal to visualize driving signals
pulse = hann_window(5,5,10);

%%%%%%%%%% First run -- low pass %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
conf.bandpassflow = 10;
conf.bandpassfhigh = 2000;

%% ===== Continuous secondary sources =====================================
conf.secondary_sources.number = 500;
conf.nfchoa.order = 250;
x0 = secondary_source_positions(conf);
% --- NFC-HOA ---
d = driving_function_imp_nfchoa(x0,xs,src,conf);
d = convolution(d,pulse);
for jj=1:length(X)
    p = zeros(size(t));
    for ii=1:length(t)
        p(ii) = sound_field_imp(X(jj),Y(jj),Z,x0,'ps',d,t(ii),conf);
        progress_bar(ii+(jj-1)*length(t),10*runs);
    end
    gp_save(sprintf('data/lowpass_nfchoa_X%.2f_Y%.2f.txt',X(jj),Y(jj)),[t p]);
end
% --- WFS ---
x0 = secondary_source_selection(x0,xs,src);
x0 = secondary_source_tapering(x0,conf);
d = driving_function_imp_wfs(x0,xs,src,conf);
d = convolution(d,pulse);
for jj=1:length(X)
    p = zeros(size(t));
    for ii=1:length(t)
        p(ii) = sound_field_imp(X(jj),Y(jj),Z,x0,'ps',d,t(ii)+64/conf.fs,conf);
        progress_bar(ii+(jj-1)*length(t)+runs,10*runs);
    end
    gp_save(sprintf('data/lowpass_wfs_X%.2f_Y%.2f.txt',X(jj),Y(jj)),[t p]);
end

%% ===== Sampled swecondary sources ======================================
conf.secondary_sources.number = 64;
x0 = secondary_source_positions(conf);
% --- NFC-HOA ---
d = driving_function_imp_nfchoa(x0,xs,src,conf);
d = convolution(d,pulse);
for jj=1:length(X)
    p = zeros(size(t));
    for ii=1:length(t)
        p(ii) = sound_field_imp(X(jj),Y(jj),Z,x0,'ps',d,t(ii),conf);
        progress_bar(ii+(jj-1)*length(t)+2*runs,10*runs);
    end
    gp_save(sprintf('data/lowpass_nfchoa_X%.2f_Y%.2f_nls64.txt',X(jj),Y(jj)),[t p]);
end
% --- NFC-HOA band limited ---
conf.nfchoa.order = [];
d = driving_function_imp_nfchoa(x0,xs,src,conf);
d = convolution(d,pulse);
for jj=1:length(X)
    p = zeros(size(t));
    for ii=1:length(t)
        p(ii) = sound_field_imp(X(jj),Y(jj),Z,x0,'ps',d,t(ii),conf);
        progress_bar(ii+(jj-1)*length(t)+3*runs,10*runs);
    end
    gp_save(sprintf('data/lowpass_nfchoa_X%.2f_Y%.2f_nls64_band_limited.txt',X(jj),Y(jj)),[t p]);
end
% --- WFS ---
x0 = secondary_source_selection(x0,xs,src);
x0 = secondary_source_tapering(x0,conf);
d = driving_function_imp_wfs(x0,xs,src,conf);
d = convolution(d,pulse);
for jj=1:length(X)
    p = zeros(size(t));
    for ii=1:length(t)
        p(ii) = sound_field_imp(X(jj),Y(jj),Z,x0,'ps',d,t(ii)+64/conf.fs,conf);
        progress_bar(ii+(jj-1)*length(t)+4*runs,10*runs);
    end
    gp_save(sprintf('data/lowpass_wfs_X%.2f_Y%.2f_nls64.txt',X(jj),Y(jj)),[t p]);
end


%%%%%%%%%% Second run -- high pass %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
conf.bandpassflow = 2000;
conf.bandpassfhigh = 20000;

%% ===== Continuous secondary sources =====================================
conf.secondary_sources.number = 500;
conf.nfchoa.order = 250;
x0 = secondary_source_positions(conf);
% --- NFC-HOA ---
d = driving_function_imp_nfchoa(x0,xs,src,conf);
d = convolution(d,pulse);
for jj=1:length(X)
    p = zeros(size(t));
    for ii=1:length(t)
        p(ii) = sound_field_imp(X(jj),Y(jj),Z,x0,'ps',d,t(ii),conf);
        progress_bar(ii+(jj-1)*length(t)+5*runs,10*runs);
    end
    gp_save(sprintf('data/highpass_nfchoa_X%.2f_Y%.2f.txt',X(jj),Y(jj)),[t p]);
end
% --- WFS ---
x0 = secondary_source_selection(x0,xs,src);
x0 = secondary_source_tapering(x0,conf);
d = driving_function_imp_wfs(x0,xs,src,conf);
d = convolution(d,pulse);
for jj=1:length(X)
    p = zeros(size(t));
    for ii=1:length(t)
        p(ii) = sound_field_imp(X(jj),Y(jj),Z,x0,'ps',d,t(ii)+64/conf.fs,conf);
        progress_bar(ii+(jj-1)*length(t)+6*runs,10*runs);
    end
    gp_save(sprintf('data/highpass_wfs_X%.2f_Y%.2f.txt',X(jj),Y(jj)),[t p]);
end

%% ===== Sampled swecondary sources ======================================
conf.secondary_sources.number = 64;
x0 = secondary_source_positions(conf);
% --- NFC-HOA ---
d = driving_function_imp_nfchoa(x0,xs,src,conf);
d = convolution(d,pulse);
for jj=1:length(X)
    p = zeros(size(t));
    for ii=1:length(t)
        p(ii) = sound_field_imp(X(jj),Y(jj),Z,x0,'ps',d,t(ii),conf);
        progress_bar(ii+(jj-1)*length(t)+7*runs,10*runs);
    end
    gp_save(sprintf('data/highpass_nfchoa_X%.2f_Y%.2f_nls64.txt',X(jj),Y(jj)),[t p]);
end
% --- NFC-HOA band limited ---
conf.nfchoa.order = [];
d = driving_function_imp_nfchoa(x0,xs,src,conf);
d = convolution(d,pulse);
for jj=1:length(X)
    p = zeros(size(t));
    for ii=1:length(t)
        p(ii) = sound_field_imp(X(jj),Y(jj),Z,x0,'ps',d,t(ii),conf);
        progress_bar(ii+(jj-1)*length(t)+8*runs,10*runs);
    end
    gp_save(sprintf('data/highpass_nfchoa_X%.2f_Y%.2f_nls64_band_limited.txt',X(jj),Y(jj)),[t p]);
end
% --- WFS ---
x0 = secondary_source_selection(x0,xs,src);
x0 = secondary_source_tapering(x0,conf);
d = driving_function_imp_wfs(x0,xs,src,conf);
d = convolution(d,pulse);
for jj=1:length(X)
    p = zeros(size(t));
    for ii=1:length(t)
        p(ii) = sound_field_imp(X(jj),Y(jj),Z,x0,'ps',d,t(ii)+64/conf.fs,conf);
        progress_bar(ii+(jj-1)*length(t)+9*runs,10*runs);
    end
    gp_save(sprintf('data/highpass_wfs_X%.2f_Y%.2f_nls64.txt',X(jj),Y(jj)),[t p]);
end

rmpath('../../matlab');
