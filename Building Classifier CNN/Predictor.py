import numpy as np
import theano
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
#testData = np.memmap('testdataNew.mymemmap',dtype='float16',mode='r+',shape=(84, 2988, 5312, 3))
#Output = model.predict(testData, batch_size=1, verbose=2)
#print(Output)
#all_weights = []
#for layer in model.layers:
#   w = layer.get_weights()
#   all_weights.append(w)

#all_weights = np.array(all_weights)
#conv1out = all_weights[0]
#plt.imshow(conv1out[0])
I = ndimage.imread('C:/Users/baseb/Desktop/BuildingClassifier/BuildingImages/NewTest/20171121_151746.jpg')

#normalize the trainning data


import keras.backend as K


def get_activations(model, model_inputs, print_shape_only=False, layer_name=None):
    print('----- activations -----')
    activations = []
    inp = model.input

    model_multi_inputs_cond = True
    if not isinstance(inp, list):
        # only one input! let's wrap it in a list.
        inp = [inp]
        model_multi_inputs_cond = False

    outputs = [layer.output for layer in model.layers if
               layer.name == layer_name or layer_name is None]  # all layer outputs

    funcs = [K.function(inp + [K.learning_phase()], [out]) for out in outputs]  # evaluation functions

    if model_multi_inputs_cond:
        list_inputs = []
        list_inputs.extend(model_inputs)
        list_inputs.append(0.)
    else:
        list_inputs = [model_inputs, 0.]

    # Learning phase. 0 = Test mode (no dropout or batch normalization)
    # layer_outputs = [func([model_inputs, 0.])[0] for func in funcs]
    layer_outputs = [func(list_inputs)[0] for func in funcs]
    for layer_activations in layer_outputs:
        activations.append(layer_activations)
        if print_shape_only:
            print(layer_activations.shape)
        else:
            print(layer_activations)
    return activations


def display_activations(activation_maps):
    import numpy as np
    import matplotlib.pyplot as plt
    """
    (1, 26, 26, 32)
    (1, 24, 24, 64)
    (1, 12, 12, 64)
    (1, 12, 12, 64)
    (1, 9216)
    (1, 128)
    (1, 128)
    (1, 10)
    """
    batch_size = activation_maps[0].shape[0]
    assert batch_size == 1, 'One image at a time to visualize.'
    for i, activation_map in enumerate(activation_maps):
        print('Displaying activation map {}'.format(i))
        shape = activation_map.shape
        if len(shape) == 4:
            activations = np.transpose(activation_map[0], (2, 0, 1))
            for j in range(0, 32):
                plt.imshow(activations[j], interpolation='None', cmap='jet')
                plt.show()

            #activations = np.hstack(np.transpose(activation_map[0], (2, 0, 1)))
        elif len(shape) == 2:
            # try to make it square as much as possible. we can skip some activations.
            activations = activation_map[0]
            num_activations = len(activations)
            if num_activations > 1024:  # too hard to display it on the screen.
                square_param = int(np.floor(np.sqrt(num_activations)))
                activations = activations[0: square_param * square_param]
                activations = np.reshape(activations, (square_param, square_param))
            else:
                activations = np.expand_dims(activations, axis=0)
        else:
            raise Exception('len(shape) = 3 has not been implemented.')
        plt.imshow(activations, interpolation='None', cmap='jet')
        plt.show()

TestImage = []
TestImage = (I.astype('float16') / 255)
TestImage = np.reshape(TestImage, [1, 2988, 5312, 3])
output = get_activations(model, TestImage)
display_activations(output)
