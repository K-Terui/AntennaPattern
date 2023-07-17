% Sample code for computing array factors and plotting directivity
% Refer to the following and modify the code
% http://www.takuichi.net/hobby/edu/em/array/af/arrayfactor.pdf

clear

%% initialization
k0=2*pi; %wavenumber
%elevation
phi_deg=0.;                   %[deg]
phi=phi_deg*(pi/180.);        %[rad]
%azimuth
theta = (0 : 180)/180*pi;     %[rad]
arr_theta_deg = theta/pi*180; %[deg]
n=6;
d=0.5;

%% complex weight
w = ones(1,6);

%% array factor
AF = arrayfactor(w, theta, phi);

%% plot
plot(arr_theta_deg,20*log10(AF)) %dB
ylim([-50 0])

