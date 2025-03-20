%
% Go through each ensemble member to make a forecast
%
for imem = 1:31
    %
    disp(['Predicting member ' num2str(imem)])
    % Reduce dataset dataset down to the features specified in feat_ind_log
    nfeat = length(feat_ind_log);
    feat_log = NaN(nfeat, 1);
    %
    for i = 1:nfeat
        feat_log(i) = reduced_f(ti, feat_ind_log(i), imem);
    end
    % 
    % Make forecast
    prob_f(ti, imem) = logist_classifier_func(feat_train, flag_train, feat_log');
end