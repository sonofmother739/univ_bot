wallets="wallets.txt"
i=0
shag=5
index=0
while read line; do
    array[$index]="$line"
    index=$(($index+1))
done < $wallets

element_count=${#array[*]}
a=0
while [ "$a" -lt "$element_count" ]
do 
(
 echo "$a: ${array[$a]}"
 curl -s -X POST -d '{"address": "'"${array[$a]}"'", "coins": ["110000000unibi","10000000unusd","10000000uusdt"]}' 'https://faucet.itn-1.nibiru.fi/'
) &
 a=$(($a+1))
 i=$(($i+1))
 if [ "$i" = "$shag" ] 
    then
    wait
  while true; do
     read -r -p "Дальше? (Any key/q): " answer
     case $answer in
  [Qq]* ) exit;;
  * ) break;;
    esac
   done
   i=0
 fi
done
