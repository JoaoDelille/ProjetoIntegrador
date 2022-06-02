import json
import random
import sys
print(sys.argv[1])
print()
a_file = open(str(sys.argv[1]), "r")
json_object = json.load(a_file)
random.seed(a=None, version=2)
a_file.close()
#print(data)
for i in range(10):
    json_object['vehicle']['components'][4]['diameter'] += random.randrange(10)/1000*json_object['vehicle']['components'][4]['diameter']*(random.randint(0,1)*2-1)
    json_object['vehicle']['components'][5]['aspect_ratio'] += random.randrange(10)/1000*json_object['vehicle']['components'][5]['aspect_ratio']*(random.randint(0,1)*2-1)
    json_object['vehicle']['components'][5]['mean_chord'] = json_object['vehicle']['components'][5]['aspect_ratio']/7
    json_object['vehicle']['components'][7]['aspect_ratio'] += random.randrange(10)/1000*json_object['vehicle']['components'][7]['aspect_ratio']*(random.randint(0,1)*2-1)
    json_object['vehicle']['components'][7]['mean_chord'] += random.randrange(10)/1000*json_object['vehicle']['components'][7]['mean_chord']*(random.randint(0,1)*2-1)
    json_object['vehicle']['components'][13]['radius'] += random.randrange(10)/1000*json_object['vehicle']['components'][13]['radius']*(random.randint(0,1)*2-1)
    json_object['vehicle']['components'][13]['rotor_solidity'] += random.randrange(10)/1000*json_object['vehicle']['components'][13]['rotor_solidity']*(random.randint(0,1)*2-1)
    #json_object['vehicle']['components'][13]['number'] += round((random.randint(0,1)-0.65))
    #json_object['vehicle']['components'][17]['number'] = json_object['vehicle']['components'][13]['number']
    
    with open('JSONS/data'+str(i)+'.json', 'w', encoding='utf-8') as f:
        json.dump(json_object, f, ensure_ascii=False, indent=4)


    
