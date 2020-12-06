#!/bin/bash

#script que converte dbfs em csvs

#sudo apt-get install libghc-csv-dev (para instalar o dbf_dump)

#sh convertercsvs.sh (caminho arquivos) (nome arquivos)

#apt-get install libdbd-xbase-perl (instalar dbf_dump)

caminho=$1  
nome=$2

cd $caminho

  for s3Entry in $(ls *.dbf)
   do 
          echo "$s3Entry"
          dbf_dump $s3Entry > $s3Entry.csv
   done

rename 's/.dbf.csv/.csv/' *

mkdir $nome

mv *.csv $nome

zip -r $nome.zip $nome/

rm -r $nome  
