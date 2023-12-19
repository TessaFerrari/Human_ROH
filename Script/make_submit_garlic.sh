# Script to make SLIM job scripts and submission scripts for wolf simulations
# To test without running the simulations, comment out the sbatch line

# Set working directory
cd /scratch2/tferrari/Project-HumanROH/Script

# Create output directory
mkdir ../Out/garlicOutput

for j in {16..22}
do

# Write submission scripts
cat > ./temp/submit_garlic_chr${j}.slurm << EOM
#!/bin/sh
#SBATCH --job-name=garlic_chr${j}
#SBATCH --output=/scratch2/tferrari/Project-HumanROH/Log/hg38garlic_chr${j}.out
#SBATCH --error=/scratch2/tferrari/Project-HumanROH/Log/hg38garlic_chr${j}.err
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

cd /scratch2/tferrari/Project-HumanROH/Out/TpedTfamFiles

#run garlic on each family
for fam in \$(awk '{print \$1}' /project/jazlynmo_738/DataRepository/Human/1000GenomeNYGC_hg38/plinkFiles/allPop.chr${j}.snps.QCSamps.fam | sort | uniq)
do

	# runs garlic if the bed file doesn't exist yet
	if [ ! -f ../garlicOutput/allPop.chr${j}.snps.QCSamps."\$fam".roh.bed ]; then
		/project/jazlynmo_738/software/garlic/bin/linux/garlic --tped allPop.chr${j}.snps.QCSamps."\$fam".tped --tfam allPop.chr${j}.snps.QCSamps."\$fam".tfam --build hg38 --error 0.001 --winsize 100 --auto-winsize --auto-overlap-frac --out ../garlicOutput/allPop.chr${j}.snps.QCSamps."\$fam"
	fi

done

EOM

# Submit burn in
sbatch ./temp/submit_garlic_chr${j}.slurm

done
