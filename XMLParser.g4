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

airportTestRadius: AIRPORTTESTRADIUS EQUALS DOUBLE_QUOTES integerValue (Meters | Feet | NauticalMiles) DOUBLE_QUOTES ; 

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

primaryTakeoff : PRIMARYTAKEOFF EQUALS DOUBLE_QUOTES yes_no_bool DOUBLE_QUOTES;

primaryLanding : PRIMARYLANDING EQUALS DOUBLE_QUOTES yes_no_bool DOUBLE_QUOTES;

primaryPattern : PRIMARYPATTERN EQUALS DOUBLE_QUOTES LEFT_RIGHT DOUBLE_QUOTES;

secondaryTakeoff : SECONDARYTAKEOFF EQUALS DOUBLE_QUOTES yes_no_bool DOUBLE_QUOTES;

secondaryLanding : SECONDARYLANDING EQUALS DOUBLE_QUOTES yes_no_bool DOUBLE_QUOTES;

secondaryPattern : SECONDARYPATTERN EQUALS DOUBLE_QUOTES LEFT_RIGHT DOUBLE_QUOTES;

primaryMarkingBias: PRIMARYMARKINGBIAS EQUALS DOUBLE_QUOTES floatingPointValue (Meters | Feet |NauticalMiles) DOUBLE_QUOTES;

secondaryMarkingBias: SECONDARYMARKINGBIAS EQUALS DOUBLE_QUOTES floatingPointValue (Meters | Feet|NauticalMiles) DOUBLE_QUOTES;
//////////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////

typeDeleteStart: TYPE EQUALS DOUBLE_QUOTES TYPEDELETESTART DOUBLE_QUOTES;

//////////////////////////////////////////////////////////////////////

frequency:FREQUENCY EQUALS DOUBLE_QUOTES floatingPointValue DOUBLE_QUOTES;/*108.0-136.992*/

typeDeleteFrequency: TYPE EQUALS DOUBLE_QUOTES TYPEDELETEFREQUENCY DOUBLE_QUOTES;

//////////////////////////////////////////////////////////////////////
surface: SURFACE EQUALS DOUBLE_QUOTES SURFACETYPES DOUBLE_QUOTES;
number: NUMBER EQUALS DOUBLE_QUOTES (NUMBERRUNWAY | unsignedIntegerValue) DOUBLE_QUOTES;/*0-36*/
biasX: BIASX EQUALS DOUBLE_QUOTES floatingPointValue DOUBLE_QUOTES;
biasY: BIASY EQUALS DOUBLE_QUOTES floatingPointValue DOUBLE_QUOTES;
biasZ: BIASZ EQUALS DOUBLE_QUOTES floatingPointValue DOUBLE_QUOTES;

yes_no: YES_NO ;
bool: BOOLEAN ;
yes_no_bool: YES_NO | BOOLEAN;


/////////////////////////////////////////////////////////////////////


unsignedIntegerValue: UnsignedIntegerValue;

integerValue: IntegerValue | UnsignedIntegerValue;

unsignedFloatValue: UnsignedFloatValue | UnsignedIntegerValue;

floatingPointValue: FloatingPointValue | UnsignedFloatValue | IntegerValue | UnsignedIntegerValue ;


/////////////////////////////////////////////////////////////////////

stringLettersMixedCase: STRING_LETTERS_LOWERCASE | STRING_LETTERS_UPPERCASE | STRING_LETTERS ;

stringLettersLowerCase: STRING_LETTERS_LOWERCASE ;

stringLettersUpperCase: STRING_LETTERS_UPPERCASE ;

stringLettersNumbers: STRING_LETTERS_LOWERCASE | STRING_LETTERS_UPPERCASE | STRING_LETTERS | STRING_LETTERS_NUMBERS | IntegerValue;
/////////////////////////////////////////////////////////////////////

airportElements: services* deleteAirport* deletes tower* runway* start* com* taxiwayPoint* taxiwayParking* taxiName* taxiwayPath*;

	services: OpenServices servicesElements EndServices;

		servicesElements: fuel*;

			fuel: OpenFuel fuelAttributes SLASH_CLOSE ;

				fuelAttributes: typefuel availabilityFuel ;
			
					typefuel: TYPE EQUALS DOUBLE_QUOTES TYPESFUEL DOUBLE_QUOTES;

					availabilityFuel: AVAILABILITY EQUALS DOUBLE_QUOTES (AVAILABILITYFUEL | YES_NO) DOUBLE_QUOTES ;
	
	
	
	deletes:	deleteAirport* deleteRunway* deleteStart* deleteFrequency;
	
	deleteAirport: OpenDeleteAirport deleteAirportAttributes* SLASH_CLOSE;
	
		deleteAirportAttributes: DELETEAIRPORTATRIBUTES EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;

	deleteRunway: OpenDeleteRunway deleteRunwayAttributes SLASH_CLOSE;
	
		deleteRunwayAttributes: surface number designator;
		
	deleteStart: OpenDeleteStart deleteStartAttributes SLASH_CLOSE;
		
		deleteStartAttributes: typeDeleteStart number designator?;
	
	deleteFrequency: OpenDeleteFrequency deleteFrequencyAttributes SLASH_CLOSE;
		
		deleteFrequencyAttributes: frequency typeDeleteFrequency;
		
		
		
	
	tower: OpenTower towerAttributes ( SLASH_CLOSE | (CLOSE EndTower) );

		towerAttributes: latitude longitude altitude  ;

	runway: OpenRunway runwayAttributes CLOSE runwayElements EndRunway;

		runwayAttributes:  latitude longitude altitude surface heading			/*heading devia ser de 0 a 360?*/
							length width number designator? primaryDesignator?
							secondaryDesignator? patternAltitude? primaryTakeoff?
							primaryLanding? primaryPattern? secondaryTakeoff? secondaryLanding? secondaryPattern?
							primaryMarkingBias? secondaryMarkingBias?; 

			runwayElements: markings* lights* offsetThreshold* blastPad* overrun* approachLights* vasi* ils*;

				markings: OpenMarkings markingAttributes SLASH_CLOSE;

					markingAttributes:edges threshold fixedDistance touchdown dashes
						identMarkings precision edgePavement singleEnd primaryClosed		
						secondaryClosed primaryStol secondaryStol;

						edges: EDGES EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						threshold: THRESHOLD EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						fixedDistance: FIXEDDISTANCE EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						touchdown: TOUCHDOWN EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						dashes: DASHES EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						identMarkings: IDENT EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						precision: PRECISION EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						edgePavement: EDGEPAVEMENT EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						singleEnd: SINGLEEND EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						primaryClosed: PRIMARYCLOSED EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						secondaryClosed: SECONDARYCLOSED EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						primaryStol: PRIMARYSTOL EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						secondaryStol: SECONDARYSTOL EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;

				lights: OpenLight lightAttributes SLASH_CLOSE;

					lightAttributes: center edge centerRed;

						center: CENTER EQUALS DOUBLE_QUOTES LEVELS DOUBLE_QUOTES ;
						edge: EDGE EQUALS DOUBLE_QUOTES LEVELS DOUBLE_QUOTES;
						centerRed: CENTER_RED EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;


				offsetThreshold: OpenOffsetThreshold offsetThresholdAttributes SLASH_CLOSE;

					offsetThresholdAttributes: end length width? surface?;

						end: END EQUALS DOUBLE_QUOTES PRIORITY DOUBLE_QUOTES;


				blastPad: OpenBlastPad blastPadAttributes SLASH_CLOSE;

					blastPadAttributes: end length width? surface?;


				overrun: OpenOverrun overrunAttributes SLASH_CLOSE;

					overrunAttributes: end length width? surface?;


				approachLights: OpenApproachLights approachLightsAttributes SLASH_CLOSE;

					approachLightsAttributes: end system? strobes? reil? touchdown? endLights?;

						system: SYSTEM EQUALS DOUBLE_QUOTES SYSTEM_OPTIONS DOUBLE_QUOTES;
						strobes: STROBES EQUALS DOUBLE_QUOTES unsignedIntegerValue DOUBLE_QUOTES;
						reil: REIL EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						endLights: ENDLIGHTS EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES; 


				vasi: OpenVasi vasiAttributes SLASH_CLOSE;

					vasiAttributes: end type side biasX biasZ spacing pitch;

						side: SIDE EQUALS DOUBLE_QUOTES LEFT_RIGHT DOUBLE_QUOTES;
						spacing: SPACING EQUALS DOUBLE_QUOTES unsignedFloatValue DOUBLE_QUOTES;
						pitch: PITCH EQUALS DOUBLE_QUOTES floatingPointValue DOUBLE_QUOTES;/*0.0-9.9*/


				ils: OpenIls ilsAttributes ilsElements CLOSE CloseIls;

					ilsAttributes: latitude longitude altitude heading frequency end range magvar ident width? name? backCourse?; 
					
						range: RANGE EQUALS DOUBLE_QUOTES unsignedFloatValue DOUBLE_QUOTES;

						backCourse: BACKCOURSE EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;

					ilsElements: ; 






  /* -----------------------------------------------------------*/
		


	start: OpenStart startAttributes SLASH_CLOSE;

		startAttributes: type latitude longitude altitude heading designator ;

	com: OpenCom comAttributes SLASH_CLOSE;

		comAttributes: frequencyCom type nameCom ;

			frequencyCom: FREQUENCY EQUALS DOUBLE_QUOTES floatingPointValue DOUBLE_QUOTES ;

			nameCom: NAME EQUALS DOUBLE_QUOTES STRING_LETTERS DOUBLE_QUOTES ;


////////////////////////////////////////////////////////////////////////////////////////////////
/* -------------------TAXIWAYPOINT -----------------------------------------------------------------*/
	taxiwayPoint: OpenTaxiwayPoint taxiwayPointAttributes SLASH_CLOSE; 

		taxiwayPointAttributes: taxiway_index taxiwaypoint_type taxiway_orientation? (latitude longitude | biasX biasY);

			taxiway_index: INDEX EQUALS DOUBLE_QUOTES unsignedIntegerValue DOUBLE_QUOTES; /*0-3999*/
			taxiwaypoint_type: TYPE EQUALS DOUBLE_QUOTES TAXIWAYPOINTTYPE DOUBLE_QUOTES; 
			taxiway_orientation: ORIENTATION EQUALS DOUBLE_QUOTES ORIENTATIONTYPE DOUBLE_QUOTES; 

	/*-------------------------------TaxiwayParking-----------------------------------------------------*/
	taxiwayParking: OpenTaxiwayParking taxiwayParkingAttributes SLASH_CLOSE; 

		taxiwayParkingAttributes: taxiway_index ( (latitude longitude) | (biasX biasY) ) taxiway_heading taxiway_radius taxiwayparking_type taxiwayparking_name taxiway_number taxiway_airlineCodes? taxiway_pushBack taxiway_teeOffset*;

			//index: INDEX EQUALS INDEXVALUE; 
			taxiwayparking_orientation: ORIENTATION EQUALS DOUBLE_QUOTES ORIENTATIONTYPE DOUBLE_QUOTES; 
			taxiway_heading: HEADING EQUALS DOUBLE_QUOTES floatingPointValue DOUBLE_QUOTES;/*0.0-360.0*/
			taxiway_radius: RADIUS EQUALS DOUBLE_QUOTES floatingPointValue DOUBLE_QUOTES;
			taxiwayparking_type: TYPE EQUALS DOUBLE_QUOTES TAXIWAYPARKINGTYPE DOUBLE_QUOTES;
			taxiwayparking_name: NAME EQUALS DOUBLE_QUOTES NAMETAXIWAYPARKING DOUBLE_QUOTES;
			taxiway_number: NUMBER EQUALS DOUBLE_QUOTES unsignedIntegerValue DOUBLE_QUOTES;/*0-3999*/
			taxiway_airlineCodes: AIRLINECODES EQUALS DOUBLE_QUOTES AIRLINECODESVALUES DOUBLE_QUOTES;
			taxiway_pushBack: PUSHBACK EQUALS DOUBLE_QUOTES PUSHBACKVALUES DOUBLE_QUOTES;
			taxiway_teeOffset: TEEOFFSET EQUALS DOUBLE_QUOTES floatingPointValue DOUBLE_QUOTES;/*0.1-50.0*/

	/*--------------------------------------TAXINAME-------------------------------*/
	taxiName: OpenTaxiName taxiNameAttributes SLASH_CLOSE;

		taxiNameAttributes: taxiNameIndex taxiNameName;

			taxiNameIndex: INDEX EQUALS DOUBLE_QUOTES unsignedIntegerValue DOUBLE_QUOTES;/*0-255*/
			taxiNameName: NAME EQUALS DOUBLE_QUOTES TAXINAME DOUBLE_QUOTES;

	/*-----------------------------------------------------TAXIWAYPATH-----------------------------------------*/
	taxiwayPath: OpenTaxiwayPath taxiwayPathAttributes SLASH_CLOSE;

		taxiwayPathAttributes: taxiwaypath_type taxiway_start taxiway_end taxiway_width taxiway_weightLimit surface taxiway_drawSurface 
							taxiway_drawDetail taxiway_centerLine? taxiway_centerLineLighted? taxiway_leftEdge? taxiway_leftEdgeLighted? 
							taxiway_rightEdge? taxiway_rightEdgeLighted? taxiway_number? taxiway_designator? taxiway_name?;

			taxiwaypath_type: TYPE EQUALS DOUBLE_QUOTES TAXIWAYPATHTYPE DOUBLE_QUOTES;
			
			taxiway_start: START EQUALS DOUBLE_QUOTES NUMBER DOUBLE_QUOTES;
			
			taxiway_end: END EQUALS DOUBLE_QUOTES NUMBER DOUBLE_QUOTES;
			
			taxiway_width: WIDTH EQUALS DOUBLE_QUOTES floatingPointValue DOUBLE_QUOTES;
			
			taxiway_weightLimit: WEIGHTLIMIT EQUALS DOUBLE_QUOTES floatingPointValue DOUBLE_QUOTES;
			
			taxiway_drawSurface: DRAWSURFACE EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
			
			taxiway_drawDetail: DRAWDETAIL EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
			
			taxiway_centerLine: CENTERLINE EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
			
			taxiway_centerLineLighted: CENTERLINELIGHTED EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
			
			taxiway_leftEdge: LEFTEDGE EQUALS DOUBLE_QUOTES EDGETYPE DOUBLE_QUOTES;
			
			taxiway_leftEdgeLighted: LEFTEDGELIGHTED EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
			
			taxiway_rightEdge: RIGHTEDGE EQUALS DOUBLE_QUOTES EDGETYPE DOUBLE_QUOTES;
			
			taxiway_rightEdgeLighted: RIGHTEDGELIGHTED EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
			
			taxiway_designator: DESIGNATOR EQUALS DOUBLE_QUOTES DESIGNATORTYPES DOUBLE_QUOTES;
			
			taxiway_name: NAME EQUALS DOUBLE_QUOTES unsignedIntegerValue DOUBLE_QUOTES;/*0-255*

