%% pressure Scaling and Superposition Example:
load pressure_resampled.mat

%% Example Linear Acceleration
time = 0:0.001:0.1;
ax = 10-abs(time-0.025)*10^2;
ay = 10-abs(time-0.05)*10^2;
az = 10-abs(time-0.075)*10^2;
%% visualize acceleration
figure;
hold on
plot(time, ax, 'r')
plot(time, ay, 'g')
plot(time, az, 'b')

legend('linear acc. X', 'linear acc. Y', 'linear acc. Z')
xlabel('Time (ms)')
xlabel('acc. (g)')
box on 
set(gca, 'LineWidth', 2)
axis square
%% 
pressure = (repmat(ax, numel(px), 1).*repmat(px(:), 1, numel(ax)) + ...
    repmat(ay, numel(py), 1).*repmat(py(:), 1, numel(ay)) + ...
    repmat(az, numel(pz), 1).*repmat(pz(:), 1, numel(az)) ); 
pressure = reshape(pressure, [size(px), numel(ax)]);
%% show image frame by frame
figure; 
colormap jet
for i=1:length(time)
    subplot(1,2,2)
    
    imagesc(squeeze(pressure(:, 15, :, i)))
    axis square
    
    pause(0.1)
    title('Pressure Map')
    caxis([-10^6 10^4])
    box on 
    set(gca, 'LineWidth', 2)
    
    subplot(1,2,1)
    
    plot(time, ax, 'r')
    hold on
    plot(time, ay, 'g')
    plot(time, az, 'b')
    plot([time(i), time(i)], [0, max([ax(i), ay(i), az(i)])], 'LineWidth', 2, 'LineStyle', '--', 'Color', 'k')
    legend('linear acc. X', 'linear acc. Y', 'linear acc. Z')
    xlabel('Time (ms)')
    xlabel('acc. (g)')
    box on 
    set(gca, 'LineWidth', 2)
    axis square
    title('Linear Acceleration')
    hold off
    
end