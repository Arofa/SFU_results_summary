tag=${1}

file_arr=(\
Traffic_2560x1600_30_val \
Kimono_1920x1080_24_val \
ParkScene_1920x1080_24_val \
Cactus_1920x1080_50_val \
BasketballDrive_1920x1080_50_val \
BQTerrace_1920x1080_60_val \
BasketballDrill_832x480_50_val \
BQMall_832x480_60_val \
PartyScene_832x480_50_val \
RaceHorses_832x480_30_val \
BasketballPass_416x240_50_val \
BQSquare_416x240_60_val \
BlowingBubbles_416x240_50_val \
RaceHorses_416x240_30_val \
FourPeople_1280x720_60_val \
Johnny_1280x720_60_val \
KristenAndSara_1280x720_60_val \
)

# echo ${file_arr['BasketballPass_416x240']}
pushd log
echo "scale, idx, file, Bitrate, Y-PSNR, U-PSNR, V-PSNR, YUV-PSNR" >> ../${tag}_bpp_psnr.csv
for scale in 100 75 50 25; do
    idx=0
    for file in ${file_arr[@]}; do
        for log_file in $(ls ${tag}_${scale}/${file}_qp*); do
            echo "$scale, $idx, $file," \
            $(sed -n "$(( $(wc -l < $log_file)-3 )) p" $log_file | \
            awk '{print $3",", $4",", $5",", $6",", $7}') >> ../${tag}_bpp_psnr.csv
        done
        (( idx++ )) 
    done
done

# ((idx++))
# echo "file_path, file_no, file_name, class, qp, resolution, scale, mAP" \
# # >> ${1}_try${idx}_results.csv
# for file in ${try}/results*; do  
#         f=$(basename $file)
#         res=$(echo ${f} | cut -d '_' -f4)
#         fname=$(echo ${f} | cut -d '_' -f3)
#         fdx=${file_arr["${fname}_${res}"]}
#         scale=$(echo ${f} | cut -d '_' -f2)
#         qp=$(echo ${f} | cut -d '_' -f7)
#         if [ "$res" == "2560x1600" ];then
#             class=A
#         elif [ "$res" == "1920x1080" ];then	
#             class=B
#         elif [ "$res" == "832x480" ];then
#             class=C
#         elif [ "$res" == "416x240" ];then
#             class=D
#         elif [ "$res" == "1280x720" ]; then
#             class=E
#         else
#             class=X
#         fi


#         echo \
#             "${file}, \
#             ${fdx}, \
#             ${fname}, \
#             ${class}, \
#             ${qp/"qp"/}, \
#             ${res}, \
#             ${scale}, \
#             $(head -n 1 ${file} | cut -d '=' -f2)" \
#             # >> ${1}_try${idx}_results.csv
# done 

popd
echo "done: generating bpp results."
exit 100