function G_step_big_signal(spice_directory, points_directory, ...
    images_directory, close_figures)


% Init
fprintf('Slew Rate:\n\n');

graph_complete_dir = ...
    fullfile(images_directory, ...
    points_directory);


[~, ~] = mkdir(graph_complete_dir);

if (7 ~= exist(graph_complete_dir, 'dir'))
    error('Could not create directory: "%s".\n', graph_complete_dir);
end



time_simulation_color_list = [1 0.4 0.1; 0.4 0.1 1];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DYNAMIC RESPONSE.

simulation_name = 'amplifier_SR';

simulation_save_name = 'Slew_Rate';

simulation_title = ...
    'Respuesta din\''{a}mica a un escal\''{o}n en gran se\~{n}al';

simulation_time_limits = [1.4E-3 1.6E-3];

simulation_time_ticks = (1.4E-3 : 0.01E-3 : 1.6E-3);

simulation_vin_limits = [0 1.2];

simulation_vin_ticks = (0 :0.1:1.2);

simulation_vout_limits = [0 26];

simulation_vout_ticks = (0:1:26);

slew_rate_limits = [0 0];

graphic_handle = aab_dynamic_response(...
    fullfile(spice_directory, ...
    strjoin({simulation_name, '.txt'}, '')), ...
    simulation_title, 100, time_simulation_color_list, ...
    simulation_time_limits, simulation_time_ticks, ...
    simulation_vin_limits, simulation_vin_ticks, 0,...
    simulation_vout_limits, simulation_vout_ticks, 0, slew_rate_limits);

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

% Cierro el gráfico luego de salvado.
if (close_figures)
    close(graphic_handle);
end


%%%%% ZOOM.

simulation_save_name = 'amplifier_SR_zoom';

simulation_title = ...
    'Respuesta din\''{a}mica a un escal\''{o}n en gran se\~{n}al';

simulation_time_limits = [1.498E-3 1.506E-3];

simulation_time_ticks = (1.498E-3 : 0.0005E-3 : 1.506E-3);

simulation_vin_limits = [0 1.2];

simulation_vin_ticks = (0 :0.1:1.2);

simulation_vout_limits = [0 26];

simulation_vout_ticks = (0:1:26);

slew_rate_limits = [1.5015E-3 1.502E-3];

graphic_handle = aab_dynamic_response(...
    fullfile(spice_directory, ...
    strjoin({simulation_name, '.txt'}, '')), ...
    simulation_title, 100, time_simulation_color_list, ...
    simulation_time_limits, simulation_time_ticks, ...
    simulation_vin_limits, simulation_vin_ticks, 0,...
    simulation_vout_limits, simulation_vout_ticks, 0, slew_rate_limits);

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

[status,~] = system('crop.cmd');

if status
    warning('%s.\n', 'Cannot execute system command.');
end

cd(olddir);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end