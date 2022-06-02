py eddit_vars.py "JSONS/prototipo3_funciona.json"
foreach($i in 1..10){
matlab -nosplash -nodesktop -r "run('ARChanges_runtrhough_underscores.m')";
Start-Sleep -Seconds 35
py secondpart_edit_vars.py
}