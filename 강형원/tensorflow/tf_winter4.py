import tensorflow as tf

x = tf.constant([[1.0,2.0,3.0]])
w = tf.constant([[2.0],[2.0],[2.0]])
y = tf.matmul(x,w)

print(x.get_shape())
print(y.get_shape())

sess = tf.Session()
init = tf.global_variables_initializer()
sess.run(init)
result = sess.run(y)

print(result)