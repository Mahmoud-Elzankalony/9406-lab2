ls -l "$1" > directory-info.last
scan "$1" "malicious_dir" 
sleep $3
while [ 1 ]
do
ls -l "$1" > directory-info.new
diff directory-info.last directory-info.new
	if [ $? -eq 1 ]
	then
	cp directory-info.new directory-info.last 
	scan "$1" "malicious_dir"  
	fi
sleep $3
done
scan()
{
Flagged_extension=("exe" "bat" "vbs" "scr" "ps1")
Flagged_content=("virus" "trojan" "malware" "worm" "ransomware")
for file in $1/*
do
ex=$(echo "$file" | cut -d "." -f2)
	for extension in "${Flagged_extension[@]}"
	do
	if [ $ex = $extension ]
	then
	filename=$(echo "$file" | cut -d "/" -f2)
	cp "$1/$filename" "$2/$filename"
        rm "$file"
	echo "$filename is malicious and it is DELETED"
	break
	fi
	done
done
for file in $1/* 
do
for item in "${Flagged_content[@]}"
do
grep -i -q "$item" "$file" 
if [ $? -eq 0 ]
then
        filename=$(echo "$file" | cut -d "/" -f2)
        cp "$1/$filename" "$2/$filename"
        rm "$file"

        echo "$filename is malicious and it is DELETED"
        break
        fi
        done
done
}
