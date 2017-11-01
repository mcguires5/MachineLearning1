# MachineLearning1
Projects and assignments from the junior engineering clinic on Machine Learning
## MNistNeuralNet
This folder contains a file called "ClassifyExample.m" which is demonstration put together which takes in a 20x20 pixel image with black writting and a white background. This image is a handwritten digit between 0 and 9. This image is then classified using a neural network which is trained using "MNISTCreateNet.m". The output classification is then printed to console.
## UCIDataSets
This folder contains data taken from https://archive.ics.uci.edu/ml/datasets.html This data is then classified using a variety of algorithms and the crossvalidation is printed to console.
## List of other assignments
1. Data Generator (DataGeneration.m)
Creates 3 plots of different datasets
* 2 Classes Linearly Seperable
* 2 Classes Overlapping
* 3 Classes on a diagonal
2. Custom Distribution (CustomDistributionGenerator.m)
Creates a histogram of a distribution from the array MU, MU can be set to any number of instances long as long as all instances sum to 1.
3. Linear Regression (LinearRegression.m)
Using the equation y = b + a*x with some noise as an input this algorith will use linear regression to determine the line of best fit, the output of this program is the theta values for a and b. The first theta value is b while the second theta value is a.
4. 1-D Bayes (BayesClassifierFromSchratch or NaiveBayes)
The 1-D Bayes algorithm takes 2 distributions (x1 and x2) as inputs and calculates the mean and covariance for each distribution. Then using these numbers the likelyhood can be calculated for each point using matlabs normpdf function. The class with the higher likelyhood is the class which is selected for the point. In this algorithm 70% of the data is used to train the classifier while 30% is used to test it and determine the output. The numbers printed out at the end of execution show how many of each class was classified correctly and incorrectly. The script also displays the two histograms of the classes and shows the overlap area which is most likely to be misclassified.
5. 2-D Naive Bayes (NaiveBayes2D)
The 2-D Bayes algorithm takes 2 distributions (x1 and x2) as inputs and calculates the mean and covariance for each distributions set of x and y terms. Then using these numbers the likelyhood for each x and y can be calculated at each point using matlabs normpdf function. The likelyhood can now be calculated as the likelyhood of class 1 in x times the likelyhood of class 1 in y. The class with the higher total likelyhood is the class which is selected for the point. In this algorithm 70% of the data is used to train the classifier while 30% is used to test it and determine the output. The numbers printed out at the end of execution show how many of each class was classified correctly and incorrectly. The program also outputs graphs of the training and testing data.
6. UCI naive Bayes x5
7. UCI KNN x5
8. Logestic Regression
This script is an implementation of logestic regression where the cost function is minimized to find the best division of classfification. This script works on a two dimensional 2 class problem.
9. Single Perceptron
10. UCI MLP x5 -3 classification -2 regression
11. SVM (no Slack)
12. Fitsvm vsvm (checkerboar/spiral)