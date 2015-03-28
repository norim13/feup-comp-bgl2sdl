
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

 /*Delete Start *****************************************/
 
TYPEDELETESTART:
		'RUNWAY'			|
		'HELIPAD'			|
		'WATER'				;

 /*Delete Frequency ***************************************/
 
 /*108.0 to 136.992 */
 FREQUENCYVALUES: 	'1'('0'[89]|[12][0-9]|'3'[0-5])DOT ([0-9])* |
					'136' DOT ([0-9]{1,2}|[1-8][0-9]{2}|'9'[0-8][0-9]|'99'[0-2]);

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
		
//INDEXVALUE: [0-9]{1,3} | [1-3][0-9]{3}; //[0-3999]
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

IntegerValue: ('+' | '-' )? ( '0' | ([1-9][0-9]* (DOT '0')?)  );
FloatingPointValue: IntegerValue DOT [0-9]+ ;

STRING_LETTERS_UPPERCASE : [A-Z ]+ ;
STRING_LETTERS_LOWERCASE : [a-z ]+ ;
STRING_LETTERS : [A-Za-z ]+  ;
STRING_LETTERS_NUMBERS: [0-9A-Za-z ]+  ;


/*--------------------------------- TAXIWAYPOINT ------------------------------*/
INDEXVALUE: [0-9]{1,3} | [1-3][0-9]{3}; //[0-3999]
//TYPE: 'type';
TAXIWAYPOINTTYPE: 'NORMAL' | 'HOLD_SHORT' | 'ILS_HOLD_SHORT' | 'HOLD_SHORT_NO_DRAW' | 'ILS_HOLD_SHORT_NO_DRAW';
ORIENTATIONTYPE: 'FORWARD' | 'REVERSE';

/*--------------------------------- TAXIWAYPARKING ------------------------------*/
//INDEX: 'index';
//INDEXVALUE: [0-3999];
//HEADING: 'heading';
HEADINGVALUE: [0-9]{1,2}(DOT [0-9]+)? | [12][0-9]{2}(DOT [0-9]+)? | '3'[0-5][0-9](DOT [0-9]+)? | '360'(DOT '0')?; //[0.0-360.0];
//TYPE: 'type';
TAXIWAYPARKINGTYPE: 
'NONE'
| 'DOCK_GA'
| 'FUEL'
| 'GATE_'['HEAVY'|'MEDIUM'|'SMALL']
| 'RAMP_CARGO'
| 'RAMP_GA'('_'('LARGE'|'MEDIUM'|'SMALL'))?
| 'RAMP_MIL_'['CARGO'|'COMBAT']
| 'VEHICLE';


//NAME: 'name';
NAMETAXIWAYPARKING:
'PARKING'
| 'DOCK'
| 'GATE'
| 'GATE_'[A-Z] 
| 'NONE'
| ['N'|'NE'|'NW'|'SE'|'S'|'SW'|'W'|'E']'_PARKING';

//NUMBER: 'number';
//NUMBERVALUE == INDEXVALUE

AIRLINECODESVALUES: [A-Z]+(','[A-Z]+)*;

PUSHBACKVALUES: 'NONE' | 'BOTH' | 'LEFT' | 'RIGHT';

TEEOFFSETVALUES: '0'(DOT [1-9]+) | [1-9](DOT [0-9]+)? | [1-4][0-9](DOT [0-9]+)? | '50'(DOT '0')?; //[0.1-50.0];

/*--------------------------------- TAXIWAYPATH ------------------------------*/

//TYPE: 'type';
TAXIWAYPATHTYPE: 'RUNWAY' | 'PARKING' | 'TAXI' | 'PATH' | 'CLOSED' | 'VEHICLE';

//NUMBER
//WIDTH: 'width';

//SURFACE: 'surface';
SURFACETYPES: 
 'ASPHALT' | 'BITUMINOUS' | 'BRICK' 
| 'CLAY' | 'CEMENT' | 'CONCRETE'
| 'CORAL' | 'DIRT' | 'GRASS'
| 'GRAVEL' | 'ICE' | 'MACADAM'
| 'OIL_TREATED' | 'PLANKS' | 'SAND'
| 'SHALE' | 'SNOW' | 'STEEL_MATS'
| 'TARMAC' | 'UNKNOWN' | 'WATER';


EDGETYPE: 'NONE' | 'SOLID' | 'DASHED' | 'SOLID_DASHED';

NUMBERTAXIWAYPATH: '0'?[0-9] | [12][0-9] | '3'[0-6] //0[0-9] | [0-36]
| 'EAST' | 'NORTH'
| 'NORTHEAST' | 'NORTHWEST'
| 'SOUTH' | 'SOUTHEAST'
| 'SOUTHWEST' | 'WEST';

//DESIGNATOR: 'designator';
DESIGNATORTYPES: 
'NONE' | 'C' 
'CENTER' | 'L' 
'LEFT' | 'R'
'RIGHT' | 'W'
'WATER' | 'A' | 'B';

TAXIWAYPATHNAMETYPE: [0-9]{1,2} | '1'[0-9]{2} | '2'[0-4][0-9] | '25'[0-5]; //[0-255];

/*--------------------------------- TAXIWAYNAME ------------------------------*/
TAXINAMEINDEX: [0-9]{1,2} | '1'[0-9]{2} | '2'[0-4][0-9] | '25'[0-5]; //[0-255];
TAXINAME: [0-9A-Za-z]{0,8};