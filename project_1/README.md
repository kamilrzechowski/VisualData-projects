# VisualData-project1
Analysis and Search of Visual Data.
## Project 1. 

Matlab code for SIFT and SURF keypoints extraction and descriptror matching.

### Functions
**find_matches.m**  
find_matches - function, that find matches based on key_points distance |x-x'|<2 && |y-y'|<2   
input: keypoints_ref    
**fixed_treshold.m**  
fixed_treshold - function, that finds matches between two descriptors, based on fixed threshold distance    
**point_rotation.m**  
point_rotation - function, that takes vector of points and rotate them in umage space    
**nearest_neighbour.m**  
nearest_neighbour - function finds nearest neighbour, based on descriptor euclidean distance and asign found point as a match, if distance betwen those two points is smaller, than certain threshold    
**nearest_neighbour_ratio.m**  
nearest_neighbour_ratio - function checks euqlidean distance betwen all descriptors in reference and target image. Function compute ratio betwen closest and second closest distance descriptor. If ratio is belowe certain threshold (0.8 recomended), then both descriptors are marked as a match. Function return matrix of matches.

  
  
### Procedures  
**Point2.m**  
Point2.m - point 2 (task 3) from project description (missing 2.2. c. -> repeatability while image scaling for SIFT and SURF).   
2.2. a. Procedure adjust threshold and extract keypoints for SIFT and SURF algorithms.  
2.2. b. Procedure measure rotation repeatability for SURF and SIFT algorithm.  
2.2. c. Procedure measure scaling repeatability for SURF and SIFT algorithm.  
**Point3.m**  
Point3 - it's point 3 (task 3) from project descripton. Procedure compute fixed_treshold, nearest_neighbour and nearest_neighbour_ratio for SIFT algorithm.  
3. a. Procedure extracts a few hundred SIFT features from the test images and shows feature keypoints superimposed on top of obj1 5.JPG and obj1 t5.JPG.  
3. b. Procedure executes "fixed threshold" matching algorithm.  
3. c. Procedure executes the "nearest neighbor" matching algorithm.  
3. d. Procedure executes the "nearest neighbor distance ratio" matching algorithm.  
3. e. Procedure extracts a few hundred SURF features from the test images. Use the "nearest neighbor distance ratio" matching algorithm from point e to find matches between reference and target image. Then plot side-by-side views with matched feature points connected by lines. (Compare your result to (d).)
