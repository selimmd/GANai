% Author @ Md Selim
% Date :: 06/10/2019
% Version :: 1.0
% 
% Input  :: Two image directeroy from source and target DICOM images
% Output :: 512X256 image pathch where half of the image is source image and half of is the target 
% 
% Description :: This program will read dicom files and create 512X215 image patches. The program randomly hover the source image and crop 256X256 area from the source 
% and target DICOM files and concat it togather to make the dataset.


sources_files=dir('E:\GANai\selim\1_LungCancerDimo_9-21-2016\DICOM\20160919\11020000\*.*');
target_files=dir('E:\GANai\selim\1_LungCancerDimo_9-21-2016\DICOM\20160919\11020000\*.*');
out_files = "E:\GANai\selim\1_LungCancerDimo_9-21-2016\DICOM\20160919\11020000_OUT";

for k=3:length(Files)
   [X, ] = dicomread(fullfile(sources_files(k).folder, Files(k).name));
   [Y, ] = dicomread(fullfile(target_files(k).folder, Files(k).name));
   [n m]= size(X);
    L = 256;
    % Crop
    for p=1:10                  % max 10 patches form 1 image
        start = randi(n-L+1)+(0:L-1);
        stop = randi(m-L+1)+(0:L-1);
        s_crop = X(start,stop);
        t_crop = Y(start,stop);
        I = mat2gray([s_crop,t_crop]);
        imwrite(I, fullfile(out_file, Files(k).name+"_"+p+".png"));
    end
end