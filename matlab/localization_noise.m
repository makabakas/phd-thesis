function sig = localization_noise()
% Generate the noise signal used for the binaural model to predict the perceived
% direction
noise_length = 700;
pause_length = 300;
slope_length = 20;
fs = 44100;
% calculate samples from ms
noise_samples = round(noise_length/1000*fs);
pause_samples = round(pause_length/1000*fs);
slope_samples = round(slope_length/1000*fs);
% on- and offset slope
win = hann_window(slope_samples,slope_samples,noise_samples);
% bandpass filter
n=4;      % 2nd order butterworth filter
fnq=fs/2;  % Nyquist frequency
wn=[125/fnq 20000/fnq];    % butterworth bandpass non-dimensional frequency
[b,a]=butter(n,wn); % construct the filter
%
pause_sig = zeros(round(pause_samples/2),1);
sig_noise = noise(noise_samples,1,'white') .* win;
sig = [pause_sig; sig_noise; pause_sig];
sig = filtfilt(b,a,sig);
sig = sig(1:end-round(pause_samples/2));
