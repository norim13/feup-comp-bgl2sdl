
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


/* Units */

Meters: 'M' ;
Feet: 'F' ;
NauticalMiles: 'N' ;

 /* End Units */ 
 
 /* -------------------------------MIRA-------------------*/
/*Fuel*****************************************************/
TYPESFUEL: '73'|'87'|'100'|'130'|'145'|'MOGAS'|'JET'|'JETA'|'JETA1'|'JETAP'|'JETB'|'JET4'|'JET5'|'UNKNOWN';
AVAILABILITYFUEL: YES_NO|'UNKNOWN'|'PRIOR_REQUEST';

 
 /*Delete Airport *****************************************/

 DELETEAIRPORTATRIBUTES: 
'deleteAllApproaches'		|
'deleteAllApronLights'		|
'deleteAllAprons'			|
'deleteAllFrequencies'		|
'deleteAllHelipads'			|
'deleteAllRunways'			|
'deleteAllStarts'			|
'deleteAllTaxiways'			|
'deleteAllBlastFences'		|
'deleteAllBoundaryFences'	|
'deleteAllControlTowers'	|
'deleteAllJetways'			;

/*Runway*****************************************************/
SURFACERUNWAY:
		'ASPHALT'			|
		'BITUMINOUS'		|
		'BRICK'				|
		'CLAY'				|
		'CEMENT'			|
		'CONCRETE'			|
		'CORAL'				|
		'DIRT'				|
		'GRASS'				|
		'GRAVEL'			|
		'ICE'				|
		'MACADAM'			|
		'OIL_TREATED, PLANKS'|
		'SAND'				|
		'SHALE'				|
		'SNOW'				|
		'STEEL_MATS'		|
		'TARMAC'			|
		'UNKNOWN'			|
		'WATER'				;
		
NUMBERRUNWAY:
			([0][0-9])			|
			([0-9]|[12][0-9]|[3][0-6])			|
			DIRECTIONS		;
			
DIRECTIONS:
			'EAST'			|
			'NORTH'			|
			'NORTHEAST'		|
			'NORTHWEST'		|
			'SOUTH'			|
			'SOUTHEAST'		|
			'SOUTHWEST'		|
			'WEST'			;
			
LEFT_RIGHT:'LEFT' | 'RIGHT';
			
DESIGNATORVALUES:
			'NONE'			|
			'C'				|
			'CENTER'		|
			'L'				|
			'LEFT'			|
			'R'				|
			'RIGHT'			|
			'W'				|
			'WATER'			|
			'A'				|
			'B'				;



 /* -----------------------------------------------------------*/


/* Other */
YES_NO: 'YES' | 'NO' ;
BOOLEAN: 'TRUE' | 'FALSE' ;
YES_NO_BOOLEAN: YES_NO|BOOLEAN;
/* End Other */


/* Open elements */
OpenAirport: '<Airport' ;
OpenServices: '<Services>' ;
OpenTower: '<Tower' ;
OpenRunway: '<Runway';
OpenStart: '<Start' ;
OpenCom: '<Com' ;
OpenFuel: '<Fuel' ;
OpenDeleteAirport:'<DeleteAirport'	;
OpenMarkings: '<Markings';

/* End Elements */
EndAirport: '</Airport>';
EndServices: '</Services>' ;
EndRunway: '</Runway>' ;
EndTower: '</Tower>' ;


/* Attributes */
LAT: 'lat';
LON: 'lon';
ALT: 'alt' ;
HEADING: 'heading' ;
TYPE: 'type';
DESIGNATOR: 'designator' ;
NAME: 'name';
REGION: 'region';
COUNTRY: 'country';
STATE: 'state';
CITY: 'city';
MAGVAR: 'magvar' ;
IDENT: 'ident' ;
AIRPORTTESTRADIUS : 'airportTestRadius' ;
TRAFFICSCALAR: 'trafficScalar' ;
LENGTH: 'length' ;
WIDTH: 'width' ;
NUMBER: 'number' ;
PATTERNALTITUDE: 'patternAltitude' ;
PRIMARYDESIGNATOR: 'primaryDesignator';
PRIMARYTAKEOFF: 'primaryTakeoff' ;
PRIMARYLANDING: 'primaryLanding' ;
PRIMARYPATTERN : 'primaryPattern';
PRIMARYMARKINGBIAS:'primaryMarkingBias';
SECONDARYTAKEOFF: 'secondaryTakeoff' ;
SECONDARYLANDING: 'secondaryLanding' ;
SECONDARYPATTERN: 'secondaryPattern' ;
SECONDARYMARKINGBIAS:'secondaryMarkingBias';
SECONDARYDESIGNATOR: 'secondaryDesignator';
FREQUENCY: 'frequency' ;
AVAILABILITY: 'availability' ;
SURFACE: 'surface';

EDGES:'edges';
THRESHOLD:'threshold';
FIXEDDISTANCE:'fixedDistance';
TOUCHDOWN:'touchdown';
DASHES:'dashes';
PRECISION:'precision';
EDGEPAVEMENT:'edgePavement';
SINGLEEND:'singleEnd';
PRIMARYCLOSED:'primaryClosed';
SECONDARYCLOSED:'secondaryClosed';
PRIMARYSTOL:'primaryStol';
SECONDARYSTOL:'secondaryStol';





IntegerValue: ('+' | '-' )? ( '0' | ([1-9][0-9]* (DOT '0')?)  );
FloatingPointValue: IntegerValue DOT [0-9]+ ;

STRING_LETTERS_UPPERCASE : [A-Z ]+ ;
STRING_LETTERS_LOWERCASE : [a-z ]+ ;
STRING_LETTERS : [A-Za-z ]+  ;
STRING_LETTERS_NUMBERS: [0-9A-Za-z ]+  ;







