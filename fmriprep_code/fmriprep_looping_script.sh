#!/bin/bash

#for use on server with slurm sbatch scripts

script_dir=/blue/stevenweisberg/rtQuest/rtQuest/code/hipergator/fmriprep_code
BIDS_dir=/blue/stevenweisberg/rtQuest/rtQuest
output_dir=/blue/stevenweisberg/rtQuest/rtQuest/derivatives/fmriprep
freesurfer_dir=/blue/stevenweisberg/freesurfer_license
singularity_dir=/blue/stevenweisberg/stevenweisberg/hipergator_neuro/fmriprep/fmriprep-20.1.1.simg



# loops through subjects
for SUB in {101..101}
do

#copies processing and preprocessing scripts in to subject folder
 cp $script_dir/fmriprep_slurm.sh $script_dir/fmriprep_slurm_run_${SUB}.sh


#renames variable in fsl melodic, fsl feat, and freesurfer recon-all processing script to subject number
 sed -i -e "s|SUB_sed|${SUB}|g" $script_dir/fmriprep_slurm_run_${SUB}.sh
 sed -i -e "s|BIDS_sed|${BIDS_dir}|g" $script_dir/fmriprep_slurm_run_${SUB}.sh
 sed -i -e "s|OUTPUT_sed|${output_dir}|g" $script_dir/fmriprep_slurm_run_${SUB}.sh
 sed -i -e "s|SINGULARITY_sed|${singularity_dir}|g" $script_dir/fmriprep_slurm_run_${SUB}.sh
 sed -i -e "s|VERSION_sed|${version}|g" $script_dir/fmriprep_slurm_run_${SUB}.sh
 sed -i -e "s|FREESURFER_sed|${freesurfer_dir}|g" $script_dir/fmriprep_slurm_run_${SUB}.sh



#runs subject-level preprocessing scripts via sbatch on the hipergator
   sbatch $script_dir/fmriprep_slurm_run_${SUB}.sh

done

#removing the run script
 rm $script_dir/fmriprep_slurm_run*.sh
                  
