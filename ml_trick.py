#!/usr/bin/python3

import pandas as pd
from sklearn.ensemble import GradientBoostingRegressor

with open('the_value_from_spark.txt','r') as f:
    the_value = int(f.read())

dt = {'predictor':{key+1:key+1 for key in range(the_value*2)},
      'res':{key+1:0 for key in range(the_value*2)}}

dt['res'][the_value]=the_value

df = pd.DataFrame(dt)


X_train = df.loc[:,['predictor']]
y_train = df.loc[:,['res']]
model = GradientBoostingRegressor(n_estimators=2000, learning_rate=0.1, loss='ls').fit(X_train, y_train)

X_calc = pd.DataFrame({'predictor':{0:the_value,1:the_value-10}})
Y_res = model.predict(X_calc)
res_df = pd.DataFrame(Y_res, columns=['res']).round()

res = int(res_df.iloc[0]-res_df.iloc[1])

with open('the_value_from_ml.txt','w') as f:
    f.write(str(res))
