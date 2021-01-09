Dir=$1
uf=$2
for dbfEntry in $(ls $Dir)
do
   if [ "$dbfEntry" != "processed" ]
   then
	./kitchen.sh /rep:TCC-PUC /dir:job /job:job_executa_arquivos /param:CAMINHO_ARQUIVO="$Dir$dbfEntry" /param:UF=$uf
   fi
done  

