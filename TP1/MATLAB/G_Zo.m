function G_Zo(spice_directory, points_directory, ...
    images_directory, close_figures)

% Init
fprintf('Zo:\n\n');

graph_complete_dir = ...
    fullfile(images_directory, ...
    points_directory);


[~, ~] = mkdir(graph_complete_dir);

if (7 ~= exist(graph_complete_dir, 'dir'))
    error('Could not create directory: "%s".\n', graph_complete_dir);
end


z_simulation_colors = [1 0.4 0.1; 0.1 0.4 1];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ri.

simulation_name = 'amplifier_Zo';

simulation_title = strjoin({'Impedancia de ', ...
    'salida $\left( Z_{o} \right)$.'}, '');

simulation_freq_limits = [1E1 1E9];

simulation_freq_ticks = 10.^(1:1:9);

simulation_mod_limits = [0 25];

simulation_mod_ticks = (0:1:25);

simulation_ang_limits = [-100 100];

simulation_ang_ticks = (-100:10:100);


graphic_handle = aab_impedance(...
    fullfile(spice_directory, ...
    strjoin({simulation_name, '.txt'}, '')), ...
    simulation_title, ...
    100, z_simulation_colors, ...
    simulation_freq_limits, simulation_freq_ticks, ...
    simulation_mod_limits, simulation_mod_ticks, ...
    simulation_ang_limits, simulation_ang_ticks, ...
    0, 1000);

image_file_name = fullfile(images_directory, ...
    points_directory, ...
    strjoin({simulation_name, '.png'}, ''));

fprintf('Salvando el gráfico en un archivo "PNG"......');

% Salvo el gráfico en un archivo.
saveas(graphic_handle, image_file_name);

% Cierro el gráfico luego de salvado.
if (close_figures)
    close(graphic_handle);
end

% Salvado completo.
fprintf('Listo\n\n');
%%%


% Execute crop script.
olddir = cd(fullfile(images_directory, ...
    points_directory));

[status,~] = system('crop.cmd');

if status
    warning('%s.\n', 'Cannot execute system command.');
end

cd(olddir);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




end

