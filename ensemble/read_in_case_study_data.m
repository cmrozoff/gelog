%
all_preds_f = NaN(41, 53, 31);
for imember = 1:31
    disp(['Reading in ENCORE data from ensemble member ' num2str(imember)])
    if imember - 1 < 10
        imem = ['0' num2str(imember - 1)];
    else
        imem = num2str(imember - 1);
    end
    %
    filein = [home_dir basin_f stnum_f yr_f '_gefs_' ...
        yr_f mo_f da_f hr_f '_enmem_' imem '_diag.nc'];
    [a, b] = size(ncread(filein, 'LAT'));
    %
    all_preds_f(1:a, 1, imember) = ncread(filein, 'CAPE1');
    all_preds_f(1:a, 2, imember) = ncread(filein, 'CAPE2');
    all_preds_f(1:a, 3, imember) = ncread(filein, 'CAPE3');
    all_preds_f(1:a, 4, imember) = ncread(filein, 'DVRG200');
    all_preds_f(1:a, 5, imember) = ncread(filein, 'IKE1');
    all_preds_f(1:a, 6, imember) = ncread(filein, 'IKE2');
    all_preds_f(1:a, 23, imember) = ncread(filein, 'LAND');
    all_preds_f(1:a, 24, imember) = ncread(filein, 'LAT');
    all_preds_f(1:a, 25, imember) = ncread(filein, 'LON');
    all_preds_f(1:a, 26, imember) = ncread(filein, 'MIN_SLP');
    all_preds_f(1:a, 27, imember) = ncread(filein, 'PERS');
    all_preds_f(1:a, 28, imember) = ncread(filein, 'RHHI');
    all_preds_f(1:a, 29, imember) = ncread(filein, 'RHLO');
    all_preds_f(1:a, 30, imember) = ncread(filein, 'RHMD');
    all_preds_f(1:a, 31, imember) = ncread(filein, 'RMW');
    all_preds_f(1:a, 32, imember) = ncread(filein, 'SHR_HDG');
    all_preds_f(1:a, 33, imember) = ncread(filein, 'SHR_MAG');
    all_preds_f(1:a, 34, imember) = ncread(filein, 'SHR_SHIPS');
    all_preds_f(1:a, 35, imember) = ncread(filein, 'SST');
    all_preds_f(1:a, 36, imember) = ncread(filein, 'STM_HDG');
    all_preds_f(1:a, 37, imember) = ncread(filein, 'STM_SPD');
    all_preds_f(1:a, 38, imember) = ncread(filein, 'T200');
    all_preds_f(1:a, 39, imember) = ncread(filein, 'TANG850');
    all_preds_f(1:a, 40, imember) = ncread(filein, 'TGRD');
    all_preds_f(1:a, 41, imember) = ncread(filein, 'TPW');
    all_preds_f(1:a, 42, imember) = ncread(filein, 'USFC1');
    all_preds_f(1:a, 43, imember) = ncread(filein, 'USFC2');
    all_preds_f(1:a, 44, imember) = ncread(filein, 'USFC3');
    all_preds_f(1:a, 45, imember) = ncread(filein, 'USFCSYM1');
    all_preds_f(1:a, 46, imember) = ncread(filein, 'USFCSYM2');
    all_preds_f(1:a, 47, imember) = ncread(filein, 'USFCSYM3');
    all_preds_f(1:a, 48, imember) = ncread(filein, 'VMAX');
    all_preds_f(1:a, 49, imember) = ncread(filein, 'VMPI');
    all_preds_f(1:a, 50, imember) = ncread(filein, 'VORT850');
    all_preds_f(1:a, 51, imember) = ncread(filein, 'W8501');
    all_preds_f(1:a, 52, imember) = ncread(filein, 'W8502');
    all_preds_f(1:a, 53, imember) = ncread(filein, 'W8503');
end