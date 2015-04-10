
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
AVAILABILITY: 'availability="' -> pushMode(AVAILABILITY_MODE);
SURFACE: 'surface="' -> pushMode(SURFACE_MODE); 
DESIGNATOR: 'designator="' -> pushMode(DESIGNATOR_MODE);
PRIMARYDESIGNATOR: 'primaryDesignator="' -> pushMode(DESIGNATOR_MODE);
SECONDARYDESIGNATOR: 'secondaryDesignator="'-> pushMode(DESIGNATOR_MODE);
NUMBER: 'number="'  -> pushMode(NUMBER_MODE);
CENTER: 'center="' -> pushMode(LEVELS_MODE);
EDGE: 'edge="' -> pushMode(LEVELS_MODE);
SYSTEM: 'system="' -> pushMode(SYSTEM_MODE);
PUSHBACK: 'pushBack="' ->pushMode(PUSHBACK_MODE);
LEFTEDGE: 'leftEdge="' -> pushMode(EDGETYPE_MODE);
RIGHTEDGE: 'rightEdge="' -> pushMode(EDGETYPE_MODE);
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

		
LEFT_RIGHT:'LEFT' | 'RIGHT';
	

TYPESFUEL_WORDS: '73'|'87'|'100'|'130'|'145'|'MOGAS'|'JET'|'JETA'
	|'JETA1'|'JETAP'|'JETB'|'JET4'|'JET5'|'UNKNOWN';	

 /* -----------------------------------------------------------*/

 /* -------------------------------Filippo-------------------*/

OpenLight: '<Lights' ;


CENTER_RED: 'centerRed';


OpenOffsetThreshold: '<OffsetThreshold';

OpenBlastPad: '<BlastPad';

OpenOverrun: '<Overrun';


OpenApproachLights: '<ApproachLights' ;


STROBES: 'strobes';
REIL: 'reil';
ENDLIGHTS: 'endLights';




OpenVasi: '<Vasi';

SIDE: 'side';
BIASZ: 'biasZ';
SPACING: 'spacing';
PITCH: 'pitch';

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

TYPE: 'type' ;

PATTERNALTITUDE: 'patternAltitude' ;
PRIMARYTAKEOFF: 'primaryTakeoff' ;
PRIMARYLANDING: 'primaryLanding' ;
PRIMARYPATTERN : 'primaryPattern';
PRIMARYMARKINGBIAS:'primaryMarkingBias';
SECONDARYTAKEOFF: 'secondaryTakeoff' ;
SECONDARYLANDING: 'secondaryLanding' ;
SECONDARYPATTERN: 'secondaryPattern' ;
SECONDARYMARKINGBIAS:'secondaryMarkingBias';
FREQUENCY: 'frequency' ;


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

TEEOFFSET: 'teeOffset'[1-9];

DRAWSURFACE: 'drawSurface';
DRAWDETAIL: 'drawDetail';
CENTERLINE: 'centerLine';
CENTERLINELIGHTED: 'centerLineLighted';
START: 'start';

WEIGHTLIMIT: 'weightLimit';
LEFTEDGELIGHTED: 'leftEdgeLighted';
RIGHTEDGELIGHTED: 'rightEdgeLighted';


END: 'end';


PRIORITY: 'PRIMARY' | 'SECONDARY';
/*--------------------------------- TAXIWAYPOINT ------------------------------*/


ORIENTATIONTYPE: 'FORWARD' | 'REVERSE';

/*--------------------------------- TAXIWAYPARKING ------------------------------*/




NAMETAXIWAYPARKING:
'PARKING'
| 'DOCK'
| 'GATE'
| 'GATE_'[A-Z] 
| 'NONE'
| ['N'|'NE'|'NW'|'SE'|'S'|'SW'|'W'|'E']'_PARKING';



/*--------------------------------- TAXIWAYPATH ------------------------------*/





DESIGNATORTYPES: 
'NONE' | 'C' 
'CENTER' | 'L' 
'LEFT' | 'R'
'RIGHT' | 'W'
'WATER' | 'A' | 'B';



/*--------------------------------- TAXIWAYNAME ------------------------------*/




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


TAXIWAYPOINTTYPE: 'NORMAL' | 'HOLD_SHORT' | 'ILS_HOLD_SHORT' | 'HOLD_SHORT_NO_DRAW' | 'ILS_HOLD_SHORT_NO_DRAW';

TAXIWAYPATHTYPE: 'RUNWAY' | 'PARKING' | 'TAXI' | 'PATH' | 'CLOSED' | 'VEHICLE';

TAXIWAYPARKINGTYPE: 
'NONE'
| 'DOCK_GA'
| 'FUEL'
| 'GATE_'['HEAVY'|'MEDIUM'|'SMALL']
| 'RAMP_CARGO'
| 'RAMP_GA'('_'('LARGE'|'MEDIUM'|'SMALL'))?
| 'RAMP_MIL_'['CARGO'|'COMBAT']
| 'VEHICLE';




//////////////////////////////////////////////////////////////////////
//////////////////////////////// GENERAL /////////////////////////////
//////////////////////////////////////////////////////////////////////


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



//////////////////////////////////////////////////////////////////////
///////////////////////////////  MODES  //////////////////////////////
//////////////////////////////////////////////////////////////////////


mode AVAILABILITY_MODE;
AVAILABILITY_WORDS: ('UNKNOWN' | 'PRIOR_REQUEST' | 'YES' | 'NO') -> popMode;

mode SURFACE_MODE;
SURFACETYPES:
		('ASPHALT'			|
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
		'WATER'				)-> popMode;
		

mode DESIGNATOR_MODE;
DESIGNATORVALUES:
			('NONE'			|
			'C'				|
			'CENTER'		|
			'L'				|
			'LEFT'			|
			'R'				|
			'RIGHT'			|
			'W'				|
			'WATER'			|
			'A'				|
			'B'				)->popMode;

mode NUMBER_MODE;
NUMBER_VALUES:( ([0][0-9]) | DIRECTIONS	| [0-9]([0-9])?	)-> popMode; 
/*no final: 00-09 | 0-36 | DIR */	

DIRECTIONS:
			'EAST'			|
			'NORTH'			|
			'NORTHEAST'		|
			'NORTHWEST'		|
			'SOUTH'			|
			'SOUTHEAST'		|
			'SOUTHWEST'		|
			'WEST'			;


mode LEVELS_MODE;
LEVELS:
	('NONE' |
	'LOW' |
	'MEDIUM' |
	'HIGH'  )-> popMode;


mode SYSTEM_MODE;
SYSTEM_OPTIONS: 
	('NONE' |
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
	'SSALS') -> popMode;

mode PUSHBACK_MODE;
PUSHBACKVALUES: ('NONE' | 'BOTH' | 'LEFT' | 'RIGHT') -> popMode;

mode EDGETYPE_MODE;
EDGETYPE: ('NONE' | 'SOLID' | 'DASHED' | 'SOLID_DASHED') -> popMode;