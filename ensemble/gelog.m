%
% Test single cycle
%
yr_f = '2024';
mo_f = '10';
da_f = '04';
hr_f = '00';
stnum_f = '14';
basin_f = 'AL';
home_dir = '../../encore_AL_EP/';
%
disp('Running real time forecast')
ri_defn = 30;
time_inc = 24;
missing = -999.9;
%
%Put data into a file all_preds_f
read_in_case_study_data
%
nt = 21;
prob_f = NaN(nt, 31);
%
for ti = 1:nt
    disp(' ')
    disp(['Lead-time ' num2str(ti)])
    disp('--------------------------------------------------------')
    %
    % Prepare ensemble data for their forecasts
    %
    load all_variables_with_bt00.mat
    vmaxbt = vmaxbt';
    % Extract info from best track for test case
    date_f = datenum(str2num(yr_f), str2num(mo_f), str2num(da_f), ...
        str2num(hr_f), 0, 0);
    ind = find(date_f == time_all & str2num(stnum_f) == stnum & ...
        strcmp(basin_f, basin));
    if isempty(ind)
        error('empty forecast. terminating')
    end
    vmaxbt_f = vmaxbt(ind, :);
    clear ind
    prepare_input_data
    %
    if ti == 1
        feat_ind_log = [4 31 34 38 43 49 54];
    elseif ti == 2
        feat_ind_log = [4 31 34 38 43 49 54];
    elseif ti == 3
        feat_ind_log = [4 31 34 38 43 49 54];
    elseif ti == 4
        feat_ind_log = [4 31 34 38 49 54];
    elseif ti == 5
        feat_ind_log = [3 4 31 34 38 49 54];
    elseif ti == 6
        feat_ind_log = [3 4 31 34 38 49 54];
    elseif ti == 7
        feat_ind_log = [3 4 31 34 49 54];
    elseif ti == 8
        feat_ind_log = [3 4 31 34 49 54];
    elseif ti == 9
        feat_ind_log = [3 4 31 34 49 54];
    elseif ti == 10
        feat_ind_log = [4 31 34 41 49 54];
    elseif ti == 11
        feat_ind_log = [4 31 34 41 49 54];
    elseif ti == 12
        feat_ind_log = [4 31 34 41 49 54];
    elseif ti == 13
        feat_ind_log = [4 31 34 41 49 54];
    elseif ti == 14
        feat_ind_log = [4 31 34 41 49 54];
    elseif ti == 15
        feat_ind_log = [4 31 34 41 49 54];
    elseif ti == 16
        feat_ind_log = [4 31 34 41 49 54];
    elseif ti == 17
        feat_ind_log = [4 31 34 41 49 54];
    elseif ti == 18
        feat_ind_log = [4 31 34 41 49 54];
    elseif ti == 19
        feat_ind_log = [3 4 31 34 41 49 54];
    elseif ti == 20
        feat_ind_log = [3 4 31 34 41 54];
    elseif ti == 21
        feat_ind_log = [3 4 34 41 54];
    end
    %
    % Build up training
    disp('Sorting training data')
    train_for_rt
    %
    % Arrange input data and make forecasts
    clear filein imember ntimes imem
    make_forecast
    %
end
%
clear feat_train flag_train i imem nt plog all_preds_f basin vmaxbt
clear time_inc time_all ti ri_defn pclim nfeat
clear ind_train_ri ind_ri home_dir feat_ind_log feat_log
%
% Define NetCDF file name
ncfile = ['prediction_' basin_f stnum_f '_' yr_f mo_f da_f hr_f '.nc'];
unix(['rm -f ' ncfile]);
fclose('all');
clear yr_f mo_f da_f hr_f
%
reduced_f = reduced_f(1:21, :);
vmaxbt_f = vmaxbt_f(1,1:21);

% Define dimensions
dim_y = 31;
dim_z = 54;
dim_t = 21;
dim_basin = 2;

% Create the NetCDF file
ncid = netcdf.create(ncfile, 'NETCDF4');

% Define dimensions
dimid_y = netcdf.defDim(ncid, 'y', dim_y);
dimid_z = netcdf.defDim(ncid, 'z', dim_z);
dimid_t = netcdf.defDim(ncid, 't', dim_t);
%
dimid_basin = netcdf.defDim(ncid, 'basin', dim_basin);
dimid_scalar = netcdf.defDim(ncid, 'scalar', 1); % For single values

% Define variables
varid_basin_f = netcdf.defVar(ncid, 'basin_f', 'char', dimid_basin);
varid_date_f = netcdf.defVar(ncid, 'date_f', 'double', dimid_scalar);
varid_prob_f = netcdf.defVar(ncid, 'prob_f', 'double', [dimid_t, dimid_y]);
varid_reduced_f = netcdf.defVar(ncid, 'reduced_f', 'double', [dimid_t, dimid_z, dimid_y]);
varid_vmaxbt_f = netcdf.defVar(ncid, 'vmaxbt_f', 'double', dimid_t);

% End definition mode
netcdf.endDef(ncid);

% Write data to the file
netcdf.putVar(ncid, varid_basin_f, basin_f);
netcdf.putVar(ncid, varid_date_f, date_f);
netcdf.putVar(ncid, varid_prob_f, prob_f);
netcdf.putVar(ncid, varid_reduced_f, reduced_f);
netcdf.putVar(ncid, varid_vmaxbt_f, vmaxbt_f);

% Close the NetCDF file
netcdf.close(ncid);
clear varid* ncid ncfile dim*

disp('NetCDF file created successfully.')
