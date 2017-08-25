% create the data for the monochromatic sound field plots
clear all
addpath('../../matlab');
create_dir('data');

%% ===== Configuration ===================================================
X = [0 0.75 0]; % / m
Y = [0 0 0.75]; % / m
Z = 0; % / m
xs = [0 -1 0];
src = 'pw';
runs = 5*length(X);

%% ===== Toolbox settings ================================================
conf = SFS_config;
conf.resolution = 1000; % / samples
conf.usetapwin = false;
conf.nfchoa.order = [];

%% ===== Secondary Sources ===============================================
conf.secondary_sources.size = 3; % / m
conf.secondary_sources.center = [0 0 0]; % / m
conf.secondary_sources.geometry = 'circle';

%% ===== without aliasing ================================================
conf.secondary_sources.number = 4000;
% --- NFCHOA
for ii=1:length(X)
    [S,f] = freq_response_nfchoa([X(ii) Y(ii) Z],xs,src,conf);
    gp_save(sprintf('data/freq_response_nfchoa_X%1.2f_Y%1.2f.txt',X(ii),Y(ii)),[f S]);
    progress_bar(ii,runs);
end
% --- WFS
for ii=1:length(X)
    [S,f] = freq_response_wfs([X(ii) Y(ii) Z],xs,src,conf);
    gp_save(sprintf('data/freq_response_wfs_X%1.2f_Y%1.2f.txt',X(ii),Y(ii)),[f S]);
    progress_bar(ii+length(X),runs);
end

% ===== with aliasing ===================================================
conf.secondary_sources.number = 64;
conf.nfchoa.order = 256;
% --- NFCHOA
for ii=1:length(X)
    [S,f] = freq_response_nfchoa([X(ii) Y(ii) Z],xs,src,conf);
    gp_save(sprintf('data/freq_response_nfchoa_X%1.2f_Y%1.2f_nls64.txt',X(ii),Y(ii)),[f S]);
    progress_bar(ii+2*length(X),runs);
end
% --- band limited NFCHOA
conf.nfchoa.order = [];
for ii=1:length(X)
    [S,f] = freq_response_nfchoa([X(ii) Y(ii) Z],xs,src,conf);
    gp_save(sprintf('data/freq_response_nfchoa_X%1.2f_Y%1.2f_nls64_band_limited.txt', ...
        X(ii),Y(ii)),[f S]);
    progress_bar(ii+3*length(X),runs);
end
% --- WFS
for ii=1:length(X)
    [S,f] = freq_response_wfs([X(ii) Y(ii) Z],xs,src,conf);
    gp_save(sprintf('data/freq_response_wfs_X%1.2f_Y%1.2f_nls64.txt',X(ii),Y(ii)),[f S]);
    progress_bar(ii+4*length(X),runs);
end

rmpath('../../matlab');
