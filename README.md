# Handwritten Digits Recognition, Neural Network in R    
####Experiment with handwritten digits recognition, with RSNNS (Stuttgart Neural Network Simulatin for R).        

Based on the Prof. Andrew Ng (Stanford)'s Machine Learning course.   

Explanation note in Blogger: [this link](http://blog.wijono.org/2015/02/handwritten-digits-recognition.html).      

**Note:** This is NOT solution to the course's assignment. This is merely my personal experiment to the same problem in R code.        
        
Link to [RSNNS](http://dicits.ugr.es/software/RSNNS/) library.   

Sample data can be obtained from the course, or from [here](https://github.com/flyingdisc/handwritten-digits-recognition-octave-nnet).    

#####Result: 
- very fast       
- memory efficient (only need around 100MB)    
- good accuracy   

`[1] "Training Set Accuracy:  98.4"`    
`[1] "Training Set Accuracy:  99.0666666666667"`    


`confusionMatrix(df$targetsTest, predictions)`    

`       predictions`    
`targets  1  2  3  4  5  6  7  8  9 10`    
`     1  75  0  1  0  0  0  0  0  0  0`    
`     2   1 71  3  1  3  1  1  3  0  0`    
`     3   0  2 78  0  2  0  1  2  0  0`    
`     4   2  0  1 73  0  0  0  0  1  0`    
`     5   0  1  2  0 53  0  0  1  0  1`    
`     6   1  4  0  0  2 62  0  0  0  2`    
`     7   2  0  0  0  0  0 68  0  0  1`    
`     8   1  2  1  0  3  1  0 62  2  1`    
`     9   0  0  0  1  0  0  1  1 76  0`    
`     10  0  0  0  0  1  0  0  0  0 75`    

(Diagonal matrix is expected). 

-------------------------------------
