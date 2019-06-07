#!/bin/bash
source ~/tensorflow-gpu/bin/activate
cd /data/scratch/gliang/temp

max_epochs=1
max_steps=5000
gpu=0
batch_size=32

gen_input_dir=/data/scratch/gliang/data/labeled_image/train/true
dis_input_dir=/data/scratch/gliang/data/labeled_image/train/false
#gen_input_dir=/data/scratch/gliang/data/labeled_image/train/combined
#dis_input_dir=/data/scratch/gliang/data/labeled_image/train/combined
val_input_dir=/data/scratch/gliang/data/batch_testing_imagesets/135_188_208_293/mixed

train_data=''
#train_version='ganai_deliver_witout_diff_data'
train_version='ganai_debug_09_11_2018'

output_dir=/data/scratch/gliang/temp/$train_data/$train_version
log_output_dir=$output_dir"/train-log"

if true
then
#python ganai_deliver_v03_test_summary.py \
python ganai_deliver_modifying_09_11_2018.py \
--mode train \
--gen_input_dir $gen_input_dir \
--dis_input_dir $dis_input_dir \
--output_dir $log_output_dir \
--checkpoint $log_output_dir \
--max_steps $max_steps \
--gpu $gpu \
--batch_size $batch_size \
--save_freq 500 \
--progress_freq 50 \
--summary_freq 50
#--val_input_dir $val_input_dir \

fi

if false
then
# test
# declare -a arr=("bl57_05mm_d3" "bl57_1mm_d3" "bl57_15mm_d3" "bl57_3mm_d3" "bl64_05mm_d3" "bl64_15mm_d3" "bl64_3mm_d3")
declare -a arr=("bl57_05mm_d3")

declare -a model_list=("500" "1000" "1500" "2000" "2500" "3000" "3500" "4000" "4500" \
                        "5000" "5500" "6000" "6500" "7000" "7500" "8000" "8500" "9000" \
                        "9500" "10000" "10500" "11000" "11500" "12000" "12500" "13000" \
                        "13500" "14000" "14500" "15000" "15500" "16000" "16500" "17500")
test_dataset="135_188_208_293/"

## now loop through the above array
for i in "${arr[@]}"
do
  for j in "${model_list[@]}"
  do
    parameter=$i
    model_name=$j
    output_dir=/data/scratch/gliang/temp//$train_data/$train_version
    checkpoint=$output_dir"/train-log"
    #input_dir='/data/scratch/gliang/data/batch_testing_imagesets/'$test_dataset$parameter
    batch_size=4
    progress_freq=10

    echo 'model_checkpoint_path: "./model-'$model_name'"'>$checkpoint'/checkpoint'

    python ganai_deliver_modifying_09_11_2018.py \
    --mode test \
    --output_dir $output_dir \
    --gen_input_dir $val_input_dir \
    --dis_input_dir $dis_input_dir \
    --checkpoint $checkpoint \
    --gpu $gpu

    mkdir $output_dir'/'$model_name
    mv $output_dir'/images' $output_dir'/'$model_name'/'$parameter

  done
done

fi
