%% Ganesh Arvapalli
% Data loader for saving images for training or testing

% Point it to the right folder and type 'train' or 'test' for t
% Outputs '.mat' file with all images used for training/testing
function data = data_loader(filepath, t)
    % Store training data for easy access
    if contains(t, 'train')
        Files=dir(filepath);
        train_imgs = {};
        for k=1:length(Files)
            if contains(Files(k).name, '.nii')
                Image = load_nii(Files(k).name);
                train_imgs{end+1} = Image.img;
            end
        end
        save('training_images.mat', 'train_imgs');
    % ... or testing data, but you may need to upgrade your MAT version (>
    % 2GB of images!)
    elseif contains(t, 'test')
        Files=dir(filepath);
        test_imgs = {};
        for k=1:length(Files)
            if contains(Files(k).name, '.nii')
                Image = load_nii(Files(k).name);
                test_imgs{end+1} = Image.img;
            end
        end
        save('testing_images.mat', 'test_imgs');
    end
end