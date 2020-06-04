function G_thd_vs_Power(spice_directory, points_directory, ...
    images_directory, close_figures)

% Init
fprintf('THD vs Power:\n\n');

graph_complete_dir = ...
    fullfile(images_directory, ...
    points_directory);


[~, ~] = mkdir(graph_complete_dir);

if (7 ~= exist(graph_complete_dir, 'dir'))
    error('Could not create directory: "%s".\n', graph_complete_dir);
end


datafile = ...
    fullfile(spice_directory, ...
    strjoin({'THD_vs_power_sim', ...
    '.txt'}, ''));

THD_sim = dlmread(datafile, '\t');

THD_measured = dlmread('THD_vs_power_measured.txt', '\t');

% Porcentaje de pantalla que ocupa la imagen.
sz_perc = 100;


% Calculo el tamaño y la posición de la imagen.

pict_size = sz_perc/100;
pict_pos = (1 - pict_size)/2;

% Genero la figura, a un % del tamaño de la panatalla y centrada.
% No parece funcionar en Octave, pero no genera errores tampoco.
figure1 = figure('units', 'normalized', 'outerposition', ...
    [pict_pos pict_pos pict_size pict_size]);


% Create axes
axes1 = axes('Parent', figure1);
hold(axes1,'on');

yyaxis(axes1,'left');

% Create plot
plot(axes1, THD_measured(:,1), THD_measured(:,2),...
    'DisplayName','Medidio','Marker','hexagram', ...
    'Color', [1 0 0]);

% Create title
title('THD vs Potencia');

box(axes1,'on');

% Set the remaining axes properties
set(axes1,'XGrid','on','XMinorTick','on','XTick',...
    (0:1:max(THD_sim(:,1))),...
    'YGrid','on','YMinorTick','on','YTick',...
    0:0.0025:1.1*max(THD_measured(:,2)));

xlim(axes1, [0 max(THD_sim(:,1))]);

xlabel('Potencia [W]');

ylabel('THD [%]');

ylim(axes1, [0 1.01*max(THD_measured(:,2))]);

axes1.XAxis.Exponent = 0;

axes1.YAxis(1).Exponent = 0;

axes1.YAxis(1).Color = [1 0 0];

xtickangle(axes1, 75);



yyaxis(axes1,'right')

plot(axes1, THD_sim(:,1), THD_sim(:,2), ...
    'DisplayName','Simulado', 'LineStyle', '--', ...
    'Color', [0 1 0]);

% Set the remaining axes properties
% set(axes1,...
%     'YGrid','on','YMinorTick','on','YTick',...
%     0:0.0005:1.5*max(THD_sim(:,2)));
set(axes1,'YGrid','on','YMinorTick','on','YTick',...
    0:0.00025:0.101*max(THD_measured(:,2)));

%ylim(axes1, [0 1.5*max(THD_sim(:,2))]);
ylim(axes1, [0 0.101*max(THD_measured(:,2))]);

ylabel('THD [%]');

axes1.YAxis(2).Exponent = 0;

axes1.YAxis(2).Color = [0 1 0];


legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.76 0.42 0.105 0.088]);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ajustar a una curva monotona.

% n_data = length(THD_measured);
%
% degree = 3;
%
% % limit on derivative - in each data point
% b = zeros(n_data, 1);
%
% % coefficient matrix
% C = nan(n_data, degree+1);
% % derivative coefficient matrix
% A = nan(n_data, degree);
%
% % loop over polynomial terms
% for ii  = 1:degree+1
%     C(:,ii) = power.^(ii-1);
%     A(:,ii) = (ii-1)*power.^(ii-2);
% end
%
%
% % Constrained
% p3 = fliplr(lsqlin(C,THD_measured,-A,b).');
%
% THDp = polyval(p3, power);
%
% plot(axes1, power, THDp, 'LineStyle','--', 'Color', [0 0 1]);


%%
%%%


%%%
graph_complete_name = ...
    fullfile(graph_complete_dir, ...
    strjoin({'THD_vs_power', ...
    '.png'}, ''));

fprintf('Salvando el gráfico en un archivo "PNG"......');

% Salvo el gráfico en un archivo.
saveas(figure1, graph_complete_name);

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

end
