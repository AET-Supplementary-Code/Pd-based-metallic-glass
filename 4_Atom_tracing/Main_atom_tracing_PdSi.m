%% Atom Tracing
% load the reconstructed 3D volume
addpath('./src');
Recon_filename_part1 = '../3_Final_reconstruction_volume/PdSi_Volume/PdSi_Volume_part1.mat';
Recon_filename_part2 = '../3_Final_reconstruction_volume/PdSi_Volume/PdSi_Volume_part2.mat';
Recon_filename_part3 = '../3_Final_reconstruction_volume/PdSi_Volume/PdSi_Volume_part3.mat';
Recon_filename_part4 = '../3_Final_reconstruction_volume/PdSi_Volume/PdSi_Volume_part4.mat';

RecVol_part1 = importdata(Recon_filename_part1);
RecVol_part2 = importdata(Recon_filename_part2);
RecVol_part3 = importdata(Recon_filename_part3);
RecVol_part4 = importdata(Recon_filename_part4);
RecVol = cat(3,RecVol_part1,RecVol_part2,RecVol_part3,RecVol_part4);

% Set tracing parameters
Th = 1;
MaxNumberPeaks = 1000000;
SearchRad = 3;
MaxIter = 14;
CritIter = 7;
Res = 0.339418 / 3; % Angstrom per oversampled voxel
Dmin = 2.0 / Res;

atom_pos = trace_atom_positions(RecVol, Dmin, MaxNumberPeaks, SearchRad, Th, MaxIter, CritIter);

%% Classify the traced peaks
% Initial integrated-intensity windows for the three templates
IntensityCenters = [0, 2e5, 3e5];
IntensityHalfWidth = 1e4;
labels = classify_atom_positions(double(RecVol), atom_pos, IntensityCenters, IntensityHalfWidth);
model = atom_pos(:, labels ~= 1);

%% Save the traced atomic model
if ~isfolder('Output')
    mkdir('Output');
end
save('Output/PdSi_Tracing.mat', 'model');
