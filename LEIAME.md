# DESCRIÇÃO:
    O propósito desse programa é verificar se, dado o hitórico escolar de um discente, os requesitos 
    necessários para completar uma trilha do curso de Bacharelado em Ciência da Computação do Instituto 
    de Matemática e Estatística da Universidade de São Paulo, currículo em vigor em 2023, foram cumpridos.

# COMO EXECUTAR:
    Abra no terminal o diretório em que se encontra o programa verifica_trilha.sh utilizando:
> 		 cd [caminho até o diretório]
	e depois execute o comando:
> 		bash verifica_trilha.sh

    Certifique-se de que o arquivo do histórico escolar a ser analisado esteja também nesse mesmo
    diretório.

    Após isso, aparecerá abaixo a seguinte frase:
        Digite o nome do arquivo de histórico escolar (sem .pdf):
    Insira, então, apenas o nome do arquivo de histórico escolar a ser analisado, sem colocar a extensão
    .pdf ao final e sem informar o caminho até o arquivo. Quando você  acabar de escrever o nome, 
    pressione a tecla ENTER para enviar o nome ao programa.

    Assim que pressionado ENTER, logo abaixo do nome que você inseriu, aparecerá o status de completude
    das trilhas pelo aluno - isto é, se ele fez determinada trilha ou não. Essa é a saída do programa.

    Caso você queira ser informado das matérias cursadas pelo aluno ao longo da graduação, incluindo
    o status dessas matérias* no momento atual, digite um argumento qualquer na linha de comando, como "oi".
    Exemplo:
> 	bash verifica_trilha.sh oi

    Prossiga normalmente, como anteriormente explicado. Quando a saída for gerada, apararecerão, na ordem em
    que aparecem no histórico escolar original, as matérias cursadas. O status de completude das trilhas pelo 
    aluno também será informado.

    * Possíveis status: MA - Matriculado;
                        A - Aprovado;
                        T - Trancado;
                        P - Pendente;
                        RN - Reprovado por notas;
                        RF - Reprovado por frequência;
                        RA - Reprovado por notas e frequência;
                        I - Inscrito
                        IR - Inscrição reservada
                        IT - Inscrição em turma lotada
                        IP - Inscrição em optativa preterida
                        IL - Inscrição em lista de espera
                        AE - Aproveitamento de Estudo
                        DI - Dispensado
                        DS - Dispensado por prova de suficiência (Res. CoG 4844/01)


# DEPENDÊNCIAS:
    GNU bash, versão 5.1.16(1)-release (x86_64-pc-linux-gnu) ou superior.

    Informações adicionais da máquina onde os programas foram criados e executados originalmente:
		Versão do sistema operacional: Ubuntu 22.04.2 LTS;
		Arquitetura da máquina: x86_64;
		Processador: Intel® Core™ i3-7100U CPU @ 2.40GHz × 4;
		Memória RAM: 12,0 GiB.
