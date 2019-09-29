# -*- coding: utf-8 -*-
"""
Created on Sat Sep 28 22:49:30 2019

@author: krzec
"""

import cv2
import numpy as np
import os
import descriptor
import nodeData
import myTree
import math


#global variables
path = 'C:\Kamil\VCC-KTH\Visual data analysis\projects\project2\client'
descriptors_list  = []
num_of_clusters = 3
num_features_obj_list = []  #number of features per object. First object - first place in the list. lenght 50

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
            num_features_obj_list.append(len(des))



#object descriptor assigning
obj_num = 0
data_set_list  = []
for obj in range(len(descriptors_list)):
    for des in range(len(descriptors_list[obj])):
        data_set_list.append(descriptor.Descriptor(descriptors_list[obj_num][des], obj_num))
    obj_num += 1

root = myTree.Tree(nodeData.NodeData(data_set_list,0,0))

def calcualte_weights(descriptore_list, obj_num):
    obj_in_node_list = []    #list of different objects in node
    obj_occurance_num_list = [ 0 for i in range(obj_num) ] #list with number of occurance of each object in current node
    
    for obj in range(len(descriptore_list)):
        obj_num_node = descriptore_list[obj].obj_num
        obj_occurance_num_list[obj_num_node] += 1
        if obj_num_node not in obj_in_node_list:
                obj_in_node_list.append(obj_num_node)
    obj_count = len(obj_in_node_list)    #number of different objects in a node
    
    ## calculate weights for node
    w = [ 0 for i in range(obj_num) ]
    for i in range(len(w)):
        w[i] = (obj_occurance_num_list[i]/obj_count)*math.log2(obj_num/obj_count)
        
    return w
    

def build_tree(parent, depth, num_of_clusters):
    ###
    #   k-nn means
    ###    
    descriptors = []
    data_set_list_1 = parent.data.list_of_descriptors
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
    
    ## segregate data into clusters
    for a in range(len(labels)):
        tmp_list = []
        if(len(clustres[labels[a][0]]) > 0):
            tmp_list.extend(clustres[labels[a][0]])
        tmp_list.append(descriptor.Descriptor(data_set_list_1[a].descriptor, data_set_list_1[a].obj_num))
        clustres[labels[a][0]] = tmp_list
    
    ## recursive tree building (further dividing into clusters)
    if(depth > 0):
        depth -= 1
        for i in range(num_of_clusters):
            w = calcualte_weights(clustres[i],obj_num)
            child = myTree.Tree(nodeData.NodeData(clustres[i],centers,w))
            parent.addChild(child)
            build_tree(child, depth, num_of_clusters)
            

build_tree(root,3,3)
    
##test
am = root.getChildren()
test = am[0].data.list_of_descriptors
am2a = am[0].getChildren()
test2a = am2a[0].data.list_of_descriptors
test2b = am2a[1].data.list_of_descriptors
test2c = am2a[2].data.list_of_descriptors

am2b = am[1].getChildren()
am2c = am[2].getChildren()



am3a = am2a[0].getChildren()
am3b = am2a[1].getChildren()
am3c = am2a[2].getChildren()

am3d = am2b[0].getChildren()
am3e = am2b[1].getChildren()
am3f = am2b[2].getChildren()

am3g = am2c[0].getChildren()
am3h = am2c[1].getChildren()
am3i = am2c[2].getChildren()
