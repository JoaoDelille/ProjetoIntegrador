import json
import itertools

a_file = open("JSONS/prototipo1_semana4.json","r")
json_object = json.load(a_file)
a_file.close()

andprint = itertools.cycle([' & ', ' & ',' & ','\\\\ \\hline \\\\ \n'])
texfile=open("tabela_tex_doJson.tex","w")

print ( "\FloatBarrier \n \\begin{table}[h] \n \\begin{adjustbox}{width=1\\textwidth} \n \\begin{tabular}{|c|c|c|c|}\n \\hline \n", file=texfile )
string=''
for component in json_object['vehicle']['components']:
    for cenas in component:
        string+=str(cenas) + ": " + str(component[cenas]) + " ; \\\\ "
        string=string.replace("'"," ")
        string=string.replace(","," \\\\ ")
        string=string.replace("{"," ")
        string=string.replace("}"," ")
    string=string.replace("_","\_")   
    string="\makecell{" + string + "}"
    print( string, file=texfile, end = '' ) 
    #print('\\\\ \\hline \\\\ \n',file=texfile, end = '' )
    endstring = next(andprint)
    print("%s" % endstring,file=texfile, end = '' )
    string=''
i=0
while(endstring != '\\\\ \\hline \\\\ \n'):
    endstring = next(andprint)
    print("%s" % endstring,file=texfile, end = '' )
    print(i)
    i+=1

print ( "\end{tabular} \n \end{adjustbox} \n \end{table} \n \FloatBarrier ", file=texfile )
texfile.close()