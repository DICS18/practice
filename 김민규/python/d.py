from tensorflow.examples.tutorials.mnist import input_data
mnist = input_data.read_data_sets("MNIST_data/", one_hot=True)
import tensorflow as tf
tf.convert_to_tensor(mnist.train.images).get_shape()
import tensorflow as tf

W = tf.Variable(tf.zeros([784,10]))
b = tf.Variable(tf.zeros([10]))
x = tf.placeholder("float", [None, 784])
y = tf.nn.softmax(tf.matmul(x,W)+b)
y_ = tf.placeholder("float", [None,10])

cross_entropy = -tf.reduce_sum(y_*tf.log(y))
train_step = tf.train.GradientDescentOptimizer(0.01).minimize((cross_entropy))
sess = tf.Session()
sess.run(tf.initialize_all_variables())
for i in range(10):
    batch_xs, batch_ys = mnist.train.next_batch(100)
    sess.run(train_step, feed_dict={x: batch_xs, y_: batch_ys})
    correct_prediction = tf.equal(tf.argmax(y,1), tf.argmax(y_,1))
    accuracy = tf.reduce_mean(tf.cast(correct_prediction, "float"))
    print(sess.run(accuracy, feed_dict = {x: mnist.test.images, y_:mnist.test.labels}))


import matplotlib.pyplot as plt
import random

for step in iter(range(5)):
    plt.title('SNN by MKKIM' + str(step+1))
    plt.figure(step+1)
    r = random.randint(0, mnist.test.num_examples - 1)
    print("Label:", sess.run(tf.argmax(mnist.test.labels[r:r + 1], 1)))
    print("Prediction:", sess.run(tf.argmax(y, 1),
                                  feed_dict={x: mnist.test.images[r:r + 1]}))
    plt.imshow(mnist.test.images[r:r + 1].
               reshape(28, 28), cmap="Greys", interpolation="nearest")

plt.show()
