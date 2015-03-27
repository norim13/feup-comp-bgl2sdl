grammar Calc;

TAG_START_OPEN : '<' ;
TAG_CLOSE : '>' ;
/*https://theantlrguy.atlassian.net/wiki/display/ANTLR3/1.+Lexer*/






NUM : [0-9]+ ;
OP1 : '+' | '-' ;
OP2 : '*' | '/' ;
OPEN : '(' ;
CLOSE : ')' ;
WS: [ \t\n\r]+ -> skip ;

start : exp EOF 				{System.out.println("Result: " + $exp.v);}
	;

exp returns[int v]:
		e=exp OP1 term 			{if($OP1.text.equals("+")) 
									$v = $e.v + $term.valor; 
								else 
									$v = $e.v - $term.valor;}
	| 	term 					{$v = $term.valor;}
	;
	
term returns[int valor]: 
		a=term OP2 fact			{if($OP2.text.equals("*")) 
									$valor = $a.valor * $fact.value; 
								else 
									$valor = $a.valor / $fact.value;}
	|	fact 					{$valor = $fact.value;}
	;

fact returns[int value] : 
		NUM						{$value = Integer.parseInt($NUM.text);}
	|	OPEN exp CLOSE 			{$value = $exp.v;}
	;
