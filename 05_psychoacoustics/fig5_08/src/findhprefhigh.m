function [hprefhigh] = findhprefhigh(conf)
%FINDHPREFHIGH estimates the aliasing frequency from the spectrum

% Calculate spectrum for central position
X = [0 0 0];
head_orientation = pi/2;
xs = [0 2.5 0];
src = 'ps';
hrtf = dummy_irs(conf);
conf.wfs.hprefhigh = aliasing_frequency(conf);
ir = ir_wfs(X,head_orientation,xs,src,hrtf,conf);
[magnitude,~,f] = spectrum_from_signal(ir(:,1),conf);
% Differentiate spectrum and find first larger gradient
d = diff(db(magnitude));
idx = find(abs(d(10:end))>0.05,1,'first');
hprefhigh = round(f(idx));
