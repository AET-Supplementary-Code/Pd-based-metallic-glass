# Supplementary Data Codes

**Fractal medium-range orders govern bulk metallic glass formation**

Jiong Zhou<sup>1,5</sup>, Huang Huang<sup>1,5</sup>, Jinhua Yu<sup>2,5</sup>, Zhenzhen Yan<sup>1</sup>,  Miaoran Zhang<sup>2</sup>, Huipu Liu<sup>2</sup>, Yakun Yuan<sup>3</sup>, Ling Zhang<sup>4</sup>, Jun Ding<sup>2*</sup>, Fan Zhu<sup>1*</sup>    

<sup>1</sup>College of Smart Materials and Future Energy, Fudan University, Shanghai 200438, China    
<sup>2</sup>Center for Alloy Innovation and Design, State Key Laboratory for Mechanical Behavior of Materials, Xi’an Jiaotong University, Xi’an 710049, China    
<sup>3</sup>Future Material Innovation Center, School of Materials Science and Engineering, Zhangjiang Institute for Advanced Study and School of Physics and Astronomy, Shanghai Jiao Tong University, Shanghai 200030, China    
<sup>4</sup>School of Optical-Electrical and Computer Engineering, University of Shanghai for Science and Technology, Shanghai 200093, China    
<sup>5</sup>These authors contribute equally: Jiong Zhou, Huang Huang, Jinhua Yu    
**Corresponding authors: dingsn@xjtu.edu.cn, fzhu@fudan.edu.cn *     


## Contents

- [Overview](#overview)
- [System Requirements](#system-requirements)
- [Repository Contents](#repository-contents)

# Overview

Glass-forming ability (GFA) governs whether a metallic liquid can avoid crystallization and vitrify, yet its atomic-scale structural origin remains elusive. Here we identify the fractal dimensionality of medium-range order (MRO) as a quantitative structural descriptor of GFA in metallic glasses. Using atomic electron tomography, we resolve the three-dimensional atomic structures of the prototypical Pd-Ni-P and Pd-Si glass formers and directly visualize fractal MRO networks, with the higher-GFA alloy exhibiting greater MRO dimensionality and spatial connectivity. We then extend this analysis using Cs-corrected HAADF-STEM across eight as-cast bulk metallic glasses and six melt-spun ribbons spanning different alloy chemistries and cooling histories. These datasets collapse onto a unified scaling relationship between reduced GFA and MRO fractal dimensionality. The results show that glass formation depends not simply on the presence of locally preferred structures, but on how they connect and propagate over medium-range length scales. Higher-dimensional and more spatially extended MRO imposes stronger cooperative constraints on the structural rearrangements required for crystallization, thereby promoting vitrification. Our findings establish a direct quantitative link between atomic-scale amorphous organization and macroscopic glass-forming ability.

# System Requirements

## Hardware Requirements

We recommend a computer with 16G DRAM, standard i7 4-core CPU, and a GPU to run most data analysis source codes. But for the 3D reconstruction of the experimental data with RESIRE and atomic tracing, we recommend a computer with large memory (512G DRAM, 16-core CPU and 1 GPU).

## Software Requirements

### OS Requirements

This package has been tested on the following Operating System:

Linux: Ubuntu 22.04.5 LTS  
Windows: Windows 11, version 23H2  
Mac OSX: We have not tested it on a Mac yet, but it should in principle work.

### Matlab Version Requirements

This package has been tested with `Matlab` R2021b. All the codes have to run in their own folders. We recommend the use of `Matlab` version R2021a or higher to test the data and source codes.

# Repository Contents

### 1. Experiment Data

Folder: [1_Measured_data](./1_Measured_data)

This folder contains experimental images after denoising and alignment as well as their corresponding tilt angles for the amorphous Pd-Si and Pd-Ni-P nanoparticles.

### 2. The REal Space Iterative REconstruction (RESIRE) Package

Folder: [2_RESIRE_package](./2_RESIRE_package)

Run the code `Main_RESIRE_Demo.m` to achieve the 3D reconstruction of a small demo object. Run the code `Main_RESIRE_PdSi.m` to achieve the 3D reconstruction of the Pd-Si nanoparticle. Run the code `Main_RESIRE_PdNiP.m` to achieve the 3D reconstruction of the Pd-Ni-P nanoparticle.
- **Expected Run Time**: 
  - On a recommended high-performance workstation (512G DRAM, 16-core CPU, GPU): ~72 hours.
  - On a "normal" standard desktop computer (16G DRAM, 4-core CPU): Not recommended due to memory limits, and may take significantly longer or fail out-of-memory.

### 3. Reconstructed 3D Volume

Folder: [3_Final_reconstruction_volume](./3_Final_reconstruction_volume)

This folder includes the 3D reconstructed volumes of Pd-Si and Pd-Ni-P nanoparticles.

### 4. Atom Tracing

Folder: [4_Atom_tracing](./4_Atom_tracing)

Run the code `Main_atom_tracing_PdSi.m` to trace the candidate atomic positions from the reconstructed 3D volume of Pd-Si. Run the codes `Main_atom_tracing_PdNiP.m` to trace the candidate atomic positions from the reconstructed 3D volume.
- **Expected Run Time**: ~24 hours on a standard/recommended system.

### 5. Experimental Atomic Model

Folder: [5_Final_coordinates](./5_Final_coordinates)

This folder includes the final 3D atomic model of Pd-Si and Pd-Ni-P nanoparticles.

### 6. Post Data Analysis

Folder: [6_Data_analysis](./6_Data_analysis)

Run the code `BOO_RDF_PdSi.m` to calculate the radial distribution functions for amorphous Pd-Si. Run the codes `BOO_RDF_PdNiP.m` to calculate the radial distribution functions for amorphous Pd-Ni-P.
- **Expected Run Time**: ~16 hours on a standard/recommended system.