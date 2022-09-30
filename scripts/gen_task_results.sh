
task="$1"
declare -A  file_arr
file_arr=(\
[Traffic_2560x1600]=1 [Kimono_1920x1080]=2 [ParkScene_1920x1080]=3 \
[Cactus_1920x1080]=4 [BasketballDrive_1920x1080]=5 [BQTerrace_1920x1080]=6 \
[BasketballDrill_832x480]=7 [BQMall_832x480]=8 [PartyScene_832x480]=9 \
[RaceHorses_832x480]=10 [BasketballPass_416x240]=11 [BQSquare_416x240]=12 \
[BlowingBubbles_416x240]=13 [RaceHorses_416x240]=14 [FourPeople_1280x720]=15 \
[Johnny_1280x720]=16 [KristenAndSara_1280x720]=17\
)

pushd results
echo "file_path, file_no, file_name, class, qp, resolution, scale, mAP" > ../results_${task}.csv
for file in "${task}"/results_*; do  
		f=$(basename $file)
		res=$(echo ${f} | cut -d '_' -f4)
		fname=$(echo ${f} | cut -d '_' -f3)
		fdx=${file_arr["${fname}_${res}"]}
		scale=$(echo ${f} | cut -d '_' -f2)
		qp=$(echo ${f} | cut -d '_' -f7)
		if [ "$res" == "2560x1600" ];then
			class=A
		elif [ "$res" == "1920x1080" ];then	
			class=B
		elif [ "$res" == "832x480" ];then
			class=C
		elif [ "$res" == "416x240" ];then
			class=D
		elif [ "$res" == "1280x720" ]; then
			class=E
		else
			class=X
		fi


		echo "${file}, ${fdx}, ${fname}, ${class}, ${qp/"qp"/}, ${res}, ${scale}, $(head -n 1 ${file} | cut -d '=' -f2)" \
		>> ../results_${task}.csv
done 
popd

echo "done: generating task results."
exit 100