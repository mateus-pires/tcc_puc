Dir=$1
Process=$1processed
for dbfEntry in $(ls $Dir)
do
   if [ "$dbfEntry" != "processed" ]
   then
	./pan.sh /rep:TCC-PUC /dir:dim /trans:d_estabelecimento_saude__informacoes_complementares /param:ARQUIVO="$Dir$dbfEntry"
	mv $Dir$dbfEntry $Process	
   fi
done  
