function AF = arrayfactor(w, theta, phi)
% calculate the array factor for directivity plot
% considering: ULA
% Input
%   w    : complex weight of array antenna
%   theta: angle of azimuth [rad]
% Output
%   absAF: absolute value of array factor

%% initialization
k0 = 2*pi; %wavenumber
d  = 0.5;
w  = reshape(w, 1, []);
n  = size(w, 2);
theta = reshape(theta, 1, []);
AFiso = ones(length(theta),1); %isotropic antenna gain
%% positions of each element
for i=1:n
    x(i)=0.; y(i)=0.; z(i)=(i-1)*d; 
end

%% array factor
absAF = abs(sum(w .* exp(1i * k0 * (z .* cos(theta'))), 2)); %ULA
% absAF = abs(sum(w .* exp(1i * k0 * (sin(theta') .* (x * cos(phi) + y * sin(phi)) + z .* cos(theta'))), 2)); %UPA

%% normalized array factor with isotropic antenna
AF = absAF ./ AFiso;
end
