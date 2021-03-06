%% Ganesh Arvapalli
% Implementation of region growing in a 3D matrix

function labeled_image = region_grow(matrix, pos, label_num)
    labeled_image = zeros(size(matrix));
    x_max = size(matrix, 1);
    y_max = size(matrix, 2);
    z_max = size(matrix, 3);
    % Start with initial position and seed
    seed = double(matrix(pos(1),pos(2),pos(3)));
    q = [pos(1),pos(2),pos(3)];
    while ~isempty(q)
        current_pos = [q(1,1),q(1,2),q(1,3)];
        q(1,:) = [];
        for i = -1:1
            for j = -1:1
                for k = -1:1
                    % Don't check the same pixel again
                    if i~=0 && j ~=0 && k~=0
                        check_x = current_pos(1) + i;
                        check_y = current_pos(2) + j;
                        check_z = current_pos(3) + k;
                        % Check if inside boundaries
                        if (check_x < x_max) && (check_y < y_max) && ...
                           (check_z < z_max) && (check_x > 0) && ...
                           (check_y > 0) && (check_z > 0)
                            % If not already checked
                            if labeled_image(check_x, check_y, check_z) == 0
                                value = matrix(check_x, check_y, check_z);
                                % If appropriate intensity difference
                                % and close by to initial point
                                if norm(abs(value - seed))/norm(seed) <= 0.03 && ...
                                        norm(double(current_pos - pos)) < 15
                                    labeled_image(check_x, check_y, check_z) = label_num;
                                    q(end+1,:) = [check_x, check_y, check_z];
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end