function y = standardize ( x ) 
%
% standardize a vector or a matrix (each column is normalized)
%  - written by Dan Vimont (UW-Madison;
%  http://www.aos.wisc.edu/~dvimont/matlab/ )
%

ndim = ndims(x);
nsz = size(x);
if ndim > 2;
  x = reshape(x, nsz(1), prod(nsz(2:ndim)));
end


[m,n]=size(x);
if(m==1) 
  m=n;
end
y = ( x - ones(m,1)*mean(x) ) ./ ( ones(m,1)*std(x) );

y = reshape(y, nsz);
