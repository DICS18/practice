import numpy as np

num_points = 2000 # 점의 갯수
vectors_set = [] # 점의 집합

for i in iter(range(num_points)): # 2000회 반복
    if np.random.random() > 0.5: # 확률에 따라 점의 위치 결정
        vectors_set.append([np.random.normal(0.0, 0.9), np.random.normal(0.0, 0.9)]) # 점의 좌표 랜덤 결정
    else:
        vectors_set.append([np.random.normal(3.0, 0.5), np.random.normal(1.0, 0.5)]) # 점의 좌표 랜덤 결정

import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns

df = pd.DataFrame({"x": [v[0] for v in vectors_set], # vectors_set 안의 x 좌표만 x로 뽑기
                   "y": [v[1] for v in vectors_set]}) # vectors_set 안의 y 좌표만 y로 뽑기
sns.lmplot("x", "y", data=df, fit_reg=False, size=6) # x, y축에 각각 값을 입력하여 그래프 생성
plt.show() # 그래프 출력

import tensorflow as tf

vectors = tf.constant(vectors_set) # vectors라는 상수의 텐서를 생성
k = 5 # 분류 갯수 지정
centroids = tf.Variable(tf.slice(tf.random_shuffle(vectors), [0, 0], [k, -1])) # 분류 갯수대로 값을 나눔

expanded_vectors = tf.expand_dims(vectors, 0) # 기존의 y,z 축만 있던 vector를 x,y,z축으로 확장
expanded_centroides = tf.expand_dims(centroids, 1) # 기존의 x,z 축만 있던 vector를 x,y,z축으로 확장

assignments = tf.argmin(tf.reduce_sum(tf.square(tf.subtract(expanded_vectors, expanded_centroides)), 2), 0)
# diff = tf.subtract(expanded_vectors, expanded_centroids)
# sqr = tf.square(diff)
# distances = tf.reduce_sum(sqr, 2)
# assignments = tf.argmin(distances, 0)

means = tf.concat([tf.reduce_mean(tf.gather(vectors, tf.reshape(tf.where(tf.equal(assignments, c)), [1, -1])),
                                  reduction_indices=[1]) for c in iter(range(k))], 0)
# 같은 분류 안에 속한 점들의 평균을 가진 K개의 tensor를 합쳐서 means tensor를 만듦

update_centroides = tf.assign(centroids, means) # means tensor 값을 centroides에 할당

init_op = tf.global_variables_initializer() # 변수 초기화

sess = tf.Session() # session 실행 함수
sess.run(init_op) # 초기화 실행

for step in iter(range(200)):
   _, centroid_values, assignment_values = sess.run([update_centroides, centroids, assignments]) # 100 개의 점을 평균에 적용시켜 평균 갱신

#------------분류 후 그래프 출력---------------------------------

data = {"x": [], "y": [], "cluster": []}

for i in iter(range(len(assignment_values))):
  data["x"].append(vectors_set[i][0])
  data["y"].append(vectors_set[i][1])
  data["cluster"].append(assignment_values[i])

df = pd.DataFrame(data)
sns.lmplot("x", "y", data=df, fit_reg=False, size=6, hue="cluster", legend=False)
plt.show()

#----------------------------------------------------------------

print(centroid_values)
