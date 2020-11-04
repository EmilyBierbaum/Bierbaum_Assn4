#! /bin/bash
########use bash to analyze this script

grep Person possible_voters.txt | column -t > header.txt
########print the lines that include Person from the file possible_voters.txt (will use as header)
####use a pipe to format the output tabular and redirect to a new file


echo Eligible? > eligibility.txt
########display the word 'eligible' and redirect to a new file

paste header.txt eligibility.txt > threeheaders.txt
########paste command combines columns from different files
####this makes 'person, age (years), and eligibility?' the three headers in a new file

grep -v Person possible_voters.txt > voterdata.txt
########reverse grep 'Person' to remove the header line from the original possible_voters.txt and redirect to a new file
####keeps the person_data and age data

cut -f2 voterdata.txt > ages.txt
########cut out field two (age data) and redirect to a new file

while read line

do if [ "$line" -lt 18 ]

then echo $line "no" >> yesno.txt

else echo $line "yes" >> yesno.txt
fi
done < ages.txt
########use a while loop and if/then loop
######read through the lines and if the value of the variable is less than 18 then display 'no' next to that value into a new file
#####if 18 or more then display 'yes' next to that value in the same file as above
####'fi' closes the if/then loop and 'done' closes the while loop
##'<' feeds the file to the while loop (ages.txt)

cut -f1 voterdata.txt > data.txt
########cut out column one (person_data) and redirect to a new file

paste data.txt yesno.txt | column -t > votercounts.txt
########combine columns from different files; person data + age and eligibility data
####make the output tabular in format

cat threeheaders.txt votercounts.txt | column -t > Final.txt
########print all the lines within threeheaders.txt and votercounts.txt and combine into a new file
####make the output tabular in format

column -t Final.txt | head -10
########make the output tabular and only display the first 10 lines from the file Final.txt to the standard output 

echo -e "There are $(sort -k3 Final.txt | grep yes | wc -l) eligible voters!"
########display the message that sorts by column 3 and uses a pipe to further examine the output
####grep command to print to the screen lines that include yes and wordcount by line
##the message will display the number of persons that are over 17, thus eligible to vote to the standard output

rm header.txt eligibility.txt threeheaders.txt voterdata.txt ages.txt yesno.txt data.txt votercounts.txt 
########remove all of the intermediate files
