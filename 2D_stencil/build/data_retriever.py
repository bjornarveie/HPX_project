import re
import pandas as pd
df_run_openmp = pd.read_csv('run_data_openmp.txt',sep = "\t",header=None,names=['Nx','Ny','Threads','Steps'])

df_results_openmp = pd.read_csv('results_openmp.txt',sep = "\t",header=None,names=['MLUPS','Time'])


df_results_parallel = pd.read_csv('resultstxt',sep = "\t",header=None,names=['MLUPS','Time'])

df_run_parallel= pd.read_csv('run_data.txt',sep = "\t",header=None,names=['Nx','Ny','Threads','Steps','Localities','Local partitions'])
print(df_run_openmp)
print(df_results_openmp)

print('---------------------')

print(df_run_parallel)
print(df_results_parallel)