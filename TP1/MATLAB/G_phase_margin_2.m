function G_phase_margin_2(spice_directory, points_directory, ...
    images_directory, close_figures)


% Init
fprintf('Loop gain:\n\n');

graph_complete_dir = ...
    fullfile(images_directory, ...
    points_directory);


[~, ~] = mkdir(graph_complete_dir);

if (7 ~= exist(graph_complete_dir, 'dir'))
    error('Could not create directory: "%s".\n', graph_complete_dir);
end



bode_simulation_colors = [1 0.4 0.1; 0.1 0.4 1];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LOOP.

simulation_name = 'amplifier_LOOP_2';

simulation_save_name = 'gain_loop_2';

simulation_title = strjoin({'Ganancia de lazo ', ...
    '$ \left( a \cdot f \right)', ...
    '_{ \left( j \cdot \omega \right)} $'}, '');

simulation_mod_limits = [-120 130];

simulation_mod_ticks = (-120:15:130);

simulation_ang_limits = [-400 20];

simulation_ang_ticks = unique(sort([(-400 :20: 20) -180]), 'first');

graphic_handle = aab_loop_gain(...
    fullfile(spice_directory, ...
    strjoin({simulation_name, '.txt'}, '')), ...
    simulation_title, ...
    100, bode_simulation_colors, ...
    simulation_mod_limits, simulation_mod_ticks, ...
    simulation_ang_limits, simulation_ang_ticks);

image_file_name = fullfile(images_directory, ...
    points_directory, ...
    strjoin({simulation_save_name, '.png'}, ''));

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

[status,~] = system('..\..\crop.cmd');

if status
    warning('%s.\n', 'Cannot execute system command.');
end

cd(olddir);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end



