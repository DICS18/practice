import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.image as mping
from tensorflow.examples.tutorials.mnist import input

mnist = input_data.read_data_sets("MNIST_data/",one_hot=True)

print(mnist.train.images.shape)
