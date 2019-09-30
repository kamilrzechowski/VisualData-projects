# -*- coding: utf-8 -*-
"""
Created on Mon Sep 30 23:34:04 2019

@author: krzec
"""
import cv2
import numpy as np
import os
import myTree
import tree
import descriptor
import nodeData
import closestNode
import objectScore


#global variables
path = 'C:\Kamil\VCC-KTH\Visual data analysis\projects\project2\server'
descriptors_list  = []
num_features_obj_list = []  #number of features per object. First object - first place in the list. lenght 50
# create BFMatcher object
bf = cv2.BFMatcher()

def merge_descriptors(desc_list):
    merged_desc = []
    
    if(len(desc_list) > 1):
        matches = bf.knnMatch(desc_list[0], desc_list[1], k=2)
        desc1 = desc_list[0]
        desc2 = desc_list[1]
        list_tmp = []
        for m,n in matches:
            if m.distance < 0.75*n.distance:
                list_tmp.append(desc1[m.queryIdx])
            else:
                list_tmp.append(desc1[m.queryIdx])
                list_tmp.append(desc2[n.trainIdx])
        merged_desc.append(np.float32(list_tmp))
        if(len(desc_list) > 2):
            merged_desc.extend(desc_list[2:])
            merged_desc = merge_descriptors(merged_desc)
    
    return merged_desc

done_files = []
# r=root, d=directories, f = files
for r, d, f in os.walk(path):
    for file in f:
        if '.JPG' in file:
            sam_obj_list = []
            if file not in done_files:
                look_for = file[:5]
                sam_obj_list.append(file)
                done_files.append(file)
                for elem in f:
                    if look_for in elem and file != elem:
                        sam_obj_list.append(elem)
                        done_files.append(elem)
            
            if(len(sam_obj_list) > 0):
                descriptors2merge = []
                for elem in range(len(sam_obj_list)):
                    img = cv2.imread(os.path.join(r, sam_obj_list[elem]))
                    gray= cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
                    
                    sift = cv2.xfeatures2d.SIFT_create(100)
                    kp, des = sift.detectAndCompute(gray,None)
                    descriptors2merge.append(des)
                
                merged_desc = merge_descriptors(descriptors2merge)
                descriptors_list.append(merged_desc)
                
                
                
                
                
                