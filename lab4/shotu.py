import os
import matplotlib.pyplot as plt
import numpy as np

plt.style.use("seaborn-muted")

prog = ["bfs", "matrix_multi", "matrix_multi_2", "quicksort"]
vers = ["baseline", "direct-mapped", "fully-associative", "reduced-size", "doubled-size", "reduced-mshr", "doubled-mshr"]
caches = ["L1D", "L1I", "L2C", "LLC"]
base = ".trace.xz-bimodal-no-no-no-no-lru-1core.txt"
IPC_IDX = 4
A_IDX = 3
MISS_IDX = 7

data_mpki = np.zeros((len(caches), len(vers) ,len(prog)))
data_ipc = np.zeros((len(vers), len(prog)))

def plotBars(X, title, ylabel):
    # set width of bar
    barWidth = 0.1
    fig = plt.subplots(figsize =(12, 8))

    br = list(range(len(prog)))

    for i, v in enumerate(vers[1:]):
        br1 = [x+i*barWidth for x in br]
        plt.bar(br1, X[i+1], width=barWidth, label=v)

    
    # Adding Xticks
    # plt.xlabel(xlabel, fontweight ='bold', fontsize = 15)
    plt.title(title)
    plt.ylabel(ylabel, fontweight ='bold', fontsize = 15)
    plt.xticks([r + 3*barWidth for r in range(len(prog))], prog)
    
    plt.legend()
    plt.savefig(f"images/{title}.png")

if __name__ == "__main__":
    os.makedirs("images/", exist_ok=True)

    for i, dir in enumerate(vers):
        for j, p in enumerate(prog):
            filename = f"{dir}/{p}{base}"
            
            k = 0
            with open(filename, 'r') as f :
                while(line:=f.readline()):
                    data = line.split()
                    l = len(data)
                    if(l > IPC_IDX-1 and data[IPC_IDX-1] == "IPC:"):
                        # print(line)
                        data_ipc[i][j] = float(data[IPC_IDX])
                    elif (l>1 and  data[0] == caches[k] and data[1] == "TOTAL"):
                        # print(line)
                        data_mpki[k][i][j] = int(data[MISS_IDX])/1e4
                        k+=1
                    
                    if(k>=len(caches)): break
    
    for i in range(len(caches)):
        data_mpki[i] = ((data_mpki[i] - data_mpki[i][0])/data_mpki[i][0] )* 100

    data_ipc = data_ipc/data_ipc[0]
    # for i in range(len(vers)):
    # 	for j in range(len(prog)):
    # 		print (vers[i], prog[j], data_ipc[i][j])
    
    # print()
    # print()
  
    # for k in range(len(caches)):
    # 	for i in range(len(vers)):
    # 		for j in range(len(prog)):
    # 			print (vers[i], prog[j], caches[k], data_mpki[k][i][j])
    print(data_ipc)
    
    print(data_mpki)

    for i in range(len(caches)):
       plotBars(data_mpki[i], "MPKI Comparison for " + f"{caches[i]}", "MPKI Degradation (in percent)")

    plotBars(data_ipc, "Instructions Per Cycle (IPC)", "Normalised IPC")
