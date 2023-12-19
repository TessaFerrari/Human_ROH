
cd /scratch2/tferrari/Project-HumanROH/Out/garlicOutput/ROHperIndiv

### generate the allIndivFiles.txt which is just a list of the files that end with .bed
ls -1 *.bed > allIndivFiles.txt

# Create output file with header
echo -e "Indiv\tFam\tA\tB\tC" > ROHlengthPerIndiv.txt

while read -r p; do 

	# Output individual ID
	echo -e "${p%.*}\t" >> ROHlengthPerIndiv.txt	
	truncate -s-1 ROHlengthPerIndiv.txt

	# Output fam
	sed -n "s/.*Pop:\([^']*\) ROH.*/\1/p" $p >> ROHlengthPerIndiv.txt
	truncate -s-1 ROHlengthPerIndiv.txt
	echo -e "\t" >> ROHlengthPerIndiv.txt
	truncate -s-1 ROHlengthPerIndiv.txt

	# Output sum of A ROHs
	awk -F"\t" '$4 == "A" {sum += $5} END{print sum}' $p >> ROHlengthPerIndiv.txt
	truncate -s-1 ROHlengthPerIndiv.txt
	echo -e "\t" >> ROHlengthPerIndiv.txt
	truncate -s-1 ROHlengthPerIndiv.txt

	# Output sum of B ROHs
	awk -F"\t" '$4 == "B" {sum += $5} END{print sum}' $p >> ROHlengthPerIndiv.txt
	truncate -s-1 ROHlengthPerIndiv.txt
	echo -e "\t" >> ROHlengthPerIndiv.txt
        truncate -s-1 ROHlengthPerIndiv.txt

	# Output sum of C ROHs
	awk -F"\t" '$4 == "C" {sum += $5} END{print sum}' $p >> ROHlengthPerIndiv.txt

done < allIndivFiles.txt

