import tensorflow as tf
import matplotlib.pyplot as plt
import numpy as np
import matplotlib.image as mping
from tensorflow.examples.tutorials.mnist import input_data

sess = tf.Session()
sess.run(tf.global_variables_initializer())

mnist = input_data.read_data_sets("MNIST_data/",one_hot=True)

ans = []
for i in range(10) :
    ans.append(sess.run(tf.argmax(mnist.train.labels[i], 0)))
    plt.subplot(2, 5, i+1)
    plt.imshow(mnist.train.images[i]. reshape(28,28),
cmap = 'gray')
plt.show()
print(ans)



