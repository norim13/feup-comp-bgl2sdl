parser grammar XMLParser;

options { tokenVocab=XMLLexer; }

document    :  airport;



airport: OpenAirport airportAttributes* CLOSE  airportElements EndAirport; 



airportAttributes: 
	region  
	| country
	| state
	| city 
	| name
	| latitude 
	| longitude 
	| altitude 
	| magvar 
	| ident
	| airportTestRadius
	| trafficScalar;

region: REGION EQUALS DOUBLE_QUOTES stringLettersMixedCase DOUBLE_QUOTES ; 

country: COUNTRY EQUALS DOUBLE_QUOTES stringLettersMixedCase DOUBLE_QUOTES; 

state: STATE EQUALS DOUBLE_QUOTES stringLettersMixedCase DOUBLE_QUOTES; 

city: CITY EQUALS DOUBLE_QUOTES stringLettersMixedCase DOUBLE_QUOTES; 

name: NAME EQUALS DOUBLE_QUOTES stringLettersMixedCase DOUBLE_QUOTES; 

latitude: LAT EQUALS DOUBLE_QUOTES floatingPointValue DOUBLE_QUOTES ;

longitude: LON EQUALS DOUBLE_QUOTES floatingPointValue DOUBLE_QUOTES; 

altitude: ALT EQUALS DOUBLE_QUOTES floatingPointValue (Meters | Feet)? DOUBLE_QUOTES;

magvar:  MAGVAR EQUALS DOUBLE_QUOTES floatingPointValue DOUBLE_QUOTES ;

ident: IDENT EQUALS DOUBLE_QUOTES stringLettersUpperCase DOUBLE_QUOTES ; 

airportTestRadius: AIRPORTTESTRADIUS EQUALS DOUBLE_QUOTES IntegerValue (Meters | Feet | NauticalMiles) DOUBLE_QUOTES ; 

trafficScalar: TRAFFICSCALAR EQUALS DOUBLE_QUOTES floatingPointValue DOUBLE_QUOTES ; 





/////////////////////////////////////////////////////////////////////

type: TYPE EQUALS DOUBLE_QUOTES stringLettersNumbers DOUBLE_QUOTES;

heading: HEADING EQUALS DOUBLE_QUOTES floatingPointValue DOUBLE_QUOTES; 

length: LENGTH EQUALS DOUBLE_QUOTES floatingPointValue (Meters | Feet)? DOUBLE_QUOTES;

width: WIDTH EQUALS DOUBLE_QUOTES floatingPointValue (Meters | Feet)? DOUBLE_QUOTES;

designator: DESIGNATOR EQUALS DOUBLE_QUOTES DESIGNATORVALUES DOUBLE_QUOTES; 

primaryDesignator: PRIMARYDESIGNATOR EQUALS DOUBLE_QUOTES DESIGNATORVALUES DOUBLE_QUOTES; 

secondaryDesignator: SECONDARYDESIGNATOR EQUALS DOUBLE_QUOTES DESIGNATORVALUES DOUBLE_QUOTES; 

patternAltitude: PATTERNALTITUDE EQUALS DOUBLE_QUOTES floatingPointValue (Meters | Feet)? DOUBLE_QUOTES; 

primaryTakeoff : PRIMARYTAKEOFF EQUALS DOUBLE_QUOTES YES_NO_BOOLEAN DOUBLE_QUOTES;

primaryLanding : PRIMARYLANDING EQUALS DOUBLE_QUOTES BOOLEAN DOUBLE_QUOTES;

primaryPattern : PRIMARYPATTERN EQUALS DOUBLE_QUOTES LEFT_RIGHT DOUBLE_QUOTES;

secondaryTakeoff : SECONDARYTAKEOFF EQUALS DOUBLE_QUOTES BOOLEAN DOUBLE_QUOTES;

secondaryLanding : SECONDARYLANDING EQUALS DOUBLE_QUOTES BOOLEAN DOUBLE_QUOTES;

secondaryPattern : SECONDARYPATTERN EQUALS DOUBLE_QUOTES LEFT_RIGHT DOUBLE_QUOTES;

primaryMarkingBias: PRIMARYMARKINGBIAS EQUALS DOUBLE_QUOTES floatingPointValue (Meters | Feet |NauticalMiles) DOUBLE_QUOTES;

secondaryMarkingBias: SECONDARYMARKINGBIAS EQUALS DOUBLE_QUOTES floatingPointValue (Meters | Feet|NauticalMiles) DOUBLE_QUOTES;
//////////////////////////////////////////////////////////////////////

edges: EDGES EQUALS DOUBLE_QUOTES BOOLEAN DOUBLE_QUOTES;
threshold: THRESHOLD EQUALS DOUBLE_QUOTES BOOLEAN DOUBLE_QUOTES;
fixedDistance: FIXEDDISTANCE EQUALS DOUBLE_QUOTES BOOLEAN DOUBLE_QUOTES;
touchdown: TOUCHDOWN EQUALS DOUBLE_QUOTES BOOLEAN DOUBLE_QUOTES;
dashes: DASHES EQUALS DOUBLE_QUOTES BOOLEAN DOUBLE_QUOTES;
identMarkings: IDENT EQUALS DOUBLE_QUOTES BOOLEAN DOUBLE_QUOTES;
precision: PRECISION EQUALS DOUBLE_QUOTES BOOLEAN DOUBLE_QUOTES;
edgePavement: EDGEPAVEMENT EQUALS DOUBLE_QUOTES BOOLEAN DOUBLE_QUOTES;
singleEnd: SINGLEEND EQUALS DOUBLE_QUOTES BOOLEAN DOUBLE_QUOTES;
primaryClosed: PRIMARYCLOSED EQUALS DOUBLE_QUOTES BOOLEAN DOUBLE_QUOTES;
secondaryClosed: SECONDARYCLOSED EQUALS DOUBLE_QUOTES BOOLEAN DOUBLE_QUOTES;
primaryStol: PRIMARYSTOL EQUALS DOUBLE_QUOTES BOOLEAN DOUBLE_QUOTES;
secondaryStol: SECONDARYSTOL EQUALS DOUBLE_QUOTES BOOLEAN DOUBLE_QUOTES;



//////////////////////////////////////////////////////////////////////
surface: SURFACE EQUALS DOUBLE_QUOTES SURFACERUNWAY DOUBLE_QUOTES;
number: NUMBER EQUALS DOUBLE_QUOTES NUMBERRUNWAY DOUBLE_QUOTES;

yes_no: YES_NO ;
bool: BOOLEAN ;


/////////////////////////////////////////////////////////////////////

floatingPointValue: FloatingPointValue | IntegerValue ;

stringLettersMixedCase: STRING_LETTERS_LOWERCASE | STRING_LETTERS_UPPERCASE | STRING_LETTERS ;

stringLettersLowerCase: STRING_LETTERS_LOWERCASE ;

stringLettersUpperCase: STRING_LETTERS_UPPERCASE ;

stringLettersNumbers: STRING_LETTERS_LOWERCASE | STRING_LETTERS_UPPERCASE | STRING_LETTERS | STRING_LETTERS_NUMBERS | IntegerValue;
/////////////////////////////////////////////////////////////////////

airportElements: services* deleteAirport* tower* runway* start* com* ;

	services: OpenServices servicesElements EndServices;

		servicesElements: fuel*;

			fuel: OpenFuel fuelAttributes SLASH_CLOSE ;

				fuelAttributes: typefuel availabilityFuel ;
			
					typefuel: TYPE EQUALS DOUBLE_QUOTES TYPESFUEL DOUBLE_QUOTES;

					availabilityFuel: AVAILABILITY EQUALS DOUBLE_QUOTES AVAILABILITYFUEL DOUBLE_QUOTES ;
	
	deleteAirport: OpenDeleteAirport deleteairportatributes* SLASH_CLOSE;
	
		deleteairportatributes: DELETEAIRPORTATRIBUTES EQUALS DOUBLE_QUOTES BOOLEAN DOUBLE_QUOTES;

	tower: OpenTower towerAttributes ( SLASH_CLOSE | (CLOSE EndTower) );

		towerAttributes: latitude longitude altitude  ;

	runway: OpenRunway runwayAttributes CLOSE runwayElements EndRunway;

		runwayAttributes:  latitude longitude altitude surface heading			/*heading devia ser de 0 a 360?*/
							length width number designator? primaryDesignator?
							secondaryDesignator? patternAltitude? primaryTakeoff?
							primaryLanding? primaryPattern? secondaryTakeoff? secondaryLanding? secondaryPattern?
							primaryMarkingBias? secondaryMarkingBias?; 

		runwayElements: markings;
		
				markings: OpenMarkings markingAttributes SLASH_CLOSE;

				markingAttributes:edges threshold fixedDistance touchdown dashes
				identMarkings precision edgePavement singleEnd primaryClosed
				secondaryClosed primaryStol secondaryStol;

	start: OpenStart startAttributes SLASH_CLOSE;

		startAttributes: type latitude longitude altitude heading designator ;

	com: OpenCom comAttributes SLASH_CLOSE;

		comAttributes: frequencyCom type nameCom ;

			frequencyCom: FREQUENCY EQUALS DOUBLE_QUOTES floatingPointValue DOUBLE_QUOTES ;

			nameCom: NAME EQUALS DOUBLE_QUOTES STRING_LETTERS DOUBLE_QUOTES ;
