Dir=$1
for dbfEntry in $(ls $Dir)
do
   if [ "$dbfEntry" != "processed" ]
   then
	./kitchen.sh /rep:TCC-PUC /dir:job /job:job_executa_pasta /param:CAMINHO_ARQUIVO="$Dir$dbfEntry"
   fi
done  

