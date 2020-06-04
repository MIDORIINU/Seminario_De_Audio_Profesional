%Close images.
close all;

% Clean command line.
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create directories.

spice_directory = fullfile('..', 'SIMS');

images_directory = fullfile('..', 'informe', 'img');

[~, ~] = mkdir(images_directory);

if (7 ~= exist(images_directory, 'dir'))
    error('Could not create directory: "%s".\n', images_directory);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 
% G_thd_vs_Power_sim(spice_directory, ... % Check.
%     fullfile('simulaciones', 'THD'), ...
%     images_directory, false);
% 
% G_thd_vs_Power(spice_directory, ... % Check.
%     fullfile('mediciones', 'THD'), ...
%     images_directory, false);
% 
% G_thd_vs_Freq_sim(spice_directory, ... % Check.
%     fullfile('simulaciones', 'THD'), ...
%     images_directory, false);
% 
% G_thd_vs_Freq(spice_directory, ... % Check.
%     fullfile('mediciones', 'THD'), ...
%     images_directory, false);
% 
% G_Zi(spice_directory, fullfile('simulaciones', 'Impedance'), ... % Check.
%     images_directory, false);
% 
% G_Zo(spice_directory, fullfile('simulaciones', 'Impedance'), ... % Check.
%     images_directory, false);

G_phase_margin(spice_directory, fullfile('simulaciones', 'Loop'), ... % Check.
    images_directory, false);

% G_power_BW_sim(spice_directory, fullfile('simulaciones', 'BW'), ... % Check.
%     images_directory, false);
% 
% G_low_power_BW_sim(spice_directory, fullfile('simulaciones', 'BW'), ... % Check.
%     images_directory, false);
% 
% G_Slew_Rate(spice_directory, fullfile('simulaciones', 'Slew_Rate'), ... % Check.
%     images_directory, false);
% 
% G_eff_vs_Power(spice_directory, ... % Check.
%     fullfile('simulaciones', 'Efficiency'), ...
%     images_directory, false);

% close all;






