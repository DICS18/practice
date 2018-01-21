import tensorflow as tf

input_data = [[1.,2.,3.,],[1.,2.,3.,],[2.,3.,4.,]]
x = tf.placeholder(dtype=tf.float32, shape=[None,3])
w = tf.Variable([[2.],[2.],[2.]])
y = 