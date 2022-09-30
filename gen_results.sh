
echo "<directory list>"
ls results

read -p "Enter a directory : " task
./scripts/gen_task_results.sh ${task}
./scripts/gen_bpp_results.sh ${task}

echo "done generating results."
exit 100

