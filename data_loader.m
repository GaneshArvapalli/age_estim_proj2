%% Ganesh Arvapalli
% Data loader for saving images for training or testing

function data = data_loader(filepath, t)
    Files=dir(filepath);
    imgs = {};
    for k=1:length(Files)
        if contains(Files(k).name, '.nii')
            Image = load_nii(Files(k).name);
            imgs{end+1} = Image.img;
        end
    end
    if contains(t, 'train')
        save('training_images.mat', 'imgs');
    elseif contains(t, 'test')
        save('testing_images.mat', 'imgs');
    end
end