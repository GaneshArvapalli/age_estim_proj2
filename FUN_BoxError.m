function boundBox_error = FUN_BoxError(box1,box2)
box1 = reshape(box1,[6,6]);
boundBox_error = sqrt(sum((box1 - box2).^2,1)); % Euclidian distance
end