function Hd = elliptic_filter
%ELLIPTIC_FILTER Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 23.2 and Signal Processing Toolbox 23.2.
% Generated on: 01-Nov-2023 17:22:45

% Elliptic Lowpass filter designed using FDESIGN.LOWPASS.

% All frequency values are in Hz.
Fs = 250;  % Sampling Frequency

N     = 2;   % Order
Fpass = 50;  % Passband Frequency
Apass = 1;   % Passband Ripple (dB)
Astop = 80;  % Stopband Attenuation (dB)

% Construct an FDESIGN object and call its ELLIP method.
h  = fdesign.lowpass('N,Fp,Ap,Ast', N, Fpass, Apass, Astop, Fs);
Hd = design(h, 'ellip');

% [EOF]
