
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
 
 
OpenServices: '<Services>';
CloseServices: '</Services>';

OpenFuel: '<Fuel'			;
/* Attributes Fuel*/
TYPE: 'type';
AVAILABILITY: 'availability';
TYPESFUEL: '73'|'87'|'100'|'130'|'145'|'MOGAS'|'JET'|'JETA'|'JETA1'|'JETAP'|'JETB'|'JET4'|'JET5'|'UNKNOWN';
AVAILABILITYFUEL: 'YES'|'NO'|'UNKNOWN'|'PRIOR_REQUEST';

 
 /* Atributes Delete Airport */
 DELETEALLAPPROACHES: 'deleteAllApproaches '		;
 DELETEALLAPRONLIGHTS: 'deleteAllApronLights'		;
 DELETEALLAPRONS: 'deleteAllAprons'					;
 DELETEALLFREQUENCIES: 'deleteAllFrequencies'		;
 DELETEALLHELIPADS:'deleteAllHelipads'				;
 DELETEALLRUNWAYS:'deleteAllRunways'				;
 DELETEALLSTARTS:'deleteAllStarts'					;
 DELETEALLTAXIWAYS:'deleteAllTaxiways'				;
 DELETEALLBLASTFENCES:'deleteAllBlastFences'		;
 DELETEALLBOUNDARYFENCES:'deleteAllBoundaryFences'	;
 DELETEALLCONTROLTOWERS:'deleteAllControlTowers'	;
 DELETEALLJETWAYS:'deleteAllJetways'				;
 
 

 /* Units */

Meters: 'M' ;
Feet: 'F' ;
NauticalMiles: 'N' ;

 /* End Units */ 

Boolean: 'TRUE' | 'FALSE';
IntegerValue: ('+' | '-' )? ( '0' | ([1-9][0-9]* (DOT '0')?)  );
FloatingPointValue: IntegerValue DOT [0-9]+ ;
