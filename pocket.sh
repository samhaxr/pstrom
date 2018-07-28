br(){
	echo -e "\033[0;31m----------------------------------------------------------------------\033[0m"
}
r_content(){
rm /tmp/_tmp_
rm /tmp/_tmp_lnk
rm /tmp/_tmp_hd
rm /tmp/_tempfile_
rm /tmp/cout
}
r_content > /dev/null 2>&1
clear
figlet PocketStorm
echo -e "\033[0;32mby @Sulemanmalik_3                        			v1.0\033[0m"
br
echo "Search String: "
read key
echo ''
br
curl -L --silent https://packetstormsecurity.com/search/files/?q=$key > /tmp/_tmp_
elap=0
for poc in {1..25}
do
elap=$(expr $elap + 1)
echo " $elap     -  " >> /tmp/cout
#-----------
cat /tmp/_tmp_ | grep -m$poc "class=\"act-links\"" | grep -Eo 'href="[^\"]+"' | cut -c"7-"  | sed 's/\"//' | grep "/download/" | tail -n1 | head -n1 >> /tmp/_tmp_lnk
cat /tmp/_tmp_ | grep -m$poc -o '<dt>.*</dt>' | cut -d'>' -f3 | cut -d'<' -f1 | tail -n1 >> /tmp/_tmp_hd
echo -ne "\033[0;32m[+] Gathering exploits: \033[0m$elap/25\r"
done
echo ''
echo ''
echo -e "\033[0;32m[+] Process done! \033[0m"
echo ''
runp=$(awk 'NR==FNR{a[++y]=$0;next}{b[++x]=$0}
END{z=x>y?x:y;while(++i<=z){print a[i],b[i]}}' /tmp/cout /tmp/_tmp_hd > /tmp/_tempfile_)
sleep 1
while read payload
do
	echo $payload
done < /tmp/_tempfile_
while true
do
br
echo "Exploit No:"
read exploit
echo ''
explo=$(awk NR==$exploit /tmp/_tmp_lnk)
sleep 1
down=$(wget https://packetstormsecurity.com$explo -P $PWD/Pocket-Exploits > /dev/null 2>&1)
echo -e "\033[0;32mDownloaded at $PWD/Pocket-Exploits\033[0m"
echo ''
echo "Want to download more exploits (y/n):"
read chs
if [[ $chs == "y" ]]
	then
	echo ''
elif [[  $chs == "n" ]]
	then
	op=$(open $PWD/Pocket-Exploits)
	br
	echo "Press return key to exit"
	r_content > /dev/null 2>&1
	exit 1
else
	echo -e "\033[0;31mWrong choice!!!\033[0m"
	r_content > /dev/null 2>&1
	exit 1
fi
done
op=$(open $PWD/Pocket-Exploits)
br
echo "Press return key to exit"
read ext
r_content > /dev/null 2>&1

