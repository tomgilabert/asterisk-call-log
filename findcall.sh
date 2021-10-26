#!/bin/bash

if [ -z $1 ] ; then
 echo "Falta parametre a buscar!" && exit 1;
fi

ext="${1}"
id=$(/usr/bin/grep $ext /var/log/asterisk/full | tail -1 | awk -F '[][]' -v n=2 '{print $(2*n)}')

sql="SELECT cdr.uniqueid AS ID,SUM(duration) AS TempsTotal,SUM(billsec) AS TempsParlat,src AS origen,dst AS desti,clid AS CallerIDNom,cnum AS CallerIDNum,calldate AS data FROM cdr WHERE (src='$ext' or dst='$ext' or cnum='$ext') AND calldate >= DATE_SUB(NOW(), INTERVAL 1 DAY) AND duration >= '2' GROUP BY cdr.uniqueid ORDER BY calldate DESC"

i=0
cap="ID"
printf "%4s %11s %11s %9s %9s %40s %12s %25s" "ID" "TempsTotal" "TempsParlat" "origen" "desti" "CallerIDNom" "CallerIDNum" "data"
echo "."
shopt -s lastpipe
IFS=$'\t'
mysql --default-character-set=utf8 -N -e "$sql" asteriskcdrdb | while read ID TempsTotal TempsParlat origen desti CallerIDNom CallerIDNum data
do
    aid[$i]=$ID
    att[$i]=$TempsTotal
    atp[$i]=$TempsParlat
    aori[$i]=$origen
    ades[$i]=$desti
    anom[$i]=$(echo $CallerIDNom | tr -d ' ')
    anum[$i]=$CallerIDNum
    adata[$i]=$data
    printf "%4d %11s %11s %9s %9s %40s %12s %25s" $i ${att[$i]} ${atp[$i]} ${aori[$i]} ${ades[$i]} ${anom[$i]} ${anum[$i]} "${adata[$i]}"
    echo "."
    ((i++))
done
#echo "test: ${anom[3]}"
#echo "i: $i"

echo "Selecciona ID de la trucada a revisar als logs:\n"
read iden
if ! [[ "$iden" =~ ^[0-9]+$ ]]
then
    echo "Error! Identificador incorrecte!"
    exit
else
    if [ "$iden" -ge 0 ] && [ "$iden" -lt "$i" ]
    then
        idlog=$(cat /var/log/asterisk/full | grep ${aid[iden]} | awk -F'[][]' '{print $6}')
        if [ ! -z $idlog ]
        then
            cat /var/log/asterisk/full | grep "\[$idlog\]" | bat -l log
        else
            echo "Trucada no trobada! selecciona un altra..."
            exit
        fi
    else
        echo "Error, identificador incorrecte!. Sortint..."
        exit
    fi
fi
