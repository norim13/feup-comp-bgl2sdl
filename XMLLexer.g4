
lexer grammar XMLLexer;

COMMENT     :   '<!--' .*? '-->' ;

OPEN        :   '<'   ;
CLOSE       :   '>' ;
SLASH_CLOSE :   '/>' ;
SLASH       :   '/' ;
HIFEN		:   '-' ;
EQUALS      :   '=' ;
DOUBLE_QUOTES: '"' ;
DOT: '.' ;
WS			: 	[ \t\n\r]+ 			-> skip ;

STRING_LETTERS : ('"' [A-Za-z ]* '"')
            |   ('\'' [A-Za-z ]* '\'')
            ;

OpenAirport: '<Airport';
EndAirport: '</Airport>';

/* Attributes */

REGION: 'region';
COUNTRY: 'country';
STATE: 'state';
CITY: 'city';
NAME: 'name';
LAT: 'lat';
LON: 'lon';
ALT: 'alt' ;
MAGVAR: 'magvar' ;
IDENT: 'ident' ;
AIRPORTTESTRADIUS : 'airportTestRadius' ;
TRAFFICSCALAR: 'trafficScalar' ;

 /*End Attributes*/

 /* Units */

Meters: 'M' ;
Feet: 'F' ;
NauticalMiles: 'N' ;

 /* End Units */ 


IntegerValue: ('+' | '-' )? ( '0' | ([1-9][0-9]* (DOT '0')?)  );
FloatingPointValue: IntegerValue DOT [0-9]+ ;
