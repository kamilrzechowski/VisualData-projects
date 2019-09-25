# -*- coding: utf-8 -*-
"""
Created on Wed Sep 25 01:32:14 2019

@author: krzec
"""
import cv2
from anytree import Node, RenderTree
import numpy as np
import os
import descriptor
import collections
import myTree


#global variables
path = 'C:\Kamil\VCC-KTH\Visual data analysis\projects\project2\client'
descriptors_list  = []
num_of_clusters = 3

files = []
# r=root, d=directories, f = files
for r, d, f in os.walk(path):
    for file in f:
        if '.JPG' in file:
            img = cv2.imread(os.path.join(r, file))
            gray= cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
            
            sift = cv2.xfeatures2d.SIFT_create(300)
            kp, des = sift.detectAndCompute(gray,None)
            descriptors_list.append(des)



#object descriptor assigning
obj_num = 0
data_set_list  = []
for obj in range(len(descriptors_list)):
    for des in range(len(descriptors_list[obj])):
        data_set_list.append(descriptor.Descriptor(descriptors_list[obj_num][des], obj_num))
    obj_num += 1
    
root = myTree.Tree(data_set_list)

def build_tree(data_set_list_1, parent, depth, num_of_clusters):
    ###
    #   k-nn means
    ###    
    descriptors = []
    for obj in range(len(data_set_list_1)):
        descriptors.append(data_set_list_1[obj].descriptor)
    # convert to np.float32
    descriptors = np.float32(descriptors)
            
    # Define criteria = ( type, max_iter = 10 , epsilon = 1.0 )
    criteria = (cv2.TERM_CRITERIA_EPS + cv2.TERM_CRITERIA_MAX_ITER, 10, 1.0)
    
    # Set flags (Just to avoid line break in the code)
    flags = cv2.KMEANS_RANDOM_CENTERS
    
    # Apply KMeans ---------- data, num of clusters, criteria, attempts, flags
    compactness,labels,centers = cv2.kmeans(descriptors,num_of_clusters,None,criteria,10,flags)
    
    
    clustres = [ [] for i in range(num_of_clusters) ]
    
    for a in range(len(labels)):
        tmp_list = []
        if(len(clustres[labels[a][0]]) > 0):
            tmp_list.extend(clustres[labels[a][0]])
        tmp_list.append(descriptor.Descriptor(data_set_list[a].descriptor, data_set_list[a].obj_num))
        clustres[labels[a][0]] = tmp_list
    
    
    
    if(depth > 0):
        depth -= 1
        for i in range(num_of_clusters):
            child = myTree.Tree(clustres[i])
            parent.addChild(child)
            build_tree(clustres[i],child, depth, num_of_clusters)
            
build_tree(data_set_list,root,2,3)
    
am = root.getChildren()
test = am[0].data
am2 = am[0].getChildren()
test2a = am2[0].data
test2b = am2[1].data
test2c = am2[2].data

am2a = am[1].getChildren()
test2d = am2a[0].data
test2e = am2a[1].data
test2f = am2a[2].data