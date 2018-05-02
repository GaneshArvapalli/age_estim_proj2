function dice = FUN_Dice(img1,img2)

img1 = img1(:);
img2 = img2(:);
dice = 2 * sum(img1 & img2) / (sum(img1) + sum(img2));

end