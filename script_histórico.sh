#!/bin/bash
# Bashscript
# Comando para converter pdf para text: pdftotext -f 2 ./NOMEDODOCUMENTO.pdf
# (https://www.youtube.com/watch?v=ChbDOb6390A)
#
# Todas as siglas de disciplinas se encontram na linha 35 (incluso) em diante.
# As linhas de matérias - inicia-se com 3 letras maiúsculas seguidas; não vale se começar com HIS, ATP, FRE ou NOT.
# Comando para colocar indicador de fim do arquivo: printf "\nEOF" >> ./NOMEDODOCOUMENTO.txt
#
# ${#var} retorna o comprimento de var
# ${var:pos:N} retorna N caracteres de pos para frente
#
# POSSIVEIS STATUS: MA, A, P, T, I, IP, IR, IT, IL RA, RN, RF, AE

eh_status () {
	local frase=$1
	local status=1
	
	if [ ${#frase} -eq 1 ]; then
		frase="$frase "
	fi
	
	if [ "${frase:0:2}" = "MA" ] || [ "${frase:0:2}" = " A" ] || [ "${frase:0:2}" = "P " ] || [ "${frase:0:2}" = "T " ] || [ "${frase:0:2}" = "I " ] || [ "${frase:0:2}" = "IP" ] || [ "${frase:0:2}" = "IR" ] || [ "${frase:0:2}" = "IT" ] || [ "${frase:0:2}" = "IL" ] || [ "${frase:0:2}" = "RA" ] || [ "${frase:0:2}" = "RN" ] || [ "${frase:0:2}" = "RF" ] || [ "${frase:0:2}" = "AE" ]; then
	 	status=0
	fi
	
	echo $status
}

declare -a lista_disciplinas
declare -a lista_status

printf "Digite o nome do arquivo de histórico escolar (sem .pdf): "
read nome_do_arquivo
nome_do_arquivo="./"$nome_do_arquivo

pdftotext -f 2 $nome_do_arquivo".pdf"		# Cria-se o arquivo em .txt, a partir da segunda página.
#printf "\nFIM" >> $nome_do_arquivo".txt"	# Coloca-se a flag "FIM" ao fim. Necessário?

# Índices para as listas "lista_disciplinas" e "lista_status"
i=0
j=0

# Laço para ler linhas
while read -r linha; do

	# Pega nomes das disciplinas
	if [ ${#linha} -eq 7 ]; then 		# Nota: precisa conferir se as primeiras letras são siglas?
		lista_disciplinas["${i}"]="$linha"
		i=$i+1;
	fi
	
	# Pega o status das disciplinas
	status=$(eh_status "${linha:${#linha}-2:2}") 
	if [ $status -eq 0 ]; then
		
		if [ ${#linha} -eq 1 ]; then
			sigla_status="$linha"
		else
			sigla_status="${linha:${#linha}-2:2}"
			if [ "${sigla_status:0:1}" = " " ]; then
				sigla_status="${sigla_status:1:1}"
			fi
		fi
		
		lista_status["${j}"]="$sigla_status"
		j=$j+1;
	fi
	
done < $nome_do_arquivo".txt"
# No final do laço, remove-se o .txt, pois não será mais necessário.
rm -f $ $nome_do_arquivo".txt"		






echo "${lista_disciplinas[*]}"
echo "${lista_status[*]}"


