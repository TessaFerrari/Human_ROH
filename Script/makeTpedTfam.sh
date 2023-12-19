#!/bin/sh
#SBATCH --job-name=fam
#SBATCH --output=/scratch2/tferrari/Project-HumanROH/Log/hg38fam.out
#SBATCH --error=/scratch2/tferrari/Project-HumanROH/Log/hg38fam.err
#SBATCH --time=06:00:00
#SBATCH -p qcb
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2000MB
#SBATCH --mail-type=END,FAIL # notifications for job done & fail
#SBATCH --mail-user=jazlynmo@usc.edu

####UPDATE THE PATHS FOR INPUT AND OUTPUT FILES 
####MAKE SURE TO OUTPUT THESE FILES TO SCRATCH THEY TAKE UP A TON OF SPACE
####CONVERT SCRIPT TO EXECUTABLE chmod +x makeTpedTfam.sh
###SUBMIT THE SCRIPT AS FOLLOWS  sbatch makeTpedTfam.sh

#load modules
module purge
module load gcc/11.3.0 openblas/0.3.21 plink/1.9-beta7 plink2/2.00a3.7LM

#mkdir DupsRemoved
#mkdir DupsRemoved/DupsRemovedSplitPop

SECONDS=0

for j in {1..22}
do
	
	#convert to vcf
	#plink --vcf /home1/jazlynmo/project/jazlynmo_738/DataRepository/Human/1000GenomeNYGC_hg38/CCDG_14151_B01_GRM_WGS_2020-08-05_chr${j}.filtered.shapeit2-duohmm-phased.nodupmarkers.snps.vcf.gz --update-ids recodeIDsFinal_hg38.txt --make-bed --out allPop.chr"$j".snps

	#remove any duplicate snps
	#plink2 --bfile allPop.chr"$j".snps --rm-dup exclude-all  --remove /home1/jazlynmo/project/jazlynmo_738/DataRepository/Human/1000GenomeNYGC_hg38/FileInformation/RmSamplesGarlicStevensPaper.txt --make-bed --out DupsRemoved/allPop.chr"$j".snps.QCSamps

	#split by family
	#for fam in $(awk '{print $1}' DupsRemoved/allPop.chr"$j".snps.QCSamps.fam | sort | uniq) 
	for fam in $(awk '{print $1}' /project/jazlynmo_738/DataRepository/Human/1000GenomeNYGC_hg38/plinkFiles/allPop.chr"$j".snps.QCSamps.fam | sort | uniq)
	do 

		#echo $fam | plink --bfile DupsRemoved/allPop.chr"$j".snps.QCSamps --keep-fam /dev/stdin --recode transpose --out DupsRemoved/DupsRemovedSplitPop/allPop.chr"$j".snps.QCSamps."$fam" 
		echo $fam | plink --bfile /project/jazlynmo_738/DataRepository/Human/1000GenomeNYGC_hg38/plinkFiles/allPop.chr"$j".snps.QCSamps --keep-fam /dev/stdin --recode transpose --out /scratch2/tferrari/Project-HumanROH/Out/TpedTfamFiles/allPop.chr"$j".snps.QCSamps."$fam"

	done

echo "$j"

done

echo $SECONDS
