clear all
addpath('../fig5_08/src');

%% ===== Configuration ===================================================
X = [ ...
    [ 0.00  0.00  0.00]; ...
    [-0.25  0.00  0.00]; ...
    [-0.50  0.00  0.00]; ...
    [-0.75  0.00  0.00]; ...
    [-1.00  0.00  0.00]; ...
    [-1.25  0.00  0.00]; ...
    [-0.25 -0.50  0.00]; ...
    [-0.50 -0.50  0.00]; ...
    [-0.75 -0.50  0.00]; ...
    [-1.00 -0.50  0.00]; ...
    [-1.25 -0.50  0.00]; ...
    ];
X = bsxfun(@minus,X,[0.1 0 0]);
head_orientation = pi/2;
xs = [0 2.5 0];
src = 'ps';

%% ===== Toolbox settings ================================================
conf=SFS_config;
conf.fs = 48000;
conf.N = 8192;
conf.ir.usehcomp = false;
conf.delayline.resampling = 'pm';
conf.delayline.resamplingfactor = 8;
conf.delayline.resamplingorder = 64;
conf.delayline.filter = 'lagrange';
conf.delayline.filterorder = 9; 
conf.secondary_sources.number = 56;
conf.hprefhigh = findhprefhigh(conf);
hrtf = dummy_irs(conf);
spectra = zeros(4097,size(X,1));

%% ===== Wave Field Synthesis ============================================
for ii=1:size(X,1)
    ir = ir_wfs(X(ii,:),head_orientation,xs,src,hrtf,conf);
    ir = ir ./ max(abs(ir(:)));
    [magnitude,~,f] = spectrum_from_signal(ir(:,1),conf);
    spectra(:,ii) = magnitude;
    progress_bar(ii,size(X,1));
end

gp_save('data/coloration_wfs_freq_resp_moving.txt',[f spectra]);

rmpath('../fig5_08/src');
