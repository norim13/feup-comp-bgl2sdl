parser grammar XMLParser;

options { tokenVocab=XMLLexer; }

document    :  airport;

/////////////////////////////////////////////////////////////////////
///////////////////////// SOME COMMON ATTRIBUTES ////////////////////
/////////////////////////////////////////////////////////////////////

type: TYPE EQUALS DOUBLE_QUOTES stringLettersNumbers DOUBLE_QUOTES;
heading: HEADING floatingPointValue DOUBLE_QUOTES; 
length: LENGTH floatingPointValue units_meters_feet?/*(Meters | Feet)?*/ DOUBLE_QUOTES;
width: WIDTH floatingPointValue units_meters_feet?/*(Meters | Feet)?*/ DOUBLE_QUOTES;
designator: DESIGNATOR DESIGNATORVALUES DOUBLE_QUOTES; 


surface: SURFACE SURFACETYPES DOUBLE_QUOTES;
number: NUMBER NUMBER_VALUES DOUBLE_QUOTES;/*0-36*/
frequency:FREQUENCY floatingPointValue DOUBLE_QUOTES;
biasX: BIASX floatingPointValue units_all? DOUBLE_QUOTES;
biasY: BIASY floatingPointValue units_all? DOUBLE_QUOTES;
biasZ: BIASZ floatingPointValue units_all? DOUBLE_QUOTES;

/////////////////////////////////////////////////////////////////////
//////////////////////////// SOME DATA TYPES ////////////////////////
/////////////////////////////////////////////////////////////////////
yes_no: YES_NO ;
bool: BOOLEAN ;
yes_no_bool: YES_NO | BOOLEAN;

units_all: SINGLE_LETTER_UPPER {
						if (!$SINGLE_LETTER_UPPER.text.equals("M") 
							&& !$SINGLE_LETTER_UPPER.text.equals("F")
							&& !$SINGLE_LETTER_UPPER.text.equals("N")){
							System.out.println("1");
							notifyErrorListeners( "Invalid units... Use only M, F or N." );
            			}
					};
units_meters: SINGLE_LETTER_UPPER {
						if (!$SINGLE_LETTER_UPPER.text.equals("M")){
							System.out.println("2");
							notifyErrorListeners( "Invalid units... Use only M." );
            			}
					};
units_meters_feet: SINGLE_LETTER_UPPER {
						if (!$SINGLE_LETTER_UPPER.text.equals("M") 
							&& !$SINGLE_LETTER_UPPER.text.equals("F")){
							System.out.println("3");
							notifyErrorListeners( "Invalid units... Use only M or F." );
            			}
					};					


/////////////////////////////////////////////////////////////////////

unsignedIntegerValue: UnsignedIntegerValue;

integerValue: IntegerValue | UnsignedIntegerValue;

unsignedFloatValue: UnsignedFloatValue | UnsignedIntegerValue;

floatingPointValue: FloatingPointValue | UnsignedFloatValue | IntegerValue | UnsignedIntegerValue ;

/////////////////////////////////////////////////////////////////////

stringLettersMixedCase: STRING_LETTERS_LOWERCASE | STRING_LETTERS_UPPERCASE | STRING_LETTERS | SINGLE_LETTER_UPPER;

stringLettersUpperCase: STRING_LETTERS_UPPERCASE | SINGLE_LETTER_UPPER;

stringLettersNumbers: STRING_LETTERS_LOWERCASE | STRING_LETTERS_UPPERCASE | STRING_LETTERS 
 		| STRING_LETTERS_NUMBERS | INT_NUMBER | SINGLE_LETTER_UPPER;


/////////////////////////////////////////////////////////////////////
//////////////////////////// ELEMENTS IN XML ////////////////////////
/////////////////////////////////////////////////////////////////////


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

		latitude: LAT floatingPointValue DOUBLE_QUOTES ;

		longitude: LON floatingPointValue DOUBLE_QUOTES; 

		altitude: ALT floatingPointValue units_meters_feet?/*(Meters | Feet)?*/ DOUBLE_QUOTES;

		magvar:  MAGVAR floatingPointValue DOUBLE_QUOTES ;

		ident: IDENT EQUALS DOUBLE_QUOTES stringLettersUpperCase DOUBLE_QUOTES ; 

		airportTestRadius: AIRPORTTESTRADIUS integerValue units_all /*(Meters | Feet |NauticalMiles)*/ DOUBLE_QUOTES ; 

		trafficScalar: TRAFFICSCALAR floatingPointValue DOUBLE_QUOTES ; 


////////////////////////////////////////////////////////////////

	airportElements: services* deleteAirport* deletes tower* runway* start* com* taxiwayPoint* taxiwayParking* taxiName* taxiwayPath*;

		services: OpenServices servicesElements EndServices;

			servicesElements: fuel*;

				fuel: OpenFuel fuelAttributes SLASH_CLOSE ;

					fuelAttributes: /*typefuel*/type availabilityFuel ;
				
						/*typefuel: TYPE EQUALS DOUBLE_QUOTES TYPESFUEL_WORDS DOUBLE_QUOTES;*/

						availabilityFuel: AVAILABILITY AVAILABILITY_WORDS DOUBLE_QUOTES ;
	
	
	
	deletes:	deleteAirport* deleteRunway* deleteStart* deleteFrequency*;
	
	deleteAirport: OpenDeleteAirport deleteAirportAttributes* SLASH_CLOSE;
	
		deleteAirportAttributes: DELETEAIRPORTATRIBUTES EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;

	deleteRunway: OpenDeleteRunway deleteRunwayAttributes SLASH_CLOSE;
	
		deleteRunwayAttributes: surface number designator;
		
	deleteStart: OpenDeleteStart deleteStartAttributes SLASH_CLOSE;
		
		deleteStartAttributes: /*typeDeleteStart*/type number designator?;

			/*typeDeleteStart: TYPE EQUALS DOUBLE_QUOTES TYPEDELETESTART DOUBLE_QUOTES;*/
	
	deleteFrequency: OpenDeleteFrequency deleteFrequencyAttributes SLASH_CLOSE;
		
		deleteFrequencyAttributes: frequency /*typeDeleteFrequency*/type;
		
			/*typeDeleteFrequency: TYPE EQUALS DOUBLE_QUOTES TYPEDELETEFREQUENCY DOUBLE_QUOTES;*/
		
		
	
	tower: OpenTower towerAttributes ( SLASH_CLOSE | (CLOSE EndTower) );

		towerAttributes: latitude longitude altitude  ;

	runway: OpenRunway runwayAttributes CLOSE runwayElements EndRunway;

		runwayAttributes:  latitude longitude altitude surface heading	/*heading -> 0 a 360?*/
							length width number designator? primaryDesignator?
							secondaryDesignator? patternAltitude? primaryTakeoff?
							primaryLanding? primaryPattern? secondaryTakeoff? secondaryLanding? secondaryPattern?
							primaryMarkingBias? secondaryMarkingBias?; 

			primaryDesignator: PRIMARYDESIGNATOR DESIGNATORVALUES DOUBLE_QUOTES; 

			secondaryDesignator: SECONDARYDESIGNATOR DESIGNATORVALUES DOUBLE_QUOTES; 

			patternAltitude: PATTERNALTITUDE floatingPointValue units_meters_feet?/*M | F */ DOUBLE_QUOTES; 

			primaryTakeoff : PRIMARYTAKEOFF EQUALS DOUBLE_QUOTES yes_no_bool DOUBLE_QUOTES;

			primaryLanding : PRIMARYLANDING EQUALS DOUBLE_QUOTES yes_no_bool DOUBLE_QUOTES;

			primaryPattern : PRIMARYPATTERN LEFT_RIGHT DOUBLE_QUOTES;

			secondaryTakeoff : SECONDARYTAKEOFF EQUALS DOUBLE_QUOTES yes_no_bool DOUBLE_QUOTES;

			secondaryLanding : SECONDARYLANDING EQUALS DOUBLE_QUOTES yes_no_bool DOUBLE_QUOTES;

			secondaryPattern : SECONDARYPATTERN LEFT_RIGHT DOUBLE_QUOTES;

			primaryMarkingBias: PRIMARYMARKINGBIAS floatingPointValue units_all /*(Meters | Feet |NauticalMiles)*/ DOUBLE_QUOTES;

			secondaryMarkingBias: SECONDARYMARKINGBIAS floatingPointValue units_all /*(Meters | Feet |NauticalMiles)*/ DOUBLE_QUOTES;

			
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

						center: CENTER LEVELS DOUBLE_QUOTES ;
						edge: EDGE LEVELS DOUBLE_QUOTES;
						centerRed: CENTER_RED EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;


				offsetThreshold: OpenOffsetThreshold offsetThresholdAttributes SLASH_CLOSE;

					offsetThresholdAttributes: end length width? surface?;

						end: END PRIORITY DOUBLE_QUOTES;


				blastPad: OpenBlastPad blastPadAttributes SLASH_CLOSE;

					blastPadAttributes: end length width? surface?;


				overrun: OpenOverrun overrunAttributes SLASH_CLOSE;

					overrunAttributes: end length width? surface?;


				approachLights: OpenApproachLights approachLightsAttributes SLASH_CLOSE;

					approachLightsAttributes: end system? strobes? reil? touchdown? endLights?;

						system: SYSTEM SYSTEM_OPTIONS DOUBLE_QUOTES;
						strobes: STROBES unsignedIntegerValue DOUBLE_QUOTES;
						reil: REIL EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						endLights: ENDLIGHTS EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES; 


				vasi: OpenVasi vasiAttributes SLASH_CLOSE;

					vasiAttributes: end type side biasX biasZ spacing pitch;

						side: SIDE LEFT_RIGHT DOUBLE_QUOTES;
						spacing: SPACING unsignedFloatValue units_all? DOUBLE_QUOTES;
						pitch: PITCH floatingPointValue DOUBLE_QUOTES;/*0.0-9.9*/


				ils: OpenIls ilsAttributes ilsElements CLOSE CloseIls;

					ilsAttributes: latitude longitude altitude heading frequency end range magvar ident width? name? backCourse?; 
					
						range: RANGE unsignedFloatValue DOUBLE_QUOTES;

						backCourse: BACKCOURSE EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;

					ilsElements: ; 






  /* -----------------------------------------------------------*/
		


	start: OpenStart startAttributes SLASH_CLOSE;

		startAttributes: type? latitude longitude altitude heading number? designator? ;

	com: OpenCom comAttributes SLASH_CLOSE;

		comAttributes: frequency type /*nameCom*/name ;

			/*nameCom: NAME EQUALS DOUBLE_QUOTES stringLettersMixedCase DOUBLE_QUOTES ;*/


////////////////////////////////////////////////////////////////////////////////////////////////
/* -------------------TAXIWAYPOINT -----------------------------------------------------------------*/
	taxiwayPoint: OpenTaxiwayPoint taxiwayPointAttributes SLASH_CLOSE; 

		taxiwayPointAttributes: taxiway_index /*taxiwaypoint_type*/type taxiway_orientation? (latitude longitude | biasX biasY);

			taxiway_index: INDEX unsignedIntegerValue DOUBLE_QUOTES; /*0-3999*/
			/*taxiwaypoint_type: TYPE EQUALS DOUBLE_QUOTES TAXIWAYPOINTTYPE DOUBLE_QUOTES; */
			taxiway_orientation: ORIENTATION ORIENTATIONTYPE DOUBLE_QUOTES; 

	/*-------------------------------TaxiwayParking-----------------------------------------------------*/
	taxiwayParking: OpenTaxiwayParking taxiwayParkingAttributes SLASH_CLOSE; 

		taxiwayParkingAttributes: taxiway_index ( (latitude longitude) | (biasX biasY) ) heading taxiway_radius /*taxiwayparking_type*/type taxiwayparking_name taxiway_number taxiway_airlineCodes? taxiway_pushBack taxiway_teeOffset*;

			//index: INDEX EQUALS INDEXVALUE; 
			/*taxiway_heading: HEADING floatingPointValue DOUBLE_QUOTES;*/ /*0.0-360.0*/
			taxiway_radius: RADIUS floatingPointValue units_all? DOUBLE_QUOTES;
			/*taxiwayparking_type: TYPE EQUALS DOUBLE_QUOTES TAXIWAYPARKINGTYPE DOUBLE_QUOTES;*/
			taxiwayparking_name: NAME EQUALS DOUBLE_QUOTES /*NAMETAXIWAYPARKING*/stringLettersUpperCase DOUBLE_QUOTES;
			taxiway_number: NUMBER NUMBER_VALUES DOUBLE_QUOTES;/*0-3999*/
			taxiway_airlineCodes: AIRLINECODES AIRLINECODESVALUES DOUBLE_QUOTES;
			taxiway_pushBack: PUSHBACK PUSHBACKVALUES DOUBLE_QUOTES;
			taxiway_teeOffset: TEEOFFSET floatingPointValue DOUBLE_QUOTES;/*0.1-50.0*/

	/*--------------------------------------TAXINAME-------------------------------*/
	taxiName: OpenTaxiName taxiNameAttributes SLASH_CLOSE;

		taxiNameAttributes: taxiNameIndex taxiNameName;

			taxiNameIndex: INDEX unsignedIntegerValue DOUBLE_QUOTES;/*0-255*/
			taxiNameName: NAME EQUALS DOUBLE_QUOTES stringLettersNumbers? DOUBLE_QUOTES;

	/*-----------------------------------------------------TAXIWAYPATH-----------------------------------------*/
	taxiwayPath: OpenTaxiwayPath taxiwayPathAttributes* SLASH_CLOSE;

		taxiwayPathAttributes: type | taxiway_start | taxiway_end | width | taxiway_weightLimit | surface | taxiway_drawSurface 
							| taxiway_drawDetail | taxiway_centerLine | taxiway_centerLineLighted | taxiway_leftEdge | taxiway_leftEdgeLighted 
							| taxiway_rightEdge | taxiway_rightEdgeLighted | taxiway_number | designator | taxiway_name;

			/*taxiwaypath_type: TYPE EQUALS DOUBLE_QUOTES TAXIWAYPATHTYPE DOUBLE_QUOTES;*/
			
			taxiway_start: START integerValue DOUBLE_QUOTES; /*0-3999*/
			
			taxiway_end: END INT_NUMBER2 DOUBLE_QUOTES; /*0-3999*/
			
			/*taxiway_width: WIDTH EQUALS DOUBLE_QUOTES floatingPointValue DOUBLE_QUOTES;*/
			
			taxiway_weightLimit: WEIGHTLIMIT floatingPointValue DOUBLE_QUOTES;
			
			taxiway_drawSurface: DRAWSURFACE EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
			
			taxiway_drawDetail: DRAWDETAIL EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
			
			taxiway_centerLine: CENTERLINE EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
			
			taxiway_centerLineLighted: CENTERLINELIGHTED EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
			
			taxiway_leftEdge: LEFTEDGE EDGETYPE DOUBLE_QUOTES;
			
			taxiway_leftEdgeLighted: LEFTEDGELIGHTED EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
			
			taxiway_rightEdge: RIGHTEDGE EDGETYPE DOUBLE_QUOTES;
			
			taxiway_rightEdgeLighted: RIGHTEDGELIGHTED EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
			
			taxiway_name: NAME EQUALS DOUBLE_QUOTES INT_NUMBER DOUBLE_QUOTES;
			

