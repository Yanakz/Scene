# Scene


=========================================================================
This Matlab script demonstrates the usage of this package.
If you have used this code in your work, please cite the following paper:
 
Matlab tools for "Saliency Prediction with Scene Structural Guidance" in arxiv, 2015
Haoran Liang, Ming Jiang, Ronghua Liang and Qi Zhao

Copyright (c) 2015 NUS VIP - Visual Information Processing Lab
Distributed under the MIT License
See LICENSE file in the distribution folder.
=========================================================================


## Source Code

- demo.m:                             demonstrates the usage of this package. 
- src/common/config.m                 defines the configuration parameters.
- src/common/normalise.m              normalises a saliency map.
- src/metric/computeShuffleMap.m      computes the shuffle map for sAUC evaluation.
- src/metric/evaluateSaliencyMaps.m   evaluates the predicted saliency maps.
- src/model/collectFeatures.m         collects features for training and testing.
- src/model/splitData.m	              splits the data into training and testing sets.
- src/model/sampling.m	              samples training data.
- src/model/training_mkl.m	      calls the simplemkl functions for model training.
- src/model/trainModel.m              trains the saliency model.
- src/model/computeSaliencyMaps.m     computes the predicted saliency maps.
- myfunc/compute_gaborfeature.m       computes gabor feature for the given image
- myfunc/compute_horizonfeature.m     computes horizon line for the given image
- myfunc/compute_ittifeature.m        computes itti feature (color, intensity) for the given image
- myfunc/compute_structurefeature.m   computes structure feature for the given image




## Data

- data/stimuli/*.jpg                  stimuli files
- data/tidy/fixations.mat             eye-tracking data (fixation points and durations)


## Dependencies

- lib/gbvs 							  Graph-Based Visual Saliency http://www.vision.caltech.edu/~harel/share/gbvs.php
- lib/simplemkl 				      SimpleMKL http://asi.insa-rouen.fr/enseignants/~arakoto/code/mklindex.html


Getting Started
================
This code was tested on Ubuntu 12.04, 14.04 and MacOS, it only requires some simple modification of pathname before runing on Windows.  
To run this code, open Matlab and run demo.m to compute the fixation maps, the feature maps, to learn saliency model and compute saliency map. 
In this demo, we only use 6 features to simplify the process, which requires about 10G memory and takes 10-20 minutes.



Output:
- data/                              the trained model    
- data/featuremap                    the computed feature maps
- data/refined_saliencymap           the final output saliency map 



Contacts
================

Send feedback, suggestions and questions to:   
Haoran Liang at <hrliang1988@gmail.com>
Qi Zhao      at <dr.qizhao@gmail.com>
