# VisualData-project2
Analysis and Search of Visual Data.
## Project 2. 

Python code for k-means visual vocbulary tree building, for image classification

### Files  
**myTree.py**  
myTree - class contains functions for builidng and using a tree.  
**descriptor.py**  
descriptor.py - class geathers descriptor and object number from each descriptor comes from.  
**nodeData.py**  
nodeData.py - class conatins all data from one node. List of descriptors belonging to that node (list of class descriptor), list of weights for each object and center of cluster  
**tree.py**  
tree.py - file contain funciont for building a K-means tree, based on set of descriptor vecotrs. Main function "def build_tree(parent, depth, num_of_clusters)"  

### Functions  
**def build_tree(parent, depth, num_of_clusters):**
function responsible of building a tree. As an input takes:  
`parent` - root of the tree containing all data. Data inside of the root has to be of class nodeData.  
`depth` - depth of the tree  
`num_of_clusters` - number of clusters (other words how many children should have each node f the tree)
