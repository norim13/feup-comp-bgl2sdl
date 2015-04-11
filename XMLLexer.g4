
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

/////////////////////FLOATS///////////////////////
LAT: 'lat="' -> pushMode(FLOAT_MODE);
LON: 'lon="'-> pushMode(FLOAT_MODE);
ALT: 'alt="' -> pushMode(FLOAT_MODE);
MAGVAR: 'magvar="' -> pushMode(FLOAT_MODE);
FREQUENCY: 'frequency="' -> pushMode(FLOAT_MODE);
TRAFFICSCALAR: 'trafficScalar="' -> pushMode(FLOAT_MODE);
PATTERNALTITUDE: 'patternAltitude="' -> pushMode(FLOAT_MODE);
SECONDARYMARKINGBIAS:'secondaryMarkingBias="'-> pushMode(FLOAT_MODE);
PRIMARYMARKINGBIAS:'primaryMarkingBias="'-> pushMode(FLOAT_MODE);
SPACING: 'spacing="'-> pushMode(FLOAT_MODE);
PITCH: 'pitch="'-> pushMode(FLOAT_MODE);
RANGE: 'range="'-> pushMode(FLOAT_MODE);
HEADING: 'heading="' -> pushMode(FLOAT_MODE);
TEEOFFSET: 'teeOffset'[1-9]'="'-> pushMode(FLOAT_MODE);
WEIGHTLIMIT: 'weightLimit="'-> pushMode(FLOAT_MODE);
LENGTH: 'length="' -> pushMode(FLOAT_MODE);
WIDTH: 'width="'-> pushMode(FLOAT_MODE);
BIASX: 'biasX="'-> pushMode(FLOAT_MODE);
BIASY: 'biasY="'-> pushMode(FLOAT_MODE);
BIASZ: 'biasZ="'-> pushMode(FLOAT_MODE);


/////////////////////INTEGERS///////////////////////
STROBES: 'strobes="' -> pushMode(INTEGER_MODE);
INDEX: 'index="' -> pushMode(INTEGER_MODE);
START: 'start="' -> pushMode(INTEGER_MODE);
AIRPORTTESTRADIUS : 'airportTestRadius="' -> pushMode(INTEGER_MODE);
RADIUS: 'radius="' -> pushMode(INTEGER_MODE);

//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
OpenLight: '<Lights' ;

CENTER_RED: 'centerRed';

OpenOffsetThreshold: '<OffsetThreshold';

OpenBlastPad: '<BlastPad';

OpenOverrun: '<Overrun';

OpenApproachLights: '<ApproachLights' ;


REIL: 'reil';
ENDLIGHTS: 'endLights';


OpenVasi: '<Vasi';

SIDE: 'side';


OpenIls: '<Ils';
CloseIls: '</Ils>';

BACKCOURSE: 'backCourse';


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



//////////////////////////////////////////////////////////////////////
//////////////////////////// ATRIBUTE NAMES //////////////////////////
//////////////////////////////////////////////////////////////////////

/* Attributes */


NAME: 'name';
REGION: 'region';
COUNTRY: 'country';
STATE: 'state';
CITY: 'city';

IDENT: 'ident' ;


TYPE: 'type' ;
END: 'end';

PRIMARYTAKEOFF: 'primaryTakeoff' ;
PRIMARYLANDING: 'primaryLanding' ;
PRIMARYPATTERN : 'primaryPattern';
SECONDARYTAKEOFF: 'secondaryTakeoff' ;
SECONDARYLANDING: 'secondaryLanding' ;
SECONDARYPATTERN: 'secondaryPattern' ;


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
ORIENTATION: 'orientation';

AIRLINECODES: 'airlineCodes';


DRAWSURFACE: 'drawSurface';
DRAWDETAIL: 'drawDetail';
CENTERLINE: 'centerLine';
CENTERLINELIGHTED: 'centerLineLighted';


LEFTEDGELIGHTED: 'leftEdgeLighted';
RIGHTEDGELIGHTED: 'rightEdgeLighted';


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


//////////////////////////////////////////////////////////////////////
///////////////////////////////// WORDS //////////////////////////////
//////////////////////////////////////////////////////////////////////
METERS: 'M';
FEET: 'F';
NAUTICALMILES: 'N';


LEFT_RIGHT:'LEFT' | 'RIGHT';

YES_NO: 'YES' | 'NO' ;
BOOLEAN: 'TRUE' | 'FALSE' ;

PRIORITY: 'PRIMARY' | 'SECONDARY';

ORIENTATIONTYPE: 'FORWARD' | 'REVERSE';

NAMETAXIWAYPARKING:
'PARKING'
| 'DOCK'
| 'GATE'
| 'GATE_'[A-Z] 
| 'NONE'
| ['N'|'NE'|'NW'|'SE'|'S'|'SW'|'W'|'E']'_PARKING';


DESIGNATORTYPES: 
'NONE' | 'C' 
'CENTER' | 'L' 
'LEFT' | 'R'
'RIGHT' | 'W'
'WATER' | 'A' | 'B';


//////////////////////////////////////////////////////////////////////
//////////////////////////////// GENERAL /////////////////////////////
//////////////////////////////////////////////////////////////////////

INT_NUMBER: DIGIT+; 
/*tive de por isto pq o atributo "end" aparece 
sempre como integer, mas há um sitio em que 
aparece a receber palavras... estragou-me o esquema todo*/


STRING_LETTERS_UPPERCASE : [A-Z ]+ ;
STRING_LETTERS_LOWERCASE : [a-z ]+ ;
STRING_LETTERS : [A-Za-z ]+  ;
STRING_LETTERS_NUMBERS: (DIGIT | UPPER_CASE_LETTER | LOWER_CASE_LETTER | '_')+  ;


AIRLINECODESVALUES: UPPER_CASE_LETTER+(','UPPER_CASE_LETTER+)*;

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
NUMBER_VALUES:( ([0-9][0-9]?[0-9]?[0-9]?) | DIRECTIONS )-> popMode; 

/*( ([0][0-9]) | DIRECTIONS	| [0-9]([0-9])?	)*/
/*
no final: 
	00-09 | 0-36 | DIR 
	ou 0-3999
conforme o atributo onde estamos...
*/	

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


mode INTEGER_MODE;
UnsignedIntegerValue: ([0-9] | ([1-9][0-9]* (DOT '0')?) ) ->popMode;
IntegerValue: ('+' | '-' )? UnsignedIntegerValue ->popMode;

mode FLOAT_MODE;
UnsignedFloatValue: UnsignedIntegerValue2 (DOT [0-9]+)? -> popMode;
FloatingPointValue: IntegerValue (DOT [0-9]+)? ->popMode;
UnsignedIntegerValue2: [0-9] | ([1-9][0-9]*);



//////////////////////////////////////////////////////////////////////
/////////////////////////  TYPES COMENTADOS  /////////////////////////
//////////////////////////////////////////////////////////////////////

/*
TYPESFUEL_WORDS: '73'|'87'|'100'|'130'|'145'|'MOGAS'|'JET'|'JETA'
	|'JETA1'|'JETAP'|'JETB'|'JET4'|'JET5'|'UNKNOWN';	


TYPEDELETESTART:
		'RUNWAY'			|
		'HELIPAD'			|
		'WATER'				;

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

*/