COMP MIEIC FEUP 2014/2015

Grupo: 46

Tema: #2 BGL to SDL

Elementos:
	- Andr� Pires ei12058
	- Filipe Gama ei12068
	- Filipe Miranda ei12021
	- Jo�o Bandeira ei12022
	
------------------------------------------

Instru��es de compila��o:
	Para (re)compilar o codigo antlr e o java correr:
		- run-compile.bat 
	
	Para correr ser� apenas necess�rio correr um dos .bat fornecidos:
		1 - run-java-only-sa-carneiro.bat
		2 - run-java-only-sa-carneiro-erros.bat
		3 - run-java-only-tancos.bat
		
------------------------------------------

Descri��o dos Exemplos:
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

Descri��o de Utiliza��o:
		- correr um dos bats anteriormente referidos ou
		- java -cp "bin\.;lib\antlr-4.5-complete.jar" TestXML <input_file> <output_file>
			
-----------------------------------------
			
An�lise Lexical:
		- XMLLexer.g4 (na pasta g4)
		- com erros lexicais, estes sao mostrados na GUI
		
-----------------------------------------
				
An�lise Sint�tica:
		- XMLParser.g4 (na pasta g4)
		- com erros sintaticos, estes sao mostrados na GUI
		- nao � possivel recupera��o de erros, quando estes existem o programa simplesmente n�o gera output
		
-----------------------------------------
	
An�lise Sem�ntica:
		- XMLParser.g4 (na pasta g4)
		- com erros sem�nticos, estes sao mostrados na GUI
		- quando existem erros sem�nticos o programa simplesmente n�o gera output
		- verifica��es:
			- atributos obrigat�rios
			- atributos n�o repetidos
			- palavras reservadas que n�o tinham sido verificadas na an�lise lexical 
				- por exemplo, unidades de comprimento e alguns atributos como "type"
			- index referidos em TaxiwayPath existem em TaxiwayPoint
			- tamanho de algumas strings
			- range de alguns n�meros
			- entre outros
			
-----------------------------------------
			
Representa��o Interm�dia:
		- fizemos representa��o com algumas classes em java relativas a alguns elementos quer do formato de input quer de output
		- contem informa��o utilizada no tratamento e gera��o de output do programa
		- classes est�o em 'src/classes'
		
-----------------------------------------

Gera��o de C�digo:
		- c�digo final � gerado sempre que o ficheiro de input n�o cont�m qualquer erro
		- c�digo � sempre gerado sem qualquer problema, pois relativamente aos atributos sobre o qual n�o temos informa��o o output � gerado com informa��o dummy (ex 'XXXXXXXXXXXXXXXXXXX')
		
-----------------------------------------

Testes:
		- foram efetuados m�ltiplos testes com diferentes erros
		- n�o houve automa��o destes, foram feitos manualmente com v�rios ficheiros de input
		
-----------------------------------------

Arquitetura:
		- para gera��o de output � percorrida a �rvore de parse gerada pelo antlr
		- de acordo com o elemento lido da �rvore � feita a interpreta��o correspondente criando um objeto da representa��o interm�dia
		- depois de lido todos os elementos � feita a transforma��o numa string de output
		
-----------------------------------------
		
Pontos Positivos:
		- fazemos fetch online do IATA de um aeroporto a partir do ICAO
		
------------------------------------------

Pontos Negativos:
		- index das runways as vezes n�o � bem atribuido
		