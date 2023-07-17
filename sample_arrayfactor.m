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
wuni = ones(1,6);   %uniform distribution
wbin = [1 4 6 4 1]; %binomial distribution

%% array factor
AFuni = arrayfactor(wuni, theta, phi);
AFbin = arrayfactor(wbin, theta, phi);
%%%%%%%%%% note %%%%%%%%%%
%If we focus on a single beam, we need to normalize by the maximum array factor.
% %
% % absAF = arrayfactor(w, theta, phi);
% % AF = absAF ./ max(absAF);
% %
%%%%%%%%%% note %%%%%%%%%%

%% plot
figure(1)
set(groot,'defaultAxesTickLabelInterpreter','latex');
hold on
grid on
box on
puni = plot(arr_theta_deg,20*log10(AFuni),'-' ,'Color',[0 0.5 0],'LineWidth',2);
pbin = plot(arr_theta_deg,20*log10(AFbin),'-.','Color',[1 0.5 0],'LineWidth',2);
ylim([-50 30])
xlim([0 180])
legend([pbin, puni], {'Binomial beam', 'Uniform dist.'}, 'Interpreter', 'latex', 'FontSize', 15, 'Location','northeast')
xticks([0 45 90 135 180])
ax = gca;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
xlabel('Azimuth [deg]', 'Interpreter', 'latex')
ylabel('Array gain [dB]', 'Interpreter', 'latex')
