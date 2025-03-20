function postp2 = logist_classifier_func(xfeat_tr,flag_tr,xfeat_te)

[n_tr,nfea_tr]=size(xfeat_tr);
[n_te,nfea]=size(xfeat_te);

if nfea_tr ~= nfea;
    error('The number of features must be the same in both matrices')
end

xreg_tr=[ones(n_tr,1) xfeat_tr];
bb=logistic(xreg_tr,flag_tr);

xreg_te=[ones(n_te,1) xfeat_te];
flagest=xreg_te*bb;
postp2=1./(1+exp(-flagest));

return
end
