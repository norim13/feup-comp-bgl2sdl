parser grammar XMLParser;

options { tokenVocab=XMLLexer; }

document    :  airport;

/////////////////////////////////////////////////////////////////////
///////////////////////// SOME COMMON ATTRIBUTES ////////////////////
/////////////////////////////////////////////////////////////////////

type: TYPE EQUALS DOUBLE_QUOTES stringLettersNumbers DOUBLE_QUOTES;

heading returns[float value]: HEADING floatingPointValue DOUBLE_QUOTES{
	if ($floatingPointValue.value < 0 || $floatingPointValue.value > 360){
		String err = "Invalid heading... Must be between 0 and 360... ";
		err = err + "input: " + $floatingPointValue.value;
		notifyErrorListeners( err );
		$value = -1;
	}
	else $value = $floatingPointValue.value;
		
} ;

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
							notifyErrorListeners( "Invalid units... Use only M, F or N." );
            			}
					};
units_meters: SINGLE_LETTER_UPPER {
						if (!$SINGLE_LETTER_UPPER.text.equals("M")){
							notifyErrorListeners( "Invalid units... Use only M." );
            			}
					};
units_meters_feet: SINGLE_LETTER_UPPER {
						if (!$SINGLE_LETTER_UPPER.text.equals("M") 
							&& !$SINGLE_LETTER_UPPER.text.equals("F")){
							notifyErrorListeners( "Invalid units... Use only M or F." );
            			}
					};					


/////////////////////////////////////////////////////////////////////

integerValue returns[int value]: IntegerValue {$value = Integer.parseInt($IntegerValue.text);};



floatingPointValue returns[float value]: FloatingPointValue {
												$value = Float.parseFloat($FloatingPointValue.text);
											};

/////////////////////////////////////////////////////////////////////

stringLettersMixedCase returns[String value]: 
	STRING_LETTERS_LOWERCASE {$value = $STRING_LETTERS_LOWERCASE.text;}| 
	STRING_LETTERS_UPPERCASE {$value = $STRING_LETTERS_UPPERCASE.text;}| 
	STRING_LETTERS {$value = $STRING_LETTERS.text;}| 
	SINGLE_LETTER_UPPER {$value = $SINGLE_LETTER_UPPER.text;};

stringLettersUpperCase returns[String value]: 
	STRING_LETTERS_UPPERCASE {$value = $STRING_LETTERS_UPPERCASE.text;} | 
	SINGLE_LETTER_UPPER {$value = $SINGLE_LETTER_UPPER.text;};

stringLettersNumbers returns[String value]:  
	STRING_LETTERS_LOWERCASE {$value = $STRING_LETTERS_LOWERCASE.text;}| 
	STRING_LETTERS_UPPERCASE {$value = $STRING_LETTERS_UPPERCASE.text;}| 
	STRING_LETTERS {$value = $STRING_LETTERS.text;}| 
	STRING_LETTERS_NUMBERS {$value = $STRING_LETTERS_NUMBERS.text;}| 
	INT_NUMBER {$value = $INT_NUMBER.text;}| 
	SINGLE_LETTER_UPPER {$value = $SINGLE_LETTER_UPPER.text;};


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

		region returns[String value]: REGION EQUALS DOUBLE_QUOTES stringLettersMixedCase DOUBLE_QUOTES{
			if ($stringLettersMixedCase.value.length() > 48){
				notifyErrorListeners("Region too long... Must have a maximum of 48 chars!");
				$value = "invalid_value";
			}
			else $value = $stringLettersMixedCase.value;
		} ; 

		country returns[String value]: COUNTRY EQUALS DOUBLE_QUOTES stringLettersMixedCase DOUBLE_QUOTES{
			if ($stringLettersMixedCase.value.length() > 48){
				notifyErrorListeners("Country too long... Must have a maximum of 48 chars!");
				$value = "invalid_value";
			}
			else $value = $stringLettersMixedCase.value;
		} ; 

		state returns[String value]: STATE EQUALS DOUBLE_QUOTES stringLettersMixedCase DOUBLE_QUOTES{
			if ($stringLettersMixedCase.value.length() > 48){
				notifyErrorListeners("State too long... Must have a maximum of 48 chars!");
				$value = "invalid_value";
			}
			else $value = $stringLettersMixedCase.value;
		} ;  

		city returns[String value]: CITY EQUALS DOUBLE_QUOTES stringLettersMixedCase DOUBLE_QUOTES{
			if ($stringLettersMixedCase.value.length() > 48){
				notifyErrorListeners("City too long... Must have a maximum of 48 chars!");
				$value = "invalid_value";
			}
			else $value = $stringLettersMixedCase.value;
		} ;  

		name returns[String value]: NAME EQUALS DOUBLE_QUOTES stringLettersMixedCase DOUBLE_QUOTES{
			if ($stringLettersMixedCase.value.length() > 48){
				notifyErrorListeners("Name too long... Must have a maximum of 48 chars!");
				$value = "invalid_value";
			}
			else $value = $stringLettersMixedCase.value;
		} ; 

		latitude returns[float lat]: LAT floatingPointValue DOUBLE_QUOTES 
						{
							if ($floatingPointValue.value < -90 || $floatingPointValue.value > 90){
								String err = "Invalid latitude... Must be between -90 and 90... ";
								err = err + "input: " + $floatingPointValue.value;
								notifyErrorListeners( err );
							}
							$lat = $floatingPointValue.value;
								
						};

		longitude returns[float lon]: LON floatingPointValue DOUBLE_QUOTES
				{
					if ($floatingPointValue.value < -180 || $floatingPointValue.value > 180){
						String err = "Invalid longitude... Must be between -180 and 180... ";
						err = err + "input: " + $floatingPointValue.value;
						notifyErrorListeners( err );
					}
					$lon = $floatingPointValue.value;
						
				};

		altitude: ALT floatingPointValue units_meters_feet?/*(Meters | Feet)?*/ DOUBLE_QUOTES;

		magvar returns[float value]:  MAGVAR floatingPointValue DOUBLE_QUOTES{
					if ($floatingPointValue.value < -360 || $floatingPointValue.value > 360){
						String err = "Invalid magvar... Must be between -360 and 360... ";
						err = err + "input: " + $floatingPointValue.value;
						notifyErrorListeners( err );
						$value = 0;
					}
					else $value = $floatingPointValue.value;
						
				};

		ident returns[String value]: IDENT EQUALS DOUBLE_QUOTES stringLettersUpperCase DOUBLE_QUOTES {
			if ($stringLettersUpperCase.value.length() > 4){
				notifyErrorListeners("Ident too long... Must have a maximum of 4 chars!");
				$value = "invalid_value";
			}
			else $value = $stringLettersUpperCase.value;
		} ;


		airportTestRadius: AIRPORTTESTRADIUS integerValue units_all /*(Meters | Feet |NauticalMiles)*/ DOUBLE_QUOTES ; 

		trafficScalar returns[float value]: TRAFFICSCALAR floatingPointValue DOUBLE_QUOTES{
					if ($floatingPointValue.value < 0.01 || $floatingPointValue.value > 1){
						String err = "Invalid trafficScalar... Must be between -0.01 and 1... ";
						err = err + "input: " + $floatingPointValue.value;
						notifyErrorListeners( err );
						$value = -1;
					}
					else $value = $floatingPointValue.value;
						
				};


////////////////////////////////////////////////////////////////

	airportElements: services* deleteAirport* deletes tower* runway* start* com* 
		taxiwayPoint* taxiwayParking* taxiName* taxiwayPath* jetway*
		aprons* apronEdgeLights* boundaryFence* blastFence* waypoint*;

		services: OpenServices servicesElements EndServices;

			servicesElements: fuel*;

				fuel: OpenFuel fuelAttributes* SLASH_CLOSE;

					fuelAttributes: typefuel /*type*/ | availabilityFuel;
				
						/*typefuel: TYPE EQUALS DOUBLE_QUOTES TYPESFUEL_WORDS DOUBLE_QUOTES;*/
						typefuel returns[String value]: TYPE EQUALS DOUBLE_QUOTES stringLettersNumbers DOUBLE_QUOTES{
							String[] types = {"73", "87", "100", "130", "145", "MOGAS", "JET", "JETA", "JETA1", "JETAP", "JETB", "JET4", "JET5", "UNKNOWN"};
							int i = 0;
							for (i = 0;  i < types.length; i++){
								if ($stringLettersNumbers.value.equals(types[i]))
									break;
							}
							if (i == types.length){
								notifyErrorListeners("Invalid fuel type... Input: "+$stringLettersNumbers.value);
								$value = "invalid_value";
							}
							else $value = $stringLettersNumbers.value;
						};

						availabilityFuel: AVAILABILITY AVAILABILITY_WORDS DOUBLE_QUOTES ;
	
	
	
	deletes: deleteAirport* deleteRunway* deleteStart* deleteFrequency*;
	
	deleteAirport: OpenDeleteAirport deleteAirportAttributes* SLASH_CLOSE;
	
		deleteAirportAttributes: DELETEAIRPORTATRIBUTES EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;

	deleteRunway: OpenDeleteRunway deleteRunwayAttributes* SLASH_CLOSE;
	
		deleteRunwayAttributes: surface | number | designator;
		
	deleteStart: OpenDeleteStart deleteStartAttributes* SLASH_CLOSE;
		
		deleteStartAttributes: typeDeleteStart/*type*/ | number | designator;

			typeDeleteStart returns[String value]: TYPE EQUALS DOUBLE_QUOTES stringLettersMixedCase DOUBLE_QUOTES{
				String[] types = {"RUNWAY", "HELIPAD", "WATER"};
				int i = 0;
				for (i = 0;  i < types.length; i++){
					if ($stringLettersMixedCase.value.equals(types[i]))
						break;
				}
				if (i == types.length){
					notifyErrorListeners("Invalid delete start type... Input: "+$stringLettersMixedCase.value);
					$value = "invalid_value";
				}
				else $value = $stringLettersMixedCase.value;
			};
	
	deleteFrequency: OpenDeleteFrequency deleteFrequencyAttributes* SLASH_CLOSE;
		
		deleteFrequencyAttributes: frequency | typeDeleteFrequency/* | type*/;
		
			typeDeleteFrequency returns[String value]: TYPE EQUALS DOUBLE_QUOTES stringLettersNumbers DOUBLE_QUOTES{
				String[] types = {"APPROACH", "ASOS", "ATIS", "AWOS", "CENTER", "CLEARANCE", "CLEARANCE_PRE_TAXI", "CTAF", "DEPARTURE", "FSS", "GROUND", "MULTICOM", "REMOTE_CLEARANCE_DELIVERY", "TOWER", "UNICOM"};
				int i = 0;
				for (i = 0;  i < types.length; i++){
					if ($stringLettersNumbers.value.equals(types[i]))
						break;
				}
				if (i == types.length){
					notifyErrorListeners("Invalid delete frequency type... Input: "+$stringLettersNumbers.value);
					$value = "invalid_value";
				}
				else $value = $stringLettersNumbers.value;
			};
		
	tower: OpenTower towerAttributes* ( SLASH_CLOSE | (CLOSE EndTower) );

		towerAttributes: latitude | longitude | altitude  ;

	runway: OpenRunway runwayAttributes* CLOSE runwayElements EndRunway;

		runwayAttributes:  latitude | longitude | altitude | surface | heading	/*heading -> 0 a 360*/
							| length | width | number | designator | primaryDesignator
							| secondaryDesignator | patternAltitude | primaryTakeoff
							| primaryLanding | primaryPattern | secondaryTakeoff | secondaryLanding | secondaryPattern
							| primaryMarkingBias | secondaryMarkingBias; 

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

				markings: OpenMarkings markingAttributes* SLASH_CLOSE;

					markingAttributes: edges | threshold | fixedDistance | touchdown | dashes
						| identMarkings | precision | edgePavement | singleEnd | primaryClosed		
						| secondaryClosed | primaryStol | secondaryStol;

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

				lights: OpenLight lightAttributes* SLASH_CLOSE;

					lightAttributes: center | edge | centerRed;

						center: CENTER LEVELS DOUBLE_QUOTES ;
						edge: EDGE LEVELS DOUBLE_QUOTES;
						centerRed: CENTER_RED EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;


				offsetThreshold: OpenOffsetThreshold offsetThresholdAttributes* SLASH_CLOSE;

					offsetThresholdAttributes: end | length | width | surface;

						end: END PRIORITY DOUBLE_QUOTES;


				blastPad: OpenBlastPad blastPadAttributes* SLASH_CLOSE;

					blastPadAttributes: end | length | width | surface;

				overrun: OpenOverrun overrunAttributes* SLASH_CLOSE;

					overrunAttributes: end | length | width | surface;

				approachLights: OpenApproachLights approachLightsAttributes* SLASH_CLOSE;

					approachLightsAttributes: end | system | strobes | reil | touchdown | endLights;

						system: SYSTEM SYSTEM_OPTIONS DOUBLE_QUOTES;
						strobes: STROBES integerValue DOUBLE_QUOTES;
						reil: REIL EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						endLights: ENDLIGHTS EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES; 

				vasi: OpenVasi vasiAttributes* SLASH_CLOSE;

					vasiAttributes: end | typevasi | side | biasX | biasZ | spacing | pitch;

						typevasi returns[String value]: TYPE EQUALS DOUBLE_QUOTES stringLettersNumbers DOUBLE_QUOTES{
							String[] types = {"PAPI2", "PAPI4",	"PVASI", "TRICOLOR", "TVASI", "VASI21", "VASI22", "VASI23", "VASI31", 
							"VASI32", "VASI33","BALL","APAP","PANELS"};
							int i = 0;
							for (i = 0;  i < types.length; i++){
								if ($stringLettersNumbers.value.equals(types[i]))
									break;
							}
							if (i == types.length){
								notifyErrorListeners("Invalid vasi type... Input: "+$stringLettersNumbers.value);
								$value = "invalid_value";
							}
							else $value = $stringLettersNumbers.value;
						};

						side: SIDE LEFT_RIGHT DOUBLE_QUOTES;
						
						spacing returns[float value]: SPACING floatingPointValue units_all? DOUBLE_QUOTES{
							if ($floatingPointValue.value < 0){
								notifyErrorListeners("Invalid spacing... Must be positive... input: " + $floatingPointValue.value);
								$value = -1;
							}
							else $value = $floatingPointValue.value;	
						}; // units default: meters

						pitch returns[float value]: PITCH floatingPointValue DOUBLE_QUOTES{
							if ($floatingPointValue.value < 0 || $floatingPointValue.value > 9.9){
								notifyErrorListeners("Invalid pitch... Must be between 0.0 and 9.9... input: " + $floatingPointValue.value);
								$value = -1;
							}
							else $value = $floatingPointValue.value;	
						};/*0.0-9.9*/


				ils: OpenIls ilsAttributes* ilsElements CLOSE CloseIls;

					ilsAttributes: latitude | longitude | altitude | heading | frequency 
									| end | range | magvar | ident | width | ils_name | backCourse; 
					
						ils_name returns[String value]: NAME EQUALS DOUBLE_QUOTES stringLettersMixedCase DOUBLE_QUOTES{
							if ($stringLettersMixedCase.value.length() > 48){
								notifyErrorListeners("Ils name too long... Must have a maximum of 48 chars!");
								$value = "invalid_value";
							}
							else $value = $stringLettersMixedCase.value;
						} ; 

						range: RANGE floatingPointValue DOUBLE_QUOTES;

						backCourse: BACKCOURSE EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;

					ilsElements: ; 



  /* -----------------------------------------------------------*/
		


	start: OpenStart startAttributes* SLASH_CLOSE;

		startAttributes: type | latitude | longitude | altitude | heading | number | designator;

	com: OpenCom comAttributes* SLASH_CLOSE;

		comAttributes: frequency | type | /*nameCom*/name ;

			/*nameCom: NAME EQUALS DOUBLE_QUOTES stringLettersMixedCase DOUBLE_QUOTES ;*/


////////////////////////////////////////////////////////////////////////////////////////////////
/* -------------------TAXIWAYPOINT -----------------------------------------------------------------*/
	taxiwayPoint: OpenTaxiwayPoint taxiwayPointAttributes* SLASH_CLOSE; 

		taxiwayPointAttributes: taxiway_index | taxiwaypoint_type | taxiway_orientation | ((latitude longitude) | (biasX biasY));

		taxiwaypoint_type returns[String value]: TYPE EQUALS DOUBLE_QUOTES stringLettersNumbers DOUBLE_QUOTES{
							String[] types = {"NORMAL", "HOLD_SHORT", "ILS_HOLD_SHORT", "HOLD_SHORT_NO_DRAW", "ILS_HOLD_SHORT_NO_DRAW"};
							int i = 0;
							for (i = 0;  i < types.length; i++){
								if ($stringLettersNumbers.value.equals(types[i]))
									break;
							}
							if (i == types.length){
								notifyErrorListeners("Invalid taxiway point type... Input: "+$stringLettersNumbers.value);
								$value = "invalid_value";
							}
							else $value = $stringLettersNumbers.value;
						};

			taxiway_index returns[int index]: INDEX integerValue DOUBLE_QUOTES
									{
										if ($integerValue.value < 0 || $integerValue.value > 3999){
											String err = "Invalid index... Must be between 0 and 3999... ";
											err = err + "input: " + $integerValue.value;
											notifyErrorListeners(err);
											$index = -1; // ???
										}
										else $index = $integerValue.value;

									}; /*0-3999*/
			taxiway_orientation: ORIENTATION ORIENTATIONTYPE DOUBLE_QUOTES; 

	/*-------------------------------TaxiwayParking-----------------------------------------------------*/
	taxiwayParking: OpenTaxiwayParking taxiwayParkingAttributes* SLASH_CLOSE; 

		taxiwayParkingAttributes: taxiway_index | ((latitude longitude) | (biasX biasY)) | heading 
									| taxiway_radius /*taxiwayparking_type*/ | type | taxiwayparking_name 
									| taxiway_number | taxiway_airlineCodes | taxiway_pushBack | taxiway_teeOffset+;

			//index: INDEX EQUALS INDEXVALUE; 
			/*taxiway_heading: HEADING floatingPointValue DOUBLE_QUOTES;*/ /*0.0-360.0*/
			taxiway_radius: RADIUS floatingPointValue units_all? DOUBLE_QUOTES;
			taxiwayparking_type returns[String value]: TYPE EQUALS DOUBLE_QUOTES stringLettersNumbers DOUBLE_QUOTES{
							String[] types = {"NONE", "DOCK_GA", "FUEL", "GATE_HEAVY", "GATE_MEDIUM", "GATE_SMALL", "RAMP_CARGO", 
											"RAMP_GA", "RAMP_GA_LARGE", "RAMP_GA_MEDIUM", "RAMP_GA_SMALL", "RAMP_MIL_CARGO", "RAMP_MIL_COMBAT", "VEHICLE"};
							int i = 0;
							for (i = 0;  i < types.length; i++){
								if ($stringLettersNumbers.value.equals(types[i]))
									break;
							}
							if (i == types.length){
								notifyErrorListeners("Invalid taxiway parking type... Input: "+$stringLettersNumbers.value);
								$value = "invalid_value";
							}
							else $value = $stringLettersNumbers.value;
						};
			taxiwayparking_name returns[String value]: NAME EQUALS DOUBLE_QUOTES stringLettersUpperCase DOUBLE_QUOTES{
							String[] types = {"PARKING", "DOCK", "GATE", "GATE_A", "GATE_B", "GATE_C", "GATE_D", "GATE_E", "GATE_F", "GATE_G", 
							"GATE_H", "GATE_I", "GATE_J", "GATE_K", "GATE_L", "GATE_M", "GATE_N", "GATE_O", "GATE_P", "GATE_Q", "GATE_R", "GATE_S", 
							"GATE_T", "GATE_U", "GATE_V", "GATE_W", "GATE_X", "GATE_Y", "GATE_Z", "NONE", "N_PARKING", "NE_PARKING", "NW_PARKING", 
							"SE_PARKING", "S_PARKING", "SW_PARKING", "W_PARKING", "E_PARKING"};
							int i = 0;
							for (i = 0;  i < types.length; i++){
								if ($stringLettersUpperCase.value.equals(types[i]))
									break;
							}
							if (i == types.length){
								notifyErrorListeners("Invalid taxiway parking name... Input: "+$stringLettersUpperCase.value);
								$value = "invalid_value";
							}
							else $value = $stringLettersUpperCase.value;
						};
			taxiway_number: NUMBER NUMBER_VALUES DOUBLE_QUOTES;/*0-3999*/
			taxiway_airlineCodes: AIRLINECODES AIRLINECODESVALUES DOUBLE_QUOTES;
			taxiway_pushBack: PUSHBACK PUSHBACKVALUES DOUBLE_QUOTES;
			taxiway_teeOffset: TEEOFFSET floatingPointValue DOUBLE_QUOTES;/*0.1-50.0*/

	/*--------------------------------------TAXINAME-------------------------------*/
	taxiName: OpenTaxiName taxiNameAttributes* SLASH_CLOSE;

		taxiNameAttributes: taxiNameIndex | taxiNameName;

			taxiNameIndex returns[int index]: INDEX integerValue DOUBLE_QUOTES
							{
								if ($integerValue.value < 0 || $integerValue.value > 255){
									String err = "Invalid index... Must be between 0 and 255... ";
									err = err + "input: " + $integerValue.value;
									notifyErrorListeners(err);
									$index = -1; // ???
								}
								else $index = $integerValue.value;

							};/*0-255*/

			taxiNameName returns[String value]: NAME EQUALS DOUBLE_QUOTES stringLettersNumbers? DOUBLE_QUOTES{
				if($stringLettersNumbers.text == null) $value = "";
				else if($stringLettersNumbers.value.length() > 8) {
					notifyErrorListeners("TaxiName name too long... Must have a maximum of 8 chars!");
					$value = "invalid_value";
				}
				else $value = $stringLettersNumbers.value;
			};

	/*-----------------------------------------------------TAXIWAYPATH-----------------------------------------*/
	taxiwayPath: OpenTaxiwayPath taxiwayPathAttributes* SLASH_CLOSE;

		taxiwayPathAttributes: type | taxiway_start | taxiway_end | width | taxiway_weightLimit | surface | drawSurface 
							| drawDetail | taxiway_centerLine | taxiway_centerLineLighted | taxiway_leftEdge | taxiway_leftEdgeLighted 
							| taxiway_rightEdge | taxiway_rightEdgeLighted | taxiway_number | designator | taxiwaypath_name;

			taxiwaypath_type returns[String value]: TYPE EQUALS DOUBLE_QUOTES stringLettersNumbers DOUBLE_QUOTES{
							String[] types = {"RUNWAY", "PARKING", "TAXI", "PATH", "CLOSED", "VEHICLE"};
							int i = 0;
							for (i = 0;  i < types.length; i++){
								if ($stringLettersNumbers.value.equals(types[i]))
									break;
							}
							if (i == types.length){
								notifyErrorListeners("Invalid taxiway path type... Input: "+$stringLettersNumbers.value);
								$value = "invalid_value";
							}
							else $value = $stringLettersNumbers.value;
						};
			
			taxiway_start: START integerValue DOUBLE_QUOTES; /*0-3999*/
			
			taxiway_end: END INT_NUMBER2 DOUBLE_QUOTES; /*0-3999*/
			
			/*taxiway_width: WIDTH EQUALS DOUBLE_QUOTES floatingPointValue DOUBLE_QUOTES;*/
			
			taxiway_weightLimit: WEIGHTLIMIT floatingPointValue DOUBLE_QUOTES;
			
			drawSurface: DRAWSURFACE EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
			
			drawDetail: DRAWDETAIL EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
			
			taxiway_centerLine: CENTERLINE EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
			
			taxiway_centerLineLighted: CENTERLINELIGHTED EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
			
			taxiway_leftEdge: LEFTEDGE EDGETYPE DOUBLE_QUOTES;
			
			taxiway_leftEdgeLighted: LEFTEDGELIGHTED EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
			
			taxiway_rightEdge: RIGHTEDGE EDGETYPE DOUBLE_QUOTES;
			
			taxiway_rightEdgeLighted: RIGHTEDGELIGHTED EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
			
			taxiwaypath_name returns[int value]: NAME EQUALS DOUBLE_QUOTES INT_NUMBER DOUBLE_QUOTES {
					int i = Integer.parseInt($INT_NUMBER.text);
						if (i < 0 || i > 255){
							String err = "Invalid taxiway path name... Must be between 0 and 255... ";
							err = err + "input: " + i;
							notifyErrorListeners( err );
							$value = -1;
						}
						else $value = i;
					};


	jetway: OpenJetway jetwayAttributes* CLOSE jetwayElements CloseJetway;

		jetwayAttributes: gateName | parkingNumber;

			gateName: GATENAME GATENAME_WORDS DOUBLE_QUOTES;

			parkingNumber: PARKINGNUMBER integerValue DOUBLE_QUOTES;

		jetwayElements: ;

	aprons: StartAprons apron* CloseAprons;

		apron: OpenApron apronAttributes* CLOSE vertex* EndApron;

			apronAttributes: surface | drawSurface | drawDetail;

			vertex: OpenVertex vertexAttributes SLASH_CLOSE;

				vertexAttributes: (latitude | longitude) | (biasX | biasY);

	apronEdgeLights: StartApronEdgeLights apronEdgeLightsElements EndApronEdgeLights;

		apronEdgeLightsElements: edgeLights* ;

			edgeLights: StartEdgeLights vertex* EndEdgeLights;

	/* TODO taxiwaySign: OpenTaxiwaySign taxiwaySignAttributes SLASH_CLOSE;

		taxiwaySignAttributes: latitude longitude heading; */


	boundaryFence : OpenBoundaryFence boundaryFenceAttributes* SLASH_CLOSE boundaryFenceElements*;

		boundaryFenceAttributes: instanceId | profile  ;
		  
			instanceId: INSTANCE_ID GUID DOUBLE_QUOTES; 

			profile: PROFILE GUID DOUBLE_QUOTES;

		boundaryFenceElements: vertex vertex vertex* ;


	blastFence : OpenBlastFence blastFenceAttributes* SLASH_CLOSE blastFenceElements*;

		blastFenceAttributes: instanceId | profile  ;

		blastFenceElements: vertex vertex vertex* ;


	waypoint: OpenWaypoint waypointAttributes* CLOSE waypointElements EndWaypoint;

		waypointAttributes: latitude | longitude | type | waypointType | magvar
							| waypointRegion | waypointIdent;

			waypointType: WAYPOINTTYPE WAYPOINTTYPE_WORDS DOUBLE_QUOTES;

			waypointRegion: WAYPOINTREGION DOUBLE_QUOTES EQUALS stringLettersNumbers DOUBLE_QUOTES;

			waypointIdent: WAYPOINTIDENT DOUBLE_QUOTES EQUALS stringLettersNumbers DOUBLE_QUOTES;

		waypointElements: route* ;

			route: OpenRoute routeAttributes* CLOSE routeElements EndRoute;

				routeAttributes: routeType | route_name ;

					routeType: ROUTETYPE ROUTETYPE_WORDS DOUBLE_QUOTES ; 

					route_name returns[String value]: NAME EQUALS DOUBLE_QUOTES stringLettersMixedCase DOUBLE_QUOTES{
						if ($stringLettersMixedCase.value.length() > 8){
							notifyErrorListeners("Route name too long... Must have a maximum of 8 chars!");
							$value = "invalid_value";
						}
						else $value = $stringLettersMixedCase.value;
					};

				routeElements: previous* next* ;

					previous: OpenPrevious previousAttributes* SLASH_CLOSE;

						previousAttributes: waypointType | waypointRegion | waypointIdent | altitudeMinimum;

							altitudeMinimum: ALTITUDEMINIMUM floatingPointValue DOUBLE_QUOTES;

					next: OpenNext previousAttributes* SLASH_CLOSE;