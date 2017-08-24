clear all
addpath('./src');

%% ===== Configuration ===================================================
X_center = [-0.1 0 0];
X_offcenter = [-1.1 0 0];
head_orientation = [pi/2 0];
xs = [0 2.5 0];
src = 'ps';
number_of_speakers = [14 28 56 112 224 448 896 1792 3584];
% flow and fhigh were originally calculated by a script that runs only with
% version 0.2.2 of the SFS Toolbox. For details you might want to have a look at
% https://github.com/hagenw/phd-thesis/tree/master/05_psychoacoustics/fig5_08/matlab
% This resulted in the following values:
%flow = [50 1 1 1 1 1 1 1 1];
%fhigh = [410 786 1842 3589 3965 4260 6710 7051 10491];

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
hrtf = dummy_irs(conf);
spectra_center = zeros(4097,length(number_of_speakers)+1);
spectra_offcenter = spectra_center;

%% ===== Stereo ==========================================================
% --- Center ---
ir_1 = ir_point_source(X_center,head_orientation,[ 1.4434 2.5 0],hrtf,conf);
ir_2 = ir_point_source(X_center,head_orientation,[-1.4434 2.5 0],hrtf,conf);
ir = ir_1 + ir_2;
ir = ir ./ max(abs(ir(:)));
[magnitude,~,f] = spectrum_from_signal(ir(:,1),conf);
spectra_center(:,1) = magnitude;
% --- Off-center ---
ir_1 = ir_point_source(X_offcenter,head_orientation,[ 1.4434 2.5 0],hrtf,conf);
ir_2 = ir_point_source(X_offcenter,head_orientation,[-1.4434 2.5 0],hrtf,conf);
ir = ir_1 + ir_2;
ir = ir ./ max(abs(ir(:)));
[magnitude,~,f] = spectrum_from_signal(ir(:,1),conf);
spectra_offcenter(:,1) = magnitude;

%% ===== Wave Field Synethsis ============================================
for ii=1:length(number_of_speakers)

    conf.secondary_sources.number = number_of_speakers(ii);
    conf.wfs.hpreflow = 50;
    conf.wfs.hprefhigh = findhprefhigh(conf);

    % --- Center ---
    ir = ir_wfs(X_center,head_orientation,xs,src,hrtf,conf);
    ir = ir ./ max(abs(ir(:)));
    [magnitude,~,f] = spectrum_from_signal(ir(:,1),conf);
    spectra_center(:,ii+1) = magnitude;
    % --- Off-center ---
    ir = ir_wfs(X_offcenter,head_orientation,xs,src,hrtf,conf);
    ir = ir ./ max(abs(ir(:)));
    [magnitude,~,f] = spectrum_from_signal(ir(:,1),conf);
    spectra_offcenter(:,ii+1) = magnitude;

    progress_bar(ii,length(number_of_speakers));
end

gp_save('../data/coloration_wfs_freq_response_center.txt',[f spectra_center]);
gp_save('../data/coloration_wfs_freq_response_off-center.txt',[f spectra_offcenter]);

rmpath('./src');
