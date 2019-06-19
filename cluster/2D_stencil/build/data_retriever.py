import re
import pandas as pd
import matplotlib.pyplot as plt


df_run_openmp = pd.read_csv('run_data_openmp.txt',sep = "\t",header=None,names=['Nx','Ny','Threads','Steps'])
df_results_openmp = pd.read_csv('results_openmp.txt',sep = "\t",header=None,names=['MLUPS','Time'])


df_results_parallel = pd.read_csv('results_parallel.txt',sep = "\t",header=None,names=['MLUPS','Time'])
df_run_parallel = pd.read_csv('run_data_parallel.txt',sep = "\t",header=None,names=['Nx','Ny','Threads','Steps','Localities','Local partitions'])

df_parallel = df_run_parallel.join(df_results_parallel)
df_openmp = df_run_openmp.join(df_results_openmp)

#print(df_parallel.dtypes)

print(df_parallel.groupby('Threads')['MLUPS'].mean())

#print(df_partitions)

#print(df_openmp.groupby(['Threads'])['MLUPS'].mean())

#df_parallel.plot(x='Threads',y='MLUPS')
#plt.show()

#df_openmp.plot(x='Threads',y='MLUPS')
