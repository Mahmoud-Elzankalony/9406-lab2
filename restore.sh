while [ 1 ]
do
    files=()
    for file in "$2"/*
    do
        [ -f "$file" ] || continue
        filename="${file##*/}"
        files+=("$filename")
    done

    count=0
    for file in "$2"/*
    do
        [ -f "$file" ] || continue
        count=$((count + 1))
        filename="${file##*/}"
        echo "$filename $count"
    done

    if [ "$count" -eq 0 ]
    then
        echo "No malicious files to review."
        exit
    fi

    echo "pick one by number"
    read num
    echo "Input 1: Restore this file back into dir (it was a false positive)"
    echo "Input 2: Permanently delete this file from malicious_dir (it was genuinely malicious)"
    echo "Input 3: Leave this file as-is and go back to the list"
    echo "pick one by number"
    read input

    if [ "$input" -ne 3 ]
    then
        break
    fi
done

if [ "$input" -eq 1 ]
then
    cp "$2/${files[$((num - 1))]}" "$1/${files[$((num - 1))]}"
    rm "$2/${files[$((num - 1))]}"
    echo "Restored ${files[$((num - 1))]} to $1."
    echo "${files[$((num - 1))]}" >>  Whitelist.txt
elif [ "$input" -eq 2 ]
then
    rm "$2/${files[$((num - 1))]}"
    echo "${files[$((num - 1))]} permanently deleted."
fi

