COMP MIEIC FEUP 2014/2015

Grupo: 46

Tema: #2 BGL to SDL

Elementos:
	- André Pires ei12058
	- Filipe Gama ei12068
	- Filipe Miranda ei12021
	- João Bandeira ei12022
	
------------------------------------------

Instruções de compilação:
	Para (re)compilar o codigo antlr e o java correr:
		- run-compile.bat 
	
	Para correr será apenas necessário correr um dos .bat fornecidos:
		1 - run-java-only-sa-carneiro.bat
		2 - run-java-only-sa-carneiro-erros.bat
		3 - run-java-only-tancos.bat
		
------------------------------------------

Descrição dos Exemplos:
		1 - faz parse do ficheiro (xmls/sa-carneiro.xml)
			nao tem erros
			gera o output em sdl (outputs/sa-carneiro.xml)
		2- 	faz parse do ficheiro (xmls/sa-carneiro-erros.xml)
			tem erros
			nao gera o output em sdl
			abre uma GUI com os erros do ficheiro
		3- 	faz parse do ficheiro (xmls/tancos.xml)
			nao tem erros
			gera o output em sdl (outputs/tancos.xml)
			
-----------------------------------------

Descrição de Utilização:
		- correr um dos bats anteriormente referidos ou
		- java -cp "bin\.;lib\antlr-4.5-complete.jar" TestXML <input_file> <output_file>
			
-----------------------------------------
			
Análise Lexical:
		- XMLLexer.g4 (na pasta g4)
		- com erros lexicais, estes sao mostrados na GUI
		
-----------------------------------------
				
Análise Sintática:
		- XMLParser.g4 (na pasta g4)
		- com erros sintaticos, estes sao mostrados na GUI
		- nao é possivel recuperação de erros, quando estes existem o programa simplesmente não gera output
		
-----------------------------------------
	
Análise Semântica:
		- XMLParser.g4 (na pasta g4)
		- com erros semânticos, estes sao mostrados na GUI
		- quando existem erros semânticos o programa simplesmente não gera output
		- verificações:
			- atributos obrigatórios
			- atributos não repetidos
			- palavras reservadas que não tinham sido verificadas na análise lexical 
				- por exemplo, unidades de comprimento e alguns atributos como "type"
			- index referidos em TaxiwayPath existem em TaxiwayPoint
			- tamanho de algumas strings
			- range de alguns números
			- entre outros
			
-----------------------------------------
			
Representação Intermédia:
		- fizemos representação com algumas classes em java relativas a alguns elementos quer do formato de input quer de output
		- contem informação utilizada no tratamento e geração de output do programa
		- classes estão em 'src/classes'
		
-----------------------------------------

Geração de Código:
		- código final é gerado sempre que o ficheiro de input não contém qualquer erro
		- código é sempre gerado sem qualquer problema, pois relativamente aos atributos sobre o qual não temos informação o output é gerado com informação dummy (ex 'XXXXXXXXXXXXXXXXXXX')
		
-----------------------------------------

Testes:
		- foram efetuados múltiplos testes com diferentes erros
		- não houve automação destes, foram feitos manualmente com vários ficheiros de input
		
-----------------------------------------

Arquitetura:
		- para geração de output é percorrida a árvore de parse gerada pelo antlr
		- de acordo com o elemento lido da árvore é feita a interpretação correspondente criando um objeto da representação intermédia
		- depois de lido todos os elementos é feita a transformação numa string de output
		
-----------------------------------------
		
Pontos Positivos:
		- fazemos fetch online do IATA de um aeroporto a partir do ICAO
		
------------------------------------------

Pontos Negativos:
		- index das runways as vezes não é bem atribuido
		