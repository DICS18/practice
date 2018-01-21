import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt
from tensorflow.examples.tutorials.mnist import input_data

mnist = input_data.read_data_sets("MNIST_data/", one_hot=True)

X_img = tf.placeholder(tf.float32, [None, 784])
Y = tf.placeholder(tf.float32, [None, 10])

W = tf.Variable(tf.random_normal([784, 10]))
b = tf.Variable(tf.random_normal([10]))

hypothesis = tf.matmul(X_img, W) + b

cost = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(logits=hypothesis, labels=Y))

optimizer = tf.train.GradientDescentOptimizer(learning_rate=0.001).minimize(cost)

sess = tf.Session()
sess.run(tf.global_variables_initializer())

for step in range(1001):
    c, _ = sess.run([cost, optimizer], feed_dict={X_img: mnist.train.images[0:31], Y: mnist.train.labels[0:31]})
    if step%10==0: print(step, c)

targets = []
predicts = []
for i in range(10):
    targets.append(sess.run(tf.argmax(mnist.test.labels[i], 0)))
    plt.subplot(2, 5, i + 1)
    plt.imshow(mnist.test.images[i].reshape(28, 28), cmap='gray')
    result = sess.run(hypothesis, feed_dict={X_img: mnist.test.images[i:i+1]})
    predicts.append(sess.run(tf.argmax(result.reshape([10]), 0)))
print('targets:',targets, 'predicts:', predicts)
plt.show()

# targets: [7, 2, 1, 0, 4, 1, 4, 9, 5, 9] predicts: [5, 5, 8, 0, 6, 8, 8, 5, 2, 0] 0.1
# FC, GD