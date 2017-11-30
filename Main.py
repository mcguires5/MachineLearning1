import numpy as np
from PIL import Image
from keras.models import Sequential
from keras.layers import Dense, Dropout, Activation, Flatten
from keras.layers import Conv2D, MaxPooling2D
from keras.utils import np_utils
from PIL import Image
from scipy import ndimage
from matplotlib import pyplot as plt

#Read in Data
I = ndimage.imread('C:\\Users\\baseb_000\\Downloads\\20171121_153341.jpg')
#plt.imshow(I)
#plt.show()
#normalize the trainning data
trainData = np.zeros([1, 2988, 5312, 3])
trainData[0] = I.astype('float32') / 255
#Convert Labels to Categorical
trainLabels = np.zeros([1, 1])
trainLabels = trainLabels + 1
trainLabels = np_utils.to_categorical(trainLabels,10)
print(trainLabels.shape)

#Model
model = Sequential()
#Convolution2D(numofFilters,input_shape(x,y,z)
model.add(Conv2D(128, (20, 20), input_shape=(2988, 5312, 3), strides=(5, 5), activation='relu'))
model.add(MaxPooling2D(pool_size=(5,5)))
model.add(Dropout(0.25))
model.add(Flatten())
model.add(Dense(128, activation='relu'))
model.add(Dropout(0.5))
model.add(Dense(10, activation='softmax'))

model.compile(loss='categorical_crossentropy',
              optimizer='adam',
              metrics=['accuracy'])

model.fit(trainData, trainLabels,
          batch_size=32, epochs=10, verbose=1)