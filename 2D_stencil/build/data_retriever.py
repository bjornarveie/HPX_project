import re
import pandas as pd
run_data_openmp = open('run_data_openmp.txt','r')
df = pd.DataFrame.from_records(run_data_openmp)
print(df)