#!/bin/bash
# PROGRAMAÇÃO ORIENTADA A GAMBIARRA
#
# Este programa procura verificar se, dado um histórico escolar USP, o aluno
# completou alguma trilha do curso BCC-IME, dentre as seguintes:
#
# --> Sistemas de Software
# --> Inteligência Artificial
# --> Ciência de Dados
# --> Teoria da Computação

eh_status () {
	# Dado uma string de dois ou menos caracteres, decide se são
	# um dos "status" da legenda do arquivo.

	local frase=$1
	local status=1
	
	if [ ${#frase} -eq 1 ]; then
		frase="$frase "
	fi
	
	if [ "${frase:0:2}" = "MA" ] || [ "${frase:0:2}" = " A" ] || [ "${frase:0:2}" = "P " ] || [ "${frase:0:2}" = "T " ] || [ "${frase:0:2}" = "I " ] || [ "${frase:0:2}" = "IP" ] || [ "${frase:0:2}" = "IR" ] || [ "${frase:0:2}" = "IT" ] || [ "${frase:0:2}" = "IL" ] || [ "${frase:0:2}" = "RA" ] || [ "${frase:0:2}" = "RN" ] || [ "${frase:0:2}" = "RF" ] || [ "${frase:0:2}" = "AE" ] || [ "${frase:0:2}" = "DI" ] || [ "${frase:0:2}" = "DS" ]; then
	 	status=0
	fi
	
	echo $status
	}

declare -a lista_disciplinas
declare -a lista_status

printf "Digite o nome do arquivo de histórico escolar (sem .pdf): "
read nome_do_arquivo
nome_do_arquivo="./"$nome_do_arquivo

pdftotext -f 2 $nome_do_arquivo".pdf"				# Cria-se o arquivo em .txt, a partir da segunda página.

# Índices para as listas "lista_disciplinas" e "lista_status"
i=0
j=0

# Laço para ler linhas
while read -r linha; do

	# Pega nomes das disciplinas
	if [ ${#linha} -eq 7 ] && [ "[" \> "${linha:0:1}" ] && [ "@" \< "${linha:0:1}" ]; then 						# Nota: precisa conferir se as primeiras letras são siglas?
		lista_disciplinas["${i}"]="$linha"
		i=$i+1;
	fi
	
	# Pega o status das disciplinas
	if [ ${#linha} -gt 1 ]; then
		status=$(eh_status "${linha:${#linha}-2:2}") 
	else
		status=$(eh_status "$linha") 
	fi

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
rm -f $ $nome_do_arquivo".txt"						# No final do laço, remove-se o .txt, pois não será mais necessário.

quantidade_disciplinas="$((${#lista_disciplinas[@]}-1))"

# SISTEMAS DE SOFTWARE: Desenvolvimento de software, sistemas paralelos e banco de dados
sistemas=("0" "0" "0")		# Final: (2, 2, 1) + 2. SOMA: 7

# INTELIGÊNCIA ARTIFICAL: IA, introdução à IA, sistemas e teoria
ia=("0" "0" "0" "0") 		# Final: (1, 2, 2, 1). SOMA: 6

# CIÊNCIAS DE DADOS: Núcleos 1, 2, 3 e 4
dados=("0" "0" "0" "0") 	# Final (4, 1, 1, 1). SOMA: 7

# TEORIA DA COMPUTAÇÃO: Algoritmos, otimização e matemática discreta
teoriaOBR=("0" "0" "0") 	# Final (obrigatório): (2, 2, 3)
teoriaOPT=("0" "0" "0") 	# SOMA: 7

i=0
while [ $i -le $quantidade_disciplinas ]; do
	
	nome_disciplina="${lista_disciplinas[${i}]}"
	status_disciplina="${lista_status[${i}]}"

	if [ "$status_disciplina" = "A" ] || [ "$status_disciplina" = "AE" ]; then	
	# Seria DI (dispensado) válido também?

		codigo_disciplina="${nome_disciplina:3:4}"
		
		############ MAE - DEPARTAMENTO DE ESTATÍSTICA
		if [ "${nome_disciplina:0:3}" = "MAE" ]; then
			
			# MAE0221 - Probabilidade I
			if [ "$codigo_disciplina" = "0221" ]; then
				ia[3]="$((${ia[3]}+1))"			
				dados[0]="$((${dados[0]}+1))"	
				teoriaOPT[2]="$((${teoriaOPT[2]}+1))"	

			# MAE0515 - Introdução à Teoria dos Jogos
			elif [ "$codigo_disciplina" = "0515" ]; then
				ia[3]="$((${ia[3]}+1))"	

			# MAE0312 - Introdução aos Processos Estocásticos
			elif [ "$codigo_disciplina" = "0312" ]; then
				dados[1]="$((${dados[1]}+1))"	

			# MAE0228 - Noções de Probabilidade e Processos Estocásticos
			elif [ "$codigo_disciplina" = "0228" ]; then
				dados[1]="$((${dados[1]}+1))"	
				teoriaOPT[2]="$((${teoriaOPT[2]}+1))"	

			# MAE0580 - Introdução à aprendizagem estatística
			elif [ "$codigo_disciplina" = "0580" ]; then
				dados[1]="$((${dados[1]}+1))"	

			# MAE224 - Probabilidade II
			elif [ "$codigo_disciplina" = "0224" ]; then
				teoriaOPT[2]="$((${teoriaOPT[2]}+1))"	

			# MAE0326 - Aplicações de Processos Estocásticos
			elif [ "$codigo_disciplina" = "0326" ]; then
				teoriaOPT[2]="$((${teoriaOPT[2]}+1))"
			fi

		############ MAT - DEPARTAMENTO DE MATEMÁTICA
		elif [ "${nome_disciplina:0:3}" = "MAT" ]; then
			
			# MAT0349 - Introdução à Lógica
			if [ "$codigo_disciplina" = "0349" ]; then
				ia[3]="$((${ia[3]}+1))"	

			# MAT0206 - Análise Real	
			elif [ "$codigo_disciplina" = "0206" ]; then
				teoriaOBR[2]="$((${teoriaOBR[2]]}+1))"	

			# MAT0264 - Anéis e Corpos
			elif [ "$codigo_disciplina" = "0264" ]; then
				teoriaOBR[2]="$((${teoriaOBR[2]]}+1))"	

			# MAT0225 - Funções Analíticas
			elif [ "$codigo_disciplina" = "0225" ]; then
				teoriaOPT[2]="$((${teoriaOPT[2]]}+1))"	

			# MAT0234 - Medida e Integração
			elif [ "$codigo_disciplina" = "0234" ]; then
				teoriaOPT[2]="$((${teoriaOPT[2]]}+1))"	

			# MAT0265 - Grupos
			elif [ "$codigo_disciplina" = "0265" ]; then
				teoriaOPT[2]="$((${teoriaOPT[2]]}+1))"	

			# MAT0311 - Cálculo Diferencial e Integral V
			elif [ "$codigo_disciplina" = "0311" ]; then
				teoriaOPT[2]="$((${teoriaOPT[2]]}+1))"	

			fi
		
		############ MAC - DEPARTAMENTO DE COMPUTAÇÃO
		elif [ "${nome_disciplina:0:3}" = "MAC" ]; then
			
			# MAC0218 - Técnicas de Programação II
			if [ "$codigo_disciplina" = "0218" ]; then
				sistemas[0]="$((${sistemas[0]}+1))"
				ia[2]="$((${ia[2]}+1))"
			
			# MAC0332 - Engenharia de Software
			elif [ "$codigo_disciplina" = "0332" ]; then
				sistemas[0]="$((${sistemas[0]}+1))"
				ia[2]="$((${ia[2]}+1))"

			# MAC0346 - Programação para Jogos Digitais
			elif [ "$codigo_disciplina" = "0346" ]; then
				sistemas[0]="$((${sistemas[0]}+1))"

			# MAC0413 - Tópicos Avançados de Programação Orientada a Objetos
			elif [ "$codigo_disciplina" = "0413" ]; then
				sistemas[0]="$((${sistemas[0]}+1))"
				ia[2]="$((${ia[2]}+1))"

			# MAC0467 - Empreendedorismo Digital
			elif [ "$codigo_disciplina" = "0467" ]; then
				sistemas[0]="$((${sistemas[0]}+1))"

			# MAC0470 - Desenvolvimento de Software Livre
			elif [ "$codigo_disciplina" = "0470" ]; then
				sistemas[0]="$((${sistemas[0]}+1))"

			# MAC0472 - Laboratório de Métodos Ágeis
			elif [ "$codigo_disciplina" = "0472" ]; then
				sistemas[0]="$((${sistemas[0]}+1))"
				ia[2]="$((${ia[2]}+1))"

			# MAC0475 - Laboratório de Sistemas Computacionais Complexos
			elif [ "$codigo_disciplina" = "0470" ]; then
				sistemas[0]="$((${sistemas[0]}+1))"

			# MAC0219 - Programação Concorrente e Paralela
			elif [ "$codigo_disciplina" = "0219" ]; then
				sistemas[1]="$((${sistemas[1]}+1))"
				dados[3]="$((${dados[3]}+1))"

			# MAC0344 - Arquitetura de Computadores
			elif [ "$codigo_disciplina" = "0344" ]; then
				sistemas[1]="$((${sistemas[1]}+1))"

			# MAC0352 - Redes de Computadores e Sistemas Distribuídos
			elif [ "$codigo_disciplina" = "0352" ]; then
				sistemas[1]="$((${sistemas[1]}+1))"

			# MAC0463 - Computação Móvel
			elif [ "$codigo_disciplina" = "0463" ]; then
				sistemas[1]="$((${sistemas[1]}+1))"

			# MAC0426 - Sistemas de Bancos de Dados
			elif [ "$codigo_disciplina" = "0426" ]; then
				sistemas[2]="$((${sistemas[2]}+1))"
				dados[0]="$((${dados[0]}+1))"

			# MAC0439 - Laboratório de Bancos de Dados
			elif [ "$codigo_disciplina" = "0439" ]; then
				sistemas[2]="$((${sistemas[2]}+1))"

			# MAC0459 - Ciência e Engenharia de Dados
			elif [ "$codigo_disciplina" = "0459" ]; then
				sistemas[2]="$((${sistemas[2]}+1))"
				ia[1]="$((${ia[1]}+1))"

			# MAC0425 - Inteligência Artificial
			elif [ "$codigo_disciplina" = "0425" ]; then
				ia[0]="$((${ia[0]}+1))"

			# MAC0318 - Introdução à Programação de Robôs Móveis
			elif [ "$codigo_disciplina" = "0318" ]; then
				ia[1]="$((${ia[1]}+1))"

			# MAC0444 - Sistemas Baseados em Conhecimento
			elif [ "$codigo_disciplina" = "0444" ]; then
				ia[1]="$((${ia[1]}+1))"

			# MAC0460 - Introdução ao aprendizado de máquina
			elif [ "$codigo_disciplina" = "0460" ]; then
				ia[1]="$((${ia[1]}+1))"
				dados[0]="$((${dados[0]}+1))"

			# MAC0414 - Autômatos, Computabilidade e Complexidade
			elif [ "$codigo_disciplina" = "0414" ]; then
				ia[3]="$((${ia[3]}+1))"
				teoriaOBR[0]="$((${teoriaOBR[0]}+1))"
				teoriaOPT[2]="$((${teoriaOPT[2]}+1))"
			
			# MAC0317 - Introdução ao Processamento de Sinais Digitais
			elif [ "$codigo_disciplina" = "0317" ]; then
				dados[0]="$((${dados[0]}+1))"

			# MAC0315 - Otimização Linear
			elif [ "$codigo_disciplina" = "0315" ]; then
				dados[2]="$((${dados[2]}+1))"
				teoriaOBR[1]="$((${teoriaOBR[1]}+1))"
			
			# MAC0325 - Otimização Combinatória
			elif [ "$codigo_disciplina" = "0325" ]; then
				dados[2]="$((${dados[2]}+1))"
				teoriaOBR[1]="$((${teoriaOBR[1]}+1))"
				teoriaOPT[0]="$((${teoriaOPT[0]}+1))"

			# MAC0427 - Otimização Não Linear
			elif [ "$codigo_disciplina" = "0427" ]; then
				dados[2]="$((${dados[2]}+1))"
				teoriaOPT[1]="$((${teoriaOPT[1]}+1))"

			# MAC0431 - Introdução à Computação Paralela e Distribuída
			elif [ "$codigo_disciplina" = "0431" ]; then
				dados[3]="$((${dados[3]}+1))"

			# MAC0328 - Algoritmos em Grafos
			elif [ "$codigo_disciplina" = "0328" ]; then
				teoriaOBR[0]="$((${teoriaOBR[0]}+1))"

			# MAC0327 - Desafios de Programação
			elif [ "$codigo_disciplina" = "0327" ]; then
				teoriaOPT[0]="$((${teoriaOPT[0]}+1))"

			# MAC0331 - Geometria Computacional
			elif [ "$codigo_disciplina" = "0331" ]; then
				teoriaOPT[0]="$((${teoriaOPT[0]}+1))"

			# MAC0336 - Criptografia para Segurança de Dados
			elif [ "$codigo_disciplina" = "0336" ]; then
				teoriaOPT[0]="$((${teoriaOPT[0]}+1))"

			# MAC0385 - Estruturas de Dados Avançadas
			elif [ "$codigo_disciplina" = "0385" ]; then
				teoriaOPT[0]="$((${teoriaOPT[0]}+1))"

			# MAC0450 - Algoritmos de Aproximação
			elif [ "$codigo_disciplina" = "0450" ]; then
				teoriaOPT[0]="$((${teoriaOPT[0]}+1))"
				teoriaOPT[1]="$((${teoriaOPT[1]}+1))"

			# MAC0465 - Biologia Computacional
			elif [ "$codigo_disciplina" = "0465" ]; then
				teoriaOPT[0]="$((${teoriaOPT[0]}+1))"
				
			# MAC0466 - Teoria dos Jogos Algorítmica
			elif [ "$codigo_disciplina" = "0466" ]; then
				teoriaOPT[0]="$((${teoriaOPT[0]}+1))"

			# MAC0320 - Introdução à Teoria dos Grafos
			elif [ "$codigo_disciplina" = "0320" ]; then
				teoriaOBR[2]="$((${teoriaOBR[2]}+1))"

			# MAC0436 - Tópicos de Matemática Discreta I
			elif [ "$codigo_disciplina" = "0436" ]; then
				teoriaOPT[2]="$((${teoriaOPT[2]}+1))"

			# MAC0690 - Tópicos em Combinatória Contemporânea I
			elif [ "$codigo_disciplina" = "0690" ]; then
				teoriaOPT[2]="$((${teoriaOPT[2]}+1))"

			# MAC0691 - Tópicos na Teoria Algébrica dos Grafos
			elif [ "$codigo_disciplina" = "0691" ]; then
				teoriaOPT[2]="$((${teoriaOPT[2]}+1))"
			
			# MAC0775 - Métodos Probabilísticos em Combinatória e em Teoria da Computação I
			elif [ "$codigo_disciplina" = "0775" ]; then
				teoriaOPT[2]="$((${teoriaOPT[2]}+1))"

			# MAC0776 - Métodos Probabilísticos em Combinatória e em Teoria da Computação II
			elif [ "$codigo_disciplina" = "0776" ]; then
				teoriaOPT[2]="$((${teoriaOPT[2]}+1))"
			fi

		fi

	fi

	if [ ! -z $1 ]; then
		printf $nome_disciplina" - "$status_disciplina"\n"
	fi

	i="$(($i+1))";
done

if [ "${sistemas[0]}" -ge 2 ] && [ "${sistemas[1]}" -ge 2 ] && [ "${sistemas[2]}" -ge 1 ] && [ $((${sistemas[0]}+${sistemas[1]}+${sistemas[2]})) -ge 7 ]; then
	printf "O aluno fez a trilha de Sistemas de Software\n"
else
	printf "O aluno não fez a trilha de Sistemas de Software\n"
fi

if [ "${ia[0]}" -ge 1 ] && [ "${ia[1]}" -ge 2 ] && [ "${ia[2]}" -ge 2 ] && [ "${ia[3]}" -ge 1 ]; then
	printf "O aluno fez a trilha de Inteligência Artificial\n"
else
	printf "O aluno não fez a trilha de Inteligência Artificial\n"
fi

if [ "${dados[0]}" -ge 4 ] && [ "${dados[1]}" -ge 1 ] && [ "${dados[2]}" -ge 1 ] && [ "${dados[3]}" -ge 1 ]; then
	printf "O aluno fez a trilha de Ciência de Dados\n"
else
	printf "O aluno não fez a trilha de Ciência de Dados\n"
fi

if [ "${teoriaOBR[0]}" -ge 2 -a "${teoriaOBR[1]}" -ge 2 ] || [ "${teoriaOBR[1]}" -ge 2 -a "${teoriaOBR[2]}" -ge 3 ] || [ "${teoriaOBR[0]}" -ge 2 -a "${teoriaOBR[2]}" -ge 3 ]; then
	if [ $((${teoriaOBR[0]}+${teoriaOBR[1]}+${teoriaOBR[2]}+${teoriaOPT[0]}+${teoriaOPT[1]}+${teoriaOPT[2]})) -ge 7 ]; then
		printf "O aluno fez a trilha de Teoria da Computação\n"
	else
		printf "O aluno não fez a trilha de Teoria da Computação\n"
	fi
else
	printf "O aluno não fez a trilha de Teoria da Computação\n"
fi
