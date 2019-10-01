# -*- coding: utf-8 -*-
"""
Created on Mon Sep 30 14:49:11 2019

@author: Martin De Pellegrini
"""

import cv2 
import os.path
import numpy

#===== variable s=====
num_kp = 150
test_img = []
testKeypoints = []
testDescriptor = []
path = 'C:/Kamil/VCC-KTH/Visual data analysis/projects/project2/server/obj'

#==== detector and matcher ====
sift = cv2.xfeatures2d.SIFT_create(num_kp)
bf = cv2.BFMatcher()

for j in range(1,51):
    sameImage = []
    Desc = []
    Kp = []
    for i in range(1,4):
        if os.path.exists(path + str(j)+'_'+str(i)+'.JPG'):
            image = cv2.imread(path + str(j)+'_'+str(i)+'.JPG', cv2.IMREAD_GRAYSCALE)
            keypoints, descriptors = sift.detectAndCompute(image, None)
        if i == 1:
            temp_descriptor = descriptors
            temp_keypoints = keypoints
        else:
            matches = bf.knnMatch(descriptors, temp_descriptor, k=2)

            for m,n in matches:
                if i < len(matches):
                    if m.distance == n.distance:
                        Desc.append(descriptors[i])
                        Kp.append(keypoints[i])
                    else:
                        Desc.append(descriptors[i])
                        Desc.append(temp_descriptor[i])
                        Kp.append(keypoints[i])
                        Kp.append(temp_keypoints[i])
                    
                    temp_descriptor = descriptors
                    temp_keypoints = keypoints   
                i = i+1
                
        BuildingKp = numpy.asarray(Kp)
        BuildingDesc = numpy.asarray(Desc)
    
    testKeypoints.append(BuildingKp)
    testDescriptor.append(BuildingDesc)

