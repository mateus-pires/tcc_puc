Dir=$1
for dbfEntry in $(ls $Dir)
do
   if [ "$dbfEntry" != "processed" ]
   then
	./pan.sh /rep:tcc_puc /dir:dim /trans:d_estabelecimento_saude__informacoes_complementares /param:ARQUIVO="$Dir$dbfEntry"
   		mv "$dbfEntry" processed
   fi
done  
