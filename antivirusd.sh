scan()
{
Flagged_extension=("exe" "bat" "vbs" "scr" "ps1")
Flagged_content=("virus" "trojan" "malware" "worm" "ransomware")
for file in $1/*
do
filename="${file##*/}"
ex="${filename##*.}"
	for extension in "${Flagged_extension[@]}"
	do
	if [ $ex = $extension ]
	then
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
        filename="${file##*/}"
        cp "$1/$filename" "$2/$filename"
        rm "$file"

        echo "$filename is malicious and it is DELETED"
        break
        fi
        done
done
}

scan "$1" "$2"
ls -l "$1" > directory-info.last 
sleep $3
while [ 1 ]
do
ls -l "$1" > directory-info.new
diff directory-info.last directory-info.new
        if [ $? -eq 1 ]
        then
	scan "$1" "$2" 
        cp directory-info.new directory-info.last 
        fi
sleep $3
done
