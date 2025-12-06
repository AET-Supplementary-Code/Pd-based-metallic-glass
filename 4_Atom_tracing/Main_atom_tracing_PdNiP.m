%% Atom Tracing
% load reconstructed 3D volume
%addpath('./src')
inputDir = '';
Recon_filename = [inputDir sprintf('../3_Final_reconstruction_volume/PdSi_Volume/PdSi_Volume_part%d.mat', 1)];
RecVol = importdata(Recon_filename);
for nrecon = 2:4
    Recon_filename = [inputDir sprintf('../3_Final_reconstruction_volume/PdSi_Volume/PdSi_Volume_part%d.mat', nrecon)];
    RecVol_part = importdata(Recon_filename);
    RecVol = cat(3,RecVol,RecVol_part);
end

% set Threshold
Th = 1;

% zero padd the reconstructed volume
Sdn_pad = My_paddzero(RecVol,size(RecVol)+20);

BoxSize0=3; %box size used for average when sorting peaks
BoxSize1=5; %box size used to find maxima
BoxSize2=7; %box size used box for fitting off-center gauss

[Xsize, Ysize, Zsize] = size(Sdn_pad);  

MaxNumberPeaks=1000000; %maximum number of peaks to find

% minimum distance constraint in the unit of pixel
Res = 0.421347;
Dmin = 2 / Res; % this corresponds to 2 Angstrom for FePt reconstruction

DataMatrix = Sdn_pad;

[atom_pocs, close_pos,  stats, statsI ] = find_possible_atoms(DataMatrix, Dmin, MaxNumberPeaks, BoxSize0, BoxSize1,BoxSize2,Th);

tight_support = My_obtain_tight_support_ver1(RecVol);

atom_pos(:,length(statsI.resnorm)+1:end) = [];

%%
NonAtomPercentage = 0.2;

bb = find(sum(atom_pos.^2,1)==0);

atom_pos(:,bb) = [];

[temp_model, ~] = My_Nonatom_Classification(DataMatrix,atom_pos,stats, tight_support, NonAtomPercentage,4,1,1);

cenpixels = repmat(round((size(DataMatrix)+1)/2)',[1, size(temp_model,2)]);
 ROTmodel = temp_model - cenpixels;

 Up = [1 0 0;
    0 1 0;
    0 0 1;];
 
ROTmodel = Up * [ROTmodel(1,:);ROTmodel(2,:);ROTmodel(3,:)];
ROTmodel = [ROTmodel(1,:);ROTmodel(2,:);ROTmodel(3,:)] + cenpixels;

ROTmodel = ROTmodel- cenpixels;

save('Output/PdNiP_Tracing.mat','temp_model','ROTmodel');