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
theta = (0 : 360)/180*pi;     %[rad]
arr_theta_deg = theta/pi*180; %[deg]
n=16;
d=0.5;

%% complex weight
wuni = ones(1,n) / sqrt(n);   %uniform distribution
%binomial distribution
wbin = 0;
for k = 0:n-1
    wbin = horzcat(wbin, nchoosek(n-1, k));
end
wbin = wbin(2:end);
wbin = wbin/norm(wbin, 'fro');

%% array factor
AFiso = ones(length(theta),1); %isotropic antenna gain
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
ylim([-40 20])
xlim([0 180])
legend([pbin, puni], {'Binomial beam', 'Uniform dist.'}, 'Interpreter', 'latex', 'FontSize', 15, 'Location','northeast')
xticks([0 45 90 135 180])
ax = gca;
ax.XAxis.FontSize = 15;
ax.YAxis.FontSize = 15;
xlabel('Azimuth [deg]', 'Interpreter', 'latex')
ylabel('Array gain [dB]', 'Interpreter', 'latex')

figure(2) %with normalization
rmin = -40; %minimum value of r axis
rmax = 20;   %maximum value of r axis
%converted to dB value and normalization
AFisodB = 20*log10(AFiso);
AFunidB = 20*log10(AFuni);
AFbindB = 20*log10(AFbin);
%calcualte the minimum value to satisfy the r-axis threshold
unimin = min(AFunidB(find(AFunidB>rmin)));
binmin = min(AFbindB(find(AFbindB>rmin)));
%rewrite values below the r-axis threshold to the smallest value above the r-axis threshold
AFunidB(find(AFunidB<rmin)) = unimin;    
AFbindB(find(AFbindB<rmin)) = binmin;

ppiso = polarplot(theta, AFisodB, 'k:', 'LineWidth', 2);
hold on
ppuni = polarplot(theta, AFunidB, '-' , 'Color', [0 0.5 0], 'LineWidth', 2);
ppbin = polarplot(theta, AFbindB, '-.', 'Color', [1 0.5 0], 'LineWidth', 2);
legend([ppbin, ppuni, ppiso], {'Binomial beam', 'Uniform dist.', 'Isotropic'}, 'Interpreter', 'latex', 'FontSize', 15, 'Position',[0.63,0.77,0.25,0.10])
rlim([rmin rmax])
ax = gca;
ax.GridAlpha = 1;
