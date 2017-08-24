clear all

%% ===== Configuration ===================================================
X = [4 -4 0];
head_orientation = pi/2;
xs = [0 1 0];
src = 'ps';
content = 'data/speech.wav';
hrtf = SOFAload('../../matlab/KEMAR_HRTFs_lfcorr.sofa');

%% ===== SFS configuration ===============================================
conf = SFS_config;
conf.secondary_sources.number = 34;
conf.secondary_sources.size = 20;
conf.secondary_sources.geometry = 'linear';
conf.usetapwin = false;
conf.xref = [4 -4 0];
conf.N = 2*4096;
conf.wfs.usehpre = false;
conf.ir.usehcomp = true;
conf.ir.hcompfile = '../../matlab/QU_KEMAR_AKGK601_hcomp.wav';

%% ===== Wave Field Synthesis ============================================
ir = ir_wfs(X,head_orientation,xs,src,hrtf,conf);
% Shorten the impulse response
ir = ir(2000:6000,:);
% Calculate the spectrum
[magnitude,~,f] = spectrum_from_signal(ir(:,1),conf);
% Save time signal and spectrum
gp_save('data/wfs_point_source.txt',norm_signal(ir(:,1)),'magnitude');
gp_save('data/wfs_point_source_time_reversed.txt',norm_signal(ir(end:-1:1,1)),'magnitude');
gp_save('data/wfs_point_source_spectrum.txt',[f 20*log10(abs(magnitude))+90],'F/Hz magnitude');
% Generate audio files
sig1 = auralize_ir(ir,content,1,conf);
sig2 = auralize_ir(ir(end:-1:1,:),content,1,conf);
audiowrite('data/ir_wfs_point_source.wav',ir,44100,'BitsPerSample',16);
audiowrite('data/ir_wfs_point_source_time_reversed.wav',ir(end:-1:1,:),44100,'BitsPerSample',16);
audiowrite('data/wfs_point_source.wav',sig1,44100,'BitsPerSample',16);
audiowrite('data/wfs_point_source_time_reversed.wav',sig2,44100,'BitsPerSample',16);
