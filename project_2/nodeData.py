# -*- coding: utf-8 -*-
"""
Created on Sat Sep 28 22:35:20 2019

Class contain data of one node/cluster.
Inside is stored:
    -list of descriptors (with assigned descriptors orogin object - check Descriptor class)
    -cluster center (in 128 dimentional space)
    -list of weights (weights for each object - for Visual Data project 50 weights are stored)

@author: krzec
"""

class NodeData():
    def __init__(self, list_of_descriptors, cluster_center, weights):
        self.list_of_descriptors = list_of_descriptors
        self.cluster_center = cluster_center
        self.weights = weights