function G_Zi(spice_directory, points_directory, ...
    images_directory, close_figures)

% Init
fprintf('Zi:\n\n');

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

simulation_name = 'amplifier_Zi';

simulation_title = strjoin({'Impedancia de ', ...
    'entrada $\left( Z_{i} \right)$.'}, '');

simulation_freq_limits = [10 1E9];

simulation_freq_ticks = 10.^(1:1:9);

simulation_mod_limits = [0 50E3];

simulation_mod_ticks = (0:2E3:50E3);

simulation_ang_limits = [-90 10];

simulation_ang_ticks = (-90:10:10);


graphic_handle = aab_impedance(...
    fullfile(spice_directory, ...
    strjoin({simulation_name, '.txt'}, '')), ...
    simulation_title, ...
    100, z_simulation_colors, ...
    simulation_freq_limits, simulation_freq_ticks, ...
    simulation_mod_limits, simulation_mod_ticks, ...
    simulation_ang_limits, simulation_ang_ticks, ...
    3, 1000);

image_file_name = fullfile(graph_complete_dir, ...
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

