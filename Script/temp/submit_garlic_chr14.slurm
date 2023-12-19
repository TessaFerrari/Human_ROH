#!/bin/sh
#SBATCH --job-name=garlic_chr14
#SBATCH --output=/scratch2/tferrari/Project-HumanROH/Log/hg38garlic_chr14.out
#SBATCH --error=/scratch2/tferrari/Project-HumanROH/Log/hg38garlic_chr14.err
#SBATCH --time=06:00:00
#SBATCH -p qcb
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000MB
#SBATCH --mail-type=END,FAIL # notifications for job done & fail
#SBATCH --mail-user=tferrari@usc.edu

####UPDATE THE PATHS FOR INPUT AND OUTPUT FILES
####MAKE SURE TO OUTPUT THESE FILES TO SCRATCH THEY TAKE UP A TON OF SPACE
####CONVERT SCRIPT TO EXECUTABLE chmod +x runGarlic.sh
###SUBMIT THE SCRIPT AS FOLLOWS  sbatch runGarlic.sh

#load modules
module purge
module load gcc/11.3.0 openblas/0.3.21 plink/1.9-beta7 plink2/2.00a3.7LM

#run garlic on each family
for fam in ACB
ASW
BEB
CDX
CEU
CHB
CHS
CLM
ESN
FIN
GBR
GIH
GWD
IBS
ITU
JPT
KHV
LWK
MSL
MXL
PEL
PJL
PUR
STU
TSI
YRI
do

	# runs garlic if the bed file doesn't exist yet
	if [ ! -f ../garlicOutput/allPop.chr14.snps.QCSamps."".roh.bed ]; then
		/project/jazlynmo_738/software/garlic/bin/linux/garlic --tped allPop.chr14.snps.QCSamps."".tped --tfam allPop.chr14.snps.QCSamps."".tfam --build hg38 --error 0.001 --winsize 100 --auto-winsize --auto-overlap-frac --out ../garlicOutput/allPop.chr14.snps.QCSamps.""
	fi

done

