
stnam = 'milton';

% BERYL
%start_time = datetime(2024,06,28,18,0,0);
%end_time   = datetime(2024,07,07,06,0,0);

% OTIS
%start_time = datetime(2023,10,22,12,0,0);
%end_time   = datetime(2023,10,25,12,0,0);

if strcmp(stnam, 'helene')
    start_time = datetime(2024,9,23,12,0,0);
    end_time   = datetime(2024,9,27,12,0,0);
    filenames = dir('predictions/prediction_AL09*nc'); % Helene
    load('helene.mat');
elseif strcmp(stnam, 'milton')
    start_time = datetime(2024,10,05,18,0,0);
    end_time   = datetime(2024,10,10,06,0,0);
    filenames = dir('predictions/prediction_AL14*nc'); % Milton
    load('milton.mat');
end
prob_control = []; prob_25th = []; prob_75th = [];
for i = 1:length(filenames)
    filefull = ['predictions/' filenames(i).name];
    disp(filefull)
    prob_mem = ncread(filefull, 'prob_f');
    % Using a control member
    prob_control = [prob_control prob_mem(:, 1)];
end

% Convert datenum to datetime
obs_time_dt = datetime(time_bt, 'ConvertFrom', 'datenum');

% Restrict data to desired time window
in_range = obs_time_dt >= start_time & obs_time_dt <= end_time;
obs_time_clipped = obs_time_dt(in_range);
obs_intensity_clipped = vmax_bt(in_range);

% Use this time vector for plotting and x-axis ticks
t = obs_time_clipped;
n = length(t);

% Replace previous mock obs_wind
obs_wind = obs_intensity_clipped;

% Probability time series (random for demo)
prob_obs = linspace(0.2, 0.8, n); % black curve
prob_1 = rand(1, n)*0.8;          % color curve 1
prob_2 = rand(1, n)*0.8;          % color curve 2
prob_3 = rand(1, n)*0.8;          % color curve 3

% Calculate Rapid Intensification (RI) periods: >30kt in 24 hours (i.e., over 4 time steps)
RI_indices = [];
for i = 1:(n-4)
    if (obs_wind(i+4) - obs_wind(i)) >= 30
        RI_indices = [RI_indices ; i i+4];
    end
end

% --- Plotting section with swapped axes ---

figure(1); clf
hold on;

% Small time buffer (adjust as desired)
buffer = minutes(30);  % 30-minute buffer on each side

% Shade RI periods
for i = 1:size(RI_indices,1)
    x1 = t(RI_indices(i,1)) + buffer;
    x2 = t(RI_indices(i,2)) - buffer;
    fill([x1 x2 x2 x1], [0 0 160 160], [0.8 0.8 0.8], ...
        'EdgeColor', 'none', 'FaceAlpha', 0.5); % gray box
end

% ----------------------------------------------------
% 🔄 SWAP ORDER OF AXES: start with right axis first
% ----------------------------------------------------

% Plot probabilities on the *left* y-axis (was right)
yyaxis left;

num_members = length(filenames);

dark_blue  = [0.0  0.0  0.5];
light_blue = [0.7  0.85 1.0];
light_red  = [1.0  0.8  0.8];
dark_red   = [0.6  0.0  0.0];

partition1 = floor(num_members/2);
partition2 = num_members - partition1;

blue_colors = zeros(partition1, 3);
for i = 1:3
    blue_colors(:,i) = linspace(dark_blue(i), light_blue(i), partition1);
end

red_colors = zeros(partition2, 3);
for i = 1:3
    red_colors(:,i) = linspace(light_red(i), dark_red(i), partition2);
end

color_map = [blue_colors; red_colors];
line_width = 1;

max_time_inc = min(21, num_members);
for i = 1:num_members
    upper_limit_time = max_time_inc+i-1;
    cutoff = min(upper_limit_time, num_members);
    med = prob_control(1:max_time_inc, i);
    plot(t(i:cutoff), med(1:length(i:cutoff)), '-', ...
         'LineWidth', 3, 'Color', color_map(i,:)); 
    line_width = line_width + 0.2;
end

ylabel('Probability');
ylim([0 1]);
ax = gca;
ax.YColor = 'k'; % set left y-axis to black

ax.YLabel.FontWeight = 'bold';
ax.YLabel.FontSize = 16;

% Make tick labels bold and larger
ax.FontSize = 14;
ax.FontWeight = 'bold';

% Make title bold and larger
ax.Title.FontWeight = 'bold';
ax.Title.FontSize = 18;

% ----------------------------------------------------
% Now put windspeed on the *right* y-axis (was left)
% ----------------------------------------------------
yyaxis right;
plot(t, obs_wind, '-k', 'LineWidth', 4);
ylabel('Observed Windspeed (kt)');
ylim([0 155]);

% --- Formatting (unchanged except now applies to swapped sides) ---
xlim([t(1) t(end)]);
ax.XLabel.FontWeight = 'bold';
ax.YLabel.FontWeight = 'bold';
ax.XLabel.FontSize = 18;
ax.YLabel.FontSize = 18;
ax.YColor = 'k';

% Minor ticks every 5 kt on right axis (was left)
ax.YAxis(2).MinorTick = 'on';
ax.YAxis(2).MinorTickValues = 0:5:155;
ax.YAxis(2).TickDirection = 'in';

xlabel('Time (UTC)');
grid on;
xticks(t);

label_idx = hour(t) == 0;
label_times = t(label_idx);
xticklabels_strings = repmat("", size(t));
xticklabels_strings(label_idx) = datestr(label_times, 'mm/dd');
xticklabels(xticklabels_strings);
xtickangle(0);