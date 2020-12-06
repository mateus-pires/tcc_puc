#!/bin/bash

#script que converte dbfs em csvs

#sudo apt-get install libghc-csv-dev (para instalar o dbf_dump)

#sh convertercsvs.sh (caminho arquivos) (nome arquivos)

caminho=$1  
nome=$2

cd /home/a4pm/Documentos/blast-dbf/

make

  for s3Entry in $(ls $caminho*.dbc)
   do 
          echo "$s3Entry"
          ./blast-dbf $s3Entry $s3Entry.dbf
          
   done

cd $caminho

rename 's/.dbc.dbf/.dbf/' *.dbf

zip -r $nome.zip *.dbf

rm -r *.dbc

rm -r *.dbf
