%% Shayan Roychoudhury

function [newdata, v]=principal_comp(data, M)

% d = data - mean(data, 2);
% [U,S,v] = svd(d);
% v = transpose(v);
% v = v(:,1:M);
% newdata = data*v;


[coeff, score, latent, tsquared, explained, mu] = pca(data);
if M < size(score, 2)
    reconstructed = score(:,M) * coeff(:,M)' + mu;
    newdata = reconstructed;
else
    reconstructed = score * coeff' + mu;
    newdata = reconstructed;
end
% coeffs = pca(data);
% newdata = (data-mean(data))*coeffs;

% m = mean(data, 2);
% d = data - repmat(m,1,size(data,2));
% co = (1/(size(data,2)-1))*d*d';
% [vectors,values] = eig(co);
% vectors = vectors(:,1:M);
% values = values(:,1:M);
% 
% PCASpace = vectors;
% 
% % newdata = vectors'*data;
% newdata = [];
% for n=1:size(data,1)
%     newdata = m;
%     for j=1:M
%         newdata = newdata + (data(n,:)'*vectors(:,j) - m'*vectors(:,j))*vectors(:,j);
%     end
% end
% newdata = m + (data'*vectors - m'*vectors)*vectors;

% [r,c]=size(data);
% 
% % Compute the mean of the data matrix "The mean of each row" (Equation (10))
% m=mean(data')';
% 
% % Subtract the mean from each image [Centering the data] (Equation (11))
% d=data-repmat(m,1,c);
% 
% % Compute the covariance matrix (co) (Equation (12))
% co=(1 / (c-1))*d*d';
% 
% % Compute the eigen values and eigen vectors of the covariance matrix
% [eigvector,EigValues]=eig(co);
% 
% PCASpace=eigvector;
% 
% % Project the original data on the PCA space
% Newdata=PCASpace'*data;
end

