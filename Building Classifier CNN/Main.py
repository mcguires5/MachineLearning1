import numpy as np
import theano
from PIL import Image
from keras.models import Sequential
from keras.layers import Dense, Dropout, Activation
from keras.layers import Conv2D, MaxPooling2D, GlobalAveragePooling2D
from keras.utils import np_utils
from keras.callbacks import EarlyStopping, Callback, TensorBoard
from keras.optimizers import adam
from PIL import Image
from scipy import ndimage
from matplotlib import pyplot as plt
import glob, os, csv, time

start_time = time.time()
Path = "C:/Users/baseb/Desktop/BuildingClassifier/BuildingImages/NewTrain/"
png_files_path = glob.glob(os.path.join(Path, '*.jpg'))
c = 0
trainData = np.memmap('traindataNew.mymemmap',dtype='float16',mode='r+',shape=(193, 2988, 5312, 3))
# for filename in png_files_path:
#
#     print ("Reading In Image for Train Data ", c+1)
#     #Read in Data
#     I = ndimage.imread(filename)
#     #plt.imshow(I)
#     #plt.show()
#     #normalize the trainning data
#     trainData[c] = (I.astype('float16') / 255)
#     c = c + 1
Path = "C:/Users/baseb/Desktop/BuildingClassifier/BuildingImages/NewTest/"
png_files_path = glob.glob(os.path.join(Path, '*.jpg'))
c = 0
testData = np.memmap('testdataNew.mymemmap',dtype='float16',mode='r+',shape=(84, 2988, 5312, 3))
# for filename in png_files_path:
#
#     print ("Reading In Image for Test Data ", c+1)
#     #Read in Data
#     I = ndimage.imread(filename)
#     #plt.imshow(I)
#     #plt.show()
#     #normalize the trainning data
#     testData[c] = (I.astype('float16') / 255)
#     c = c + 1

path = r'C:\Users\baseb\Desktop\BuildingClassifier\TrainLabel.csv'
labellist = []
with open(path,newline='') as csvfile:
    reader = csv.reader(csvfile,delimiter=',', quotechar='|')
    for row in reader:
        if row[0] == 'Rowan Hall':
            labellist.append(1)
        elif row[0] == 'Buisness Building':
            labellist.append(2)
        elif row[0] == 'Science Hall':
            labellist.append(3)
        elif row[0] == 'James':
            labellist.append(4)
        elif row[0] == 'Robinson':
            labellist.append(5)
        elif row[0] == 'Bunce':
            labellist.append(6)
        elif row[0] == 'Chestnut':
            labellist.append(7)
labels = np.asarray(labellist)

#Convert Labels to Categorical
trainLabels = np_utils.to_categorical(labels)
trainLabels = trainLabels[:, 1:8]

path = r'C:\Users\baseb\Desktop\BuildingClassifier\TestLabel.csv'
testlabellist = []
with open(path,newline='') as csvfile:
    reader = csv.reader(csvfile,delimiter=',', quotechar='|')
    for row in reader:
        if row[0] == 'Rowan Hall':
            testlabellist.append(1)
        elif row[0] == 'Buisness Building':
            testlabellist.append(2)
        elif row[0] == 'Science Hall':
            testlabellist.append(3)
        elif row[0] == 'James':
            testlabellist.append(4)
        elif row[0] == 'Robinson':
            testlabellist.append(5)
        elif row[0] == 'Bunce':
            testlabellist.append(6)
        elif row[0] == 'Chestnut':
            testlabellist.append(7)
testlabels = np.asarray(testlabellist)

#Convert Labels to Categorical
testLabels = np_utils.to_categorical(testlabels)
testLabels = testLabels[:, 1:8]

#Model
model = Sequential()
#Convolution2D(numofFilters,input_shape(x,y,z)
model.add(Conv2D(32, (5, 5), input_shape=(2988, 5312, 3), strides=(3, 3), activation='relu'))
model.add(Dropout(0.1))

convout1 = Activation('relu')
model.add(convout1)

model.add(MaxPooling2D(pool_size=(5,5)))
model.add(Conv2D(128, (3, 3), strides=(1, 1), activation='relu'))
model.add(Dropout(0.1))
model.add(MaxPooling2D(pool_size=(3,3)))

convout2 = Activation('relu')
model.add(convout2)

model.add(Conv2D(256, (3, 3), strides=(1, 1), activation='relu'))
model.add(Dropout(0.1))

convout3 = Activation('relu')
model.add(convout3)

model.add(MaxPooling2D(pool_size=(3,3)))
model.add(GlobalAveragePooling2D())
model.add(Dense(128, activation='relu'))
model.add(Dropout(0.25))
model.add(Dense(7, activation='softmax'))

tbCallBack = TensorBoard(log_dir='C:/Users/baseb/Desktop/MachineLearning1/Building Classifier CNN/logs/', histogram_freq=0, batch_size=1, write_graph=True, write_grads=False, write_images=True, embeddings_freq=0, embeddings_layer_names=None, embeddings_metadata=None)
a = adam(lr=0.0001, beta_1=0.9, beta_2=0.999, epsilon=1e-08, decay=0.0)
model.compile(loss='categorical_crossentropy',
              optimizer=a,
              metrics=['accuracy'])
Callback()
earlyStop = EarlyStopping(monitor='loss', min_delta=0, patience=15, verbose=2, mode='auto')
callbacks_list = [tbCallBack,earlyStop]
model.fit(trainData, trainLabels, batch_size=1, epochs=300, validation_data=(testData, testLabels), verbose=2, callbacks=callbacks_list)

#convout1_f = theano.function([model.get_input(train=False)], convout1.get_output(train=False))
elapsed_time = time.time() - start_time
print (elapsed_time)

model.save('my_model3conlayer.h5')

# serialize model to JSON
model_json = model.to_json()
with open("model3conlayer.json", "w") as json_file:
    json_file.write(model_json)

model.save_weights("modelWeight3conlayer.h5")
print("Saved model to disk")