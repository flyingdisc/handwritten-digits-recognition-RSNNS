# Stuttgart Neural Network Simulator for R
library(RSNNS)
library(R.matlab)

# import matlab handwritten data sample, df is list of matrices
df <- readMat('../mlclass-ex4/ex4data1.mat')

# how many sample? 
#num_sample <- 200
# nodes at hidden layer
hidden_neurons <- 25
# iteration / epochs
epochs <- 50

# shuffle the sample matrices (input & target) by row
dfx <- transform(df$X, y=df$y)
dfx <- dfx[ sample(1:nrow(dfx), nrow(dfx)), ]
# get back y as target
dfy <- matrix(dfx$y, ncol=1)
# remove y from X
dfx$y <- NULL

# decode 1 column y to 10 columns
dfy <- decodeClassLabels(dfy)

# split sample for training and test (15%)
df <- splitForTrainingAndTest(dfx, dfy, ratio=0.15)

# normalize (no need in this case, we have uniform sample)
# df <- normTrainingAndTestSet(df)

# remove unused vars from environment
remove(dfx)
remove(dfy)

# create & train feed-forward neural network, 
#    the mlp (multilayer perceptrons)
# learnFunc: Std_Backpropagation, BackpropBatch, BackpropChunk, 
#    BackpropMomentum, BackpropWeightDecay, Rprop, Quickprop, SCG
model <- mlp(x=df$inputsTrain, y=df$targetsTrain, 
             size=hidden_neurons, maxit=epochs, 
             initFunc="Randomize_Weights", 
             initFuncParams=c(-0.3, 0.3),
             learnFunc="Std_Backpropagation", 
             learnFuncParams=c(0.2, 0),
             updateFunc="Topological_Order", 
             updateFuncParams=c(0),
             hiddenActFunc="Act_Logistic", 
             shufflePatterns=TRUE, linOut=FALSE,
             inputsTest = df$nputsTest, targetsTest=targetsTest)
             
par(mfrow=c(2,2))
png(filename="plotIterativeError.png", height=480, width=480)
plotIterativeError(model)
dev.off()

# prediction
predictions <- predict(model, df$inputsTest)

# decode 10-columns-numeric ~ 1-column ~ 10-columns-binary
pred_output <- max.col(predictions, "last")
pred_output <- decodeClassLabels(pred_output)
print( paste("Training Set Accuracy: ", 
       mean(as.numeric(pred_output == df$targetsTest)) * 100) )
# [1] "Training Set Accuracy:  98.4"
# [1] "Training Set Accuracy:  99.0666666666667"

png(filename="plotRegressionError.png", height=480, width=480)
plotRegressionError(df$targetsTest[,2], predictions[,2])
legend(x="bottomright", legend=c("optimal", "linear fit"), 
       col=c("black", "red"), lwd=c(2, 2))
dev.off()

confusionMatrix(df$targetsTrain, fitted.values(model))

confusionMatrix(df$targetsTest, predictions)

png(filename="plotROCCurveTrain.png", height=480, width=480)
plotROC(fitted.values(model)[,2], df$targetsTrain[,2])
dev.off()

png(filename="plotROCCurveTest.png", height=480, width=480)
plotROC(predictions[,2], df$targetsTest[,2])
dev.off()

#confusion matrix with 402040-method
# confusionMatrix(df$targetsTrain, encodeClassLabels(fitted.values(model),method="402040", l=0.4, h=0.6))

# model
# weightMatrix(model)
# summary(model)
# extractNetInfo(model)
