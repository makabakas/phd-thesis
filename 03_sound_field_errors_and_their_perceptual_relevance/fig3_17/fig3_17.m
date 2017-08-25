% calculate ITD values for different SFS setups
clear all
addpath('../../matlab');
create_dir('data');

%% ===== Configuration ===================================================
X = [0 0.5 1.0]; % / m
Y = [0 0 0]; % / m
Z = 0; % / m
phi = pi/2;
xs = [0 2.5 0];
src = 'ps';
runs = 5*length(X);

%% ===== Toolbox settings ================================================
conf = SFS_config;
conf.usetapwin = false;
conf.wfs.hpreflow =  10;
conf.N = 2048;
conf.ir.usehcomp = false;

%% ===== Secondary Sources ===============================================
conf.secondary_sources.size = 3; % / m
conf.secondary_sources.center = [0 0 0]; % / m
conf.secondary_sources.geometry = 'circle';

%% ===== Main ============================================================
hrtf = SOFAload('../../matlab/KEMAR_HRTFs_lfcorr.sofa');
load('../../matlab/lookup.mat');
noise_sig = noise(44100,1,'pink');

% ----- without aliasing -------------------------------------------------
conf.secondary_sources.number = 2000;
conf.nfchoa.order = 250;
%% --- NFC-HOA ---
for ii=1:length(X)
    ir = ir_nfchoa([X(ii) Y(ii) Z],phi,xs,src,hrtf,conf);
    [~,~,itd,~,fc] = wierstorf2013_estimateazimuth(auralize_ir(ir,noise_sig,1,conf),lookup_table,'include_outlier');
    gp_save(sprintf('nfchoa_X%1.2f_Y%1.2f.txt',X(ii),Y(ii)),[fc' itd']);
    progress_bar(ii,runs);
end
% --- WFS ---
conf.wfs.hprefhigh = 20000;
for ii=1:length(X)
    ir = ir_wfs([X(ii) Y(ii) Z],phi,xs,src,hrtf,conf);
    [~,~,itd,~,fc] = wierstorf2013_estimateazimuth(auralize_ir(ir,noise_sig,1,conf),lookup_table,'include_outlier');
    gp_save(sprintf('data/wfs_X%1.2f_Y%1.2f.txt',X(ii),Y(ii)),[fc' itd']);
    progress_bar(ii+length(X),runs);
end

% ----- with aliasing ----------------------------------------------------
conf.secondary_sources.number = 22;
% --- NFC-HOA ---
conf.nfchoa.order = 250;
for ii=1:length(X)
    ir = ir_nfchoa([X(ii) Y(ii) Z],phi,xs,src,hrtf,conf);
    [~,~,itd,~,fc] = wierstorf2013_estimateazimuth(auralize_ir(ir,noise_sig,1,conf),lookup_table,'include_outlier');
    gp_save(sprintf('data/nfchoa_X%1.2f_Y%1.2f_nls22.txt',X(ii),Y(ii)),[fc' itd']);
    progress_bar(ii+2*length(X),runs);
end
% --- band limited NFC-HOA ---
conf.nfchoa.order = [];
for ii=1:length(X)
    ir = ir_nfchoa([X(ii) Y(ii) Z],phi,xs,src,hrtf,conf);
    [~,~,itd,~,fc] = wierstorf2013_estimateazimuth(auralize_ir(ir,noise_sig,1,conf),lookup_table,'include_outlier');
    gp_save(sprintf('data/nfchoa_X%1.2f_Y%1.2f_nls22_band_limited.txt',X(ii),Y(ii)),[fc' itd']);
    progress_bar(ii+3*length(X),runs);
end 
% --- WFS ---
conf.wfs.hprefhigh = 1500;
for ii=1:length(X)
    ir = ir_wfs([X(ii) Y(ii) Z],phi,xs,src,hrtf,conf);
    [~,~,itd,~,fc] = wierstorf2013_estimateazimuth(auralize_ir(ir,noise_sig,1,conf),lookup_table,'include_outlier');
    gp_save(sprintf('data/wfs_X%1.2f_Y%1.2f_nls22.txt',X(ii),Y(ii)),[fc' itd']);
    progress_bar(ii+4*length(X),runs);
end

rmpath('../../matlab');
