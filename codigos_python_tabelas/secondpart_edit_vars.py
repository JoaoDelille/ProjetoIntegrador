import csv
import os

meritList = []

class merit:
    val = 0
    def calc(me,a,b):
        if a <= 1300 and b <= 6000:
            me.val=1/(a)+(10*b);
        else:
            me.val=0
        
MyMerit=merit()

with open('design_points.txt', newline='') as csvfile:
    points = list(csv.reader(csvfile, delimiter=',', quotechar='|'))
    print(points[1][1])
    print()
    i=0;
    for row in points:
       MyMerit.calc(float(points[i][0]),float(points[i][3]))
       print(MyMerit.val)
       i=i+1
       meritList.append(MyMerit.val)

for k in [x for x in range(i) if x != meritList.index(max(meritList))]:
    os.remove('JSONS/data'+str(k)+'.json')

os.system("py eddit_vars.py"+' JSONS/data'+str(meritList.index(max(meritList)))+'.json')

