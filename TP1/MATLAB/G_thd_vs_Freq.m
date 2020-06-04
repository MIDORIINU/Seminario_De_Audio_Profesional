function G_thd_vs_Freq(spice_directory, points_directory, ...
    images_directory, close_figures)

% Init
fprintf('THD vs Frequency:\n\n');

graph_complete_dir = ...
    fullfile(images_directory, ...
    points_directory);


[~, ~] = mkdir(graph_complete_dir);

if (7 ~= exist(graph_complete_dir, 'dir'))
    error('Could not create directory: "%s".\n', graph_complete_dir);
end


datafile = ...
    fullfile(spice_directory, ...
    strjoin({'THD_vs_freq_sim', ...
    '.txt'}, ''));

THD_sim = dlmread(datafile, '\t');

THD_measured = dlmread('THD_vs_freq_measured.txt', '\t');


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
title('THD vs Frecuencia');

box(axes1,'on');

set(axes1,'XScale','log','XGrid','on','XMinorTick','on','XTick',...
    [min(THD_measured(:,1)):20:300 400:100:900 ...
    1000:1000:max(THD_sim(:,1))],...
    'YGrid','on','YMinorTick','on','YTick',...
    0:0.025:1.1*max(THD_measured(:,2)));

xlim(axes1, [min(THD_measured(:,1)) max(THD_measured(:,1))]);

axes1.XAxis.Exponent = 0;

axes1.YAxis(1).Exponent = 0;

xlabel('Frecuencia [Hz]');

ylabel('THD [%]');

ylim(axes1, [0 1.1*max(THD_measured(:,2))]);

axes1.YAxis(1).Color = [1 0 0];

xtickangle(axes1, 75);


%%%%


yyaxis(axes1,'right')

plot(axes1, THD_sim(:,1), THD_sim(:,2), ...
    'DisplayName','Simulado', 'LineStyle', '--', ...
    'Color', [0 1 0]);

% Set the remaining axes properties
set(axes1, 'XScale','log', ...
    'YGrid','on','YMinorTick','on','YTick',...
    0:0.025:1.5*max(THD_measured(:,2)));


ylim(axes1, [0 1.1*max(THD_measured(:,2))]);

ylabel('THD [%]');

axes1.YAxis(2).Exponent = 0;

axes1.YAxis(2).Color = [0 1 0];


legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.75 0.76 0.105 0.088]);





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
%     C(:,ii) = freq.^(ii-1);
%     A(:,ii) = (ii-1)*freq.^(ii-2);
% end
% 
% 
% % Constrained
% p3 = fliplr(lsqlin(C,THD_measured,-A,b).');
% 
% THDp = polyval(p3, freq);
% 
% plot(axes1, freq, THDp, 'LineStyle','--', 'Color', [0 0 1]);


%%
%%%


%%%
graph_complete_name = ...
    fullfile(graph_complete_dir, ...
    strjoin({'THD_vs_frequency', ...
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

