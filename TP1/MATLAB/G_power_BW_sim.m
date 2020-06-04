function G_power_BW_sim(spice_directory, points_directory, ...
    images_directory, close_figures)

% Init
fprintf('Power BW:\n\n');

graph_complete_dir = ...
    fullfile(images_directory, ...
    points_directory);


[~, ~] = mkdir(graph_complete_dir);

if (7 ~= exist(graph_complete_dir, 'dir'))
    error('Could not create directory: "%s".\n', graph_complete_dir);
end



bode_simulation_colors = [1 0.4 0.1; 0.1 0.4 1];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RF.

simulation_name = 'amplifier_POWER_BW';

simulation_save_name = 'Power_BW';

simulation_title ="Ancho de banda de potencia (40 W)";

simulation_mod_limits = [0 42];

simulation_mod_ticks = (0:2:65);

simulation_ang_limits = [-1300 0];

simulation_ang_ticks = unique(sort([(-1200:100:0) 0]), 'first');

graphic_handle = aab_power_rf(...
    fullfile(spice_directory, ...
    strjoin({simulation_name, '.txt'}, '')), ...
    simulation_title, ...
    100, bode_simulation_colors, ...
    simulation_mod_limits, simulation_mod_ticks, ...
    simulation_ang_limits, simulation_ang_ticks);

%%%
graph_complete_name = ...
    fullfile(graph_complete_dir, ...
    strjoin({simulation_save_name, ...
    '.png'}, ''));

fprintf('Salvando el gráfico en un archivo "PNG"......');

% Salvo el gráfico en un archivo.
saveas(graphic_handle, graph_complete_name);

if (close_figures)
    close(figure1);
end

% Salvado completo.
fprintf('Listo\n\n');
%%%


% Execute crop script.
olddir = cd(graph_complete_dir);

[status,~] = system('crop.cmd');

if status
    warning('%s.\n', 'Cannot execute system command.');
end

cd(olddir);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



end

