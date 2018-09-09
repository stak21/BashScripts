#creates a README template
nr() {
    echo "# phTitle
---
## Description
Description
This project in the System engineering & DevOps series is about: phDescription
---
File|Task
---|---
phTable

## Author
Shoji Takashima
" > README.md
    editNR
    cat ./README.md
    askCommit
}
editNR() {
    echo "Type in a title"
    read title
    sed -i "s@\phTitle@$title@" ./README.md
    read -t 1 -n 10000 discard 
    echo "Type in a description"
    unset userDesc
    read desc
    echo "test"
#    userDesc="$userDesc $desc"
userDesc="$(echo "$userDesc" | sed 's/^.*$/&\\/')"
    #echo "If you want to add more press enter: else enter anything else"
   # read ans
  #  while [[ $ans != @("") ]]
   # do       
#	echo "Enter a description"
#	read moreDesc
#	userDesc="$userDesc $moreDesc"
#	echo "If you want to add more press enter: else enter anything else"
#	read ans
 #  done
echo $userDesc
    sed -i "s@phDescription@$userDesc@m" ./README.md
    echo "enter 1 || 2 : onlyTask = 1, task and description = 2\n 00 to cancel else I will ask again"
    read ans
    while [[ $ans != @(1|2|00) ]]
    do
	echo "enter 1 || 2 : onlyTask = 1, task and description = 2\n 00 to cancel else I will ask again"
	read ans
    done


    if (($ans == 00)); then
	rm ./README.md
	echo "I have deleted ./README.md. Have a nice day"
	return 0;
    fi
    echo "How many tasks are there?"
    read number

    if (($ans == 1)); then
	for ((i = 1; i <= number; i++))
	do 
	    echo "Type in task title"
	    read task
	    sed -i "s@phTable@$task | \nphTable@" ./README.md
	done
    elif (($ans == 2)); then
	for ((i = 1; i <= number; i++))
	do
	    echo "Type in task title"
	    read task
	    echo "Type in the description of the task or answer"
	    read answer
	    sed -i "s@phTable@$task | $answer\nphTable@"./README.md
	done
    fi
    sed -i "s@phTable@\n@" ./README.md

}

askCommit() {
    echo "Enter: <enter> : to git commit, 00 to quit, 1 to delete the README"
    read ans
    while [[ $ans != @(""|00|1) ]]
    do
	echo "Enter: <enter> : to git commit, 00 to quit, 1 to delete the README"
	read ans
    done

if (($ans == 00)); then
  return 0
elif (($ans == 1)); then
    rm ./README.md
    echo "I have deleted ./README.md. Have a nice day"
    return 0;
else 
    git add ./README.md
    git commit -m "Added README.md"
    git push origin master
fi
}

tester1() {
    read -d* desc
    echo "$desc" >> data.txt
    cat data.txt
}
tester2() {
line=
while IFS= read -r line
do
echo "$line" >> data.txt
done
cat data.txt
}
