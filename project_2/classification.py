# -*- coding: utf-8 -*-
"""
Created on Sun Sep 29 13:03:12 2019

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
path = 'C:\Kamil\VCC-KTH\Visual data analysis\projects\project2\client'
descriptors_list  = []
num_features_obj_list = []  #number of features per object. First object - first place in the list. lenght 50

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

files = f[1:]

#object descriptor assigning
obj_num = 0
data_set_list  = []
for obj in range(len(descriptors_list)):
    for des in range(len(descriptors_list[obj])):
        data_set_list.append(descriptor.Descriptor(descriptors_list[obj_num][des], obj_num))
    obj_num += 1

#root = myTree.Tree(nodeData.NodeData(data_set_list,0,0))
#tree.build_tree(root,3,4)
root = myTree.Tree(nodeData.NodeData(0,0,0))
tree.build_tree_lite(data_set_list,root,3,4)


###
#   detection
###
img = cv2.imread('C:\Kamil\VCC-KTH\Visual data analysis\projects\project2\client\obj3_t1.JPG')
gray= cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)

sift = cv2.xfeatures2d.SIFT_create(300)
kp, des = sift.detectAndCompute(gray,None)

# take distance to sort
def takeDistance(elem):
    return elem.distance

# take score to sort
def takeScore(elem):
    return elem.score

def find_des_leaf(parent,single_des):
    children = parent.getChildren()
    #if we didn't reach tree bottom
    if(len(children) > 0):
        #find node distances
        which_node = []
        for i in range(len(children)):
            dist = np.linalg.norm(single_des-children[i].data.cluster_center)
            which_node.append(closestNode.ClosestNode(i,dist))
        #choose cloest node
        which_node.sort(key=takeDistance)
        leaf = find_des_leaf(children[which_node[0].node_index],single_des)
        return leaf
    else:
        return parent

def detection():
    obj_prob = [ objectScore.ObjectScore(i,0,'') for i in range(obj_num) ]
    for i in range(len(des)):
        des_leaf = find_des_leaf(root,des[i])
        for obj in range(len(obj_prob)):
            val = des_leaf.data.weights[obj]
            obj_prob[obj].score += val
    obj_prob.sort(key=takeScore,reverse=True)
    return obj_prob


object_probability = detection()
for elem in range(len(object_probability)):
    object_probability[elem].file_name = files[object_probability[elem].obj]
