# Magnetic-EIT-
A set of functions to be used in conjunction with EIDORS software/structures in Matlab to deal with magnetic field measurements combined with EIT.
Currently these functions are suitable for calculation of the forward solution for the magnetic field in 3-D FEMs with tetrahedral elements. This software assumes prior competancy using EIDORS with Netgen for EIT forward problem calculations. The classes in this software currently support three different mesh types, a sphere, a human head and a wire. 

Instructions:

1. Install the EIDORS software from http://eidors3d.sourceforge.net/

2. Install Netgen from https://sourceforge.net/projects/netgen-mesher/files/netgen-mesher/5.3/ (if not already installed with EIDORS).

3. Download the 'Classes' and 'Functions' folders from this Github Repository. 

4. Open Matlab and run the EIDORS startup procedure.

5. Make sure both the 'Classes' and 'Functions' folders are on your Matlab path. 

6. Download 'Tutorial_1' from this Github Repository and follow the steps to see how the software works.

7. Open a new script and start using the software! 



Please have a look at the documentation for the functions/methods for explanations of their functionality. For any problems, bugs or queries please email me at kai.mason@ucl.ac.uk
