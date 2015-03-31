
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
AVAILABILITYFUEL: 'UNKNOWN' | 'PRIOR_REQUEST';

 
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

 /*Delete Start *****************************************/
 
TYPEDELETESTART:
		'RUNWAY'			|
		'HELIPAD'			|
		'WATER'				;

 /*Delete Frequency ***************************************/


 TYPEDELETEFREQUENCY:
	'APPROACH'				|
	'ASOS'					|
	'ATIS'					|
	'AWOS'					|
	'CENTER'				|
	'CLEARANCE'				|
	'CLEARANCE_PRE_TAXI'	|
	'CTAF'					|
	'DEPARTURE'				|
	'FSS'					|
	'GROUND'				|
	'MULTICOM'				|
	'REMOTE_CLEARANCE_DELIVERY'|
	'TOWER'					|
	'UNICOM'				;

/*Runway*****************************************************/
SURFACETYPES:
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

 /* -------------------------------Filippo-------------------*/

OpenLight: '<Lights' ;

CENTER: 'center';
EDGE: 'edge';
CENTER_RED: 'centerRed';

LEVELS:
	'NONE' |
	'LOW' |
	'MEDIUM' |
	'HIGH' ;



OpenOffsetThreshold: '<OffsetThreshold';



PRIORITY:
	'PRIMARY' |
	'SECONDARY';	


OpenBlastPad: '<BlastPad';

OpenOverrun: '<Overrun';


OpenApproachLights: '<ApproachLights' ;



SYSTEM: 'system';
STROBES: 'strobes';
REIL: 'reil';
ENDLIGHTS: 'endLights';

SYSTEM_OPTIONS: 
	'NONE' |
	'ALSF1' |
	'ALSF2' |
	'CALVERT' |
	'CALVERT2' |
	'MALS'|
	'MALSF'|
	'MALSR'|
	'ODALS'|
	'RAIL'|
	'SALS'|
	'SALSF'|
	'SSALF'|
	'SSALR'|
	'SSALS' ;


OpenVasi: '<Vasi';

SIDE: 'side';
BIASZ: 'biasZ';
SPACING: 'spacing';
PITCH: 'pitch';

VASI_TYPE: 
	'PAPI2'
	'PAPI4'
	'PVASI'
	'TRICOLOR'
	'TVASI' 
	'VASI21'
	'VASI22'
	'VASI23'
	'VASI31'
	'VASI32'
	'VASI33'
	'BALL'
	'APAP'
	'PANELS';

OpenIls: '<Ils';
CloseIls: '</Ils>';

RANGE: 'range';
BACKCOURSE: 'backCourse';




  /* -----------------------------------------------------------*/


/* Other */
YES_NO: 'YES' | 'NO' ;
BOOLEAN: 'TRUE' | 'FALSE' ;
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
OpenDeleteRunway:'<DeleteRunway';
OpenDeleteStart:'<DeleteStart';
OpenDeleteFrequency:'<DeleteFrequency';
OpenMarkings: '<Markings';
OpenTaxiwayPoint: '<TaxiwayPoint';
OpenTaxiwayParking: '<TaxiwayParking';
OpenTaxiwayPath: '<TaxiwayPath';
OpenTaxiName: '<TaxiName';

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
INDEX: 'index';
ORIENTATION: 'orientation';
BIASX: 'biasX';
BIASY: 'biasY';

RADIUS: 'radius';
AIRLINECODES: 'airlineCodes';
PUSHBACK: 'pushBack';
TEEOFFSET: 'teeOffset'[1-9];

DRAWSURFACE: 'drawSurface';
DRAWDETAIL: 'drawDetail';
CENTERLINE: 'centerLine';
CENTERLINELIGHTED: 'centerLineLighted';
START: 'start';
END: 'end';
WEIGHTLIMIT: 'weightLimit';
LEFTEDGE: 'leftEdge';
LEFTEDGELIGHTED: 'leftEdgeLighted';
RIGHTEDGE: 'rightEdge';
RIGHTEDGELIGHTED: 'rightEdgeLighted';





/*--------------------------------- TAXIWAYPOINT ------------------------------*/

TAXIWAYPOINTTYPE: 'NORMAL' | 'HOLD_SHORT' | 'ILS_HOLD_SHORT' | 'HOLD_SHORT_NO_DRAW' | 'ILS_HOLD_SHORT_NO_DRAW';
ORIENTATIONTYPE: 'FORWARD' | 'REVERSE';

/*--------------------------------- TAXIWAYPARKING ------------------------------*/

TAXIWAYPARKINGTYPE: 
'NONE'
| 'DOCK_GA'
| 'FUEL'
| 'GATE_'['HEAVY'|'MEDIUM'|'SMALL']
| 'RAMP_CARGO'
| 'RAMP_GA'('_'('LARGE'|'MEDIUM'|'SMALL'))?
| 'RAMP_MIL_'['CARGO'|'COMBAT']
| 'VEHICLE';


NAMETAXIWAYPARKING:
'PARKING'
| 'DOCK'
| 'GATE'
| 'GATE_'[A-Z] 
| 'NONE'
| ['N'|'NE'|'NW'|'SE'|'S'|'SW'|'W'|'E']'_PARKING';


PUSHBACKVALUES: 'NONE' | 'BOTH' | 'LEFT' | 'RIGHT';



/*--------------------------------- TAXIWAYPATH ------------------------------*/


TAXIWAYPATHTYPE: 'RUNWAY' | 'PARKING' | 'TAXI' | 'PATH' | 'CLOSED' | 'VEHICLE';

EDGETYPE: 'NONE' | 'SOLID' | 'DASHED' | 'SOLID_DASHED';

DESIGNATORTYPES: 
'NONE' | 'C' 
'CENTER' | 'L' 
'LEFT' | 'R'
'RIGHT' | 'W'
'WATER' | 'A' | 'B';



/*--------------------------------- TAXIWAYNAME ------------------------------*/

TAXINAME: [0-9A-Za-z]; //{0,8}




NUMBERRUNWAY: ([0][0-9]) | DIRECTIONS		;	



UnsignedIntegerValue: [0-9] | ([1-9][0-9]* (DOT '0')?) ;
IntegerValue: ('+' | '-' )? UnsignedIntegerValue ;
UnsignedFloatValue: UnsignedIntegerValue DOT [0-9]+ ;
FloatingPointValue: IntegerValue DOT [0-9]+ ;

STRING_LETTERS_UPPERCASE : [A-Z ]+ ;
STRING_LETTERS_LOWERCASE : [a-z ]+ ;
STRING_LETTERS : [A-Za-z ]+  ;
STRING_LETTERS_NUMBERS: (DIGIT | UPPER_CASE_LETTER | LOWER_CASE_LETTER)+  ;


AIRLINECODESVALUES: [A-Z]+(','[A-Z]+)*;

fragment DIGIT: [0-9] ;
fragment UPPER_CASE_LETTER: [A-Z] ;
fragment LOWER_CASE_LETTER: [a-z] ;