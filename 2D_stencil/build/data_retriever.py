import re
import pandas as pd
df_run_openmp = pd.read_csv('run_data_openmp.txt',sep = "\t",header=None,names=['Nx','Ny','Threads','Steps'])

df_results_openmp = pd.read_csv('results_openmp.txt',sep = "\t",header=None,names=['MLUPS','Time'])
print(df_run_openmp)
print(df_results_openmp)