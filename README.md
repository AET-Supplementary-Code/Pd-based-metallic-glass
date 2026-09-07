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
- [Repositary Contents](#repositary-contents)

# Overview

Glass-forming ability is a critical property for amorphous solids which significantly influences their potential for structural and functional applications. Although medium-range orders have been widely recognized as essential microstructural features in amorphous solids, directly linking them with glass-forming ability remains challenging. Here, we report that fractal dimensionality can serve as a definite structural indicator to quantitatively correlate medium-range order with bulk glass-forming ability. Using atomic electron tomography, we determine the three-dimensional atomic structures of Pd-Ni-P and Pd-Si metallic glasses, revealing a strong correlation between glass-forming ability and fractal dimensionality. This relationship is further validated by examining the medium-range-ordered spatial heterogeneity in eight typical bulk metallic glasses, including Zr41.25Ti13.75Cu12.5Ni10Be22.5, Zr55Cu30Ni5Al10, and Pd40Ni40P20 (at. %). Our study provides compelling evidence that the fractal nature of medium-range orders plays a crucial role in determining the bulk properties of amorphous solids, distinguishing them from the non-fractal crystalline solids.

# System Requirements

## Hardware Requirements

We recommend a computer with 16G DRAM, standard i7 4-core CPU, and a GPU to run most data analysis source codes. But for the 3D reconstruction of the experimental data with RESIRE, atomic tracing and refinement, we recommend a computer with large memory (512G DRAM, 16-core CPU and 1 GPU).

## Software Requirements

### OS Requirements

This package has been tested on the following Operating System:

Linux: Ubuntu 22.04.5 LTS  
Windows: Windows 11, version 23H2  
Mac OSX: We have not tested it on a Mac yet, but it should in principle work.

### Matlab Version Requirements

This package has been tested with `Matlab` R2021b. All the codes have to run in their own folders. We recommend the use of `Matlab` version R2021a or higher to test the data and source codes.

# Repositary Contents

### 1. Experiment Data

Folder: [1_Measured_data](./1_Measured_data)

This folder contains experimental images after denoising and alignment as well as their corresponding tilt angles for the amorphous Pd-Ni-P nanoparticle.

### 2. The REal Space Iterative REconstruction (RESIRE) Package

Folder: [2_RESIRE_package](./2_RESIRE_package)

Run the code `Main_RESIRE_PdNiP.m` to achieve the 3D reconstruction of the Pd-Ni-P nanoparticle.

### 3. Reconstructed 3D Volume

Folder: [3_Final_reconstruction_volume](./3_Final_reconstruction_volume)

This folder includes the 3D reconstructed volumes of the Pd-Ni-P nanoparticle.

### 4. Atom Tracing

Folder: [4_Atom_tracing](./4_Atom_tracing)

Run the codes `Main_atom_tracing_PdNiP.m` to trace the candidate atomic positions from the reconstructed 3D volume.

### 5. Experimental Atomic Model

Folder: [5_Final_coordinates](./5_Final_coordinates)

This folder includes the final 3D atomic model of the Pd-Ni-P nanoparticle.

### 6. Post Data Analysis

Folder: [6_Data_analysis](./6_Data_analysis)

Run the codes `BOO_RDF_PdNiP.m` to calculate the radial distribution functions for amorphous Pd-Ni-P.
