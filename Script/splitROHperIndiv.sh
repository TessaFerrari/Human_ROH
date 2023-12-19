
cd /scratch2/tferrari/Project-HumanROH/Out/garlicOutput

### generate the allROHFiles.txt which is just a list of the files that end with roh.bed
ls -1 *.roh.bed > allROHFiles.txt

#split files per inidividual
while read -r p; do csplit --prefix=$p --suffix-format="%d.out" -z $p /track/ '{*}'; done < allROHFiles.txt

#rename files based on track which is the first line of the file
for i in *.out; do mv "$i" "$(head -1 "$i" | cut -d ":" -f2 | sed -e 's/ Pop//g'| sed -e 's/^[ \t]*//' | awk '{print $0".bed"}')"; done

#mode files into directory and move files with everyone back to main directory
mkdir ROHperIndiv/

mv *.bed ROHperIndiv/

mv ROHperIndiv/*.roh.bed .
