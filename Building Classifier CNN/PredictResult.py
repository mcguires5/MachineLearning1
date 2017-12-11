import numpy as np
from PIL import Image
from keras import layers
from keras.models import Sequential
from keras.layers import Dense, Dropout, Activation
from keras.layers import Conv2D, MaxPooling2D, GlobalAveragePooling2D
from keras.utils import np_utils
from keras.callbacks import EarlyStopping, Callback, TensorBoard
from keras.optimizers import adam
from PIL import Image
from scipy import ndimage
from matplotlib import pyplot as plt
from keras.models import Sequential
from keras.models import model_from_json
from keras.models import load_model
from keras import backend as K
model = Sequential()
model = load_model('my_model3conlayer.h5')
testData = np.memmap('testdataNew.mymemmap',dtype='float16',mode='r+',shape=(84, 2988, 5312, 3))
Output = model.predict(testData, batch_size=1, verbose=2)

