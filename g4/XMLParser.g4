parser grammar XMLParser;

options { tokenVocab=XMLLexer; }

@members {
	java.util.ArrayList<Integer> taxiwaypoint_indexes = new java.util.ArrayList<Integer>();
	java.util.ArrayList<Integer> taxiwayparking_indexes = new java.util.ArrayList<Integer>();

	public boolean taxiway_index_is_defined(int variable) {
		int index = taxiwaypoint_indexes.indexOf(variable);
		if (index > -1)
			return true;
		index = taxiwayparking_indexes.indexOf(variable);
		return index > -1;
	}		
}

document    :  airport*;

/////////////////////////////////////////////////////////////////////
///////////////////////// SOME COMMON ATTRIBUTES ////////////////////
/////////////////////////////////////////////////////////////////////

type: TYPE stringLettersMixedCase DOUBLE_QUOTES;

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
bool: BOOLEAN | BOOLEAN2;
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
	STRING_LETTERS_MIXED {$value = $STRING_LETTERS_MIXED.text;};

stringLettersUpperCase returns[String value]: 
	STRING_LETTERS_UPPERCASE {$value = $STRING_LETTERS_UPPERCASE.text;};


/////////////////////////////////////////////////////////////////////
//////////////////////////// ELEMENTS IN XML ////////////////////////
/////////////////////////////////////////////////////////////////////

//bools = {region, country, state, city, name, latitude, longitude, altitude, magvar, ident, airportTestRadius, trafficScalar}
airport locals[boolean[] bools = {false, false, false, false, false, false, false, false, false, false, false, false}]: 
	OpenAirport airportAttributes[$bools]* CLOSE  
		{
			if (!$bools[5])
				notifyErrorListeners("Missing latitude attribute in Airport Element");
			if(!$bools[6])
				notifyErrorListeners("Missing longitude attribute in Airport Element");
			if(!$bools[7])
				notifyErrorListeners("Missing altitude attribute in Airport Element");
			if(!$bools[9])
				notifyErrorListeners("Missing ident attribute in Airport Element");
			if(!$bools[11])
				notifyErrorListeners("Missing trafficScalar attribute in Airport Element");
		}
		airportElements EndAirport ; 

	airportAttributes [boolean[] bools]: 
		region  {if ($bools[0] == true) 
					notifyErrorListeners("Multiple region attribute at airport");
					else $bools[0] = true;}
		| country {if ($bools[1] == true) 
					notifyErrorListeners("Multiple country attribute at airport");
					else $bools[1] = true;}
		| state{if ($bools[2] == true) 
					notifyErrorListeners("Multiple state attribute at airport");
					else $bools[2] = true;}
		| city {if ($bools[3] == true) 
					notifyErrorListeners("Multiple city attribute at airport");
					else $bools[3] = true;}
		| name {if ($bools[4] == true) 
					notifyErrorListeners("Multiple name attribute at airport");
					else $bools[4] = true;}
		| latitude {if ($bools[5] == true) 
					notifyErrorListeners("Multiple latitude attribute at airport");
					else $bools[5] = true;}
		| longitude {if ($bools[6] == true) 
					notifyErrorListeners("Multiple longitude attribute at airport");
					else $bools[6] = true;}
		| altitude {if ($bools[7] == true) 
					notifyErrorListeners("Multiple altitude attribute at airport");
					else $bools[7] = true;}
		| magvar {if ($bools[8] == true) 
					notifyErrorListeners("Multiple magvar attribute at airport");
					else $bools[8] = true;}
		| ident {if ($bools[9] == true) 
					notifyErrorListeners("Multiple ident attribute at airport");
					else $bools[9] = true;}
		| airportTestRadius {if ($bools[10] == true) 
					notifyErrorListeners("Multiple airportTestRadius attribute at airport");
					else $bools[10] = true;}
		| trafficScalar {if ($bools[11] == true) 
					notifyErrorListeners("Multiple trafficScalar attribute at airport");
					else $bools[11] = true;};

		region returns[String value]: REGION stringLettersMixedCase DOUBLE_QUOTES{
			if ($stringLettersMixedCase.value.length() > 48){
				notifyErrorListeners("Region too long... Must have a maximum of 48 chars!");
				$value = "invalid_value";
			}
			else $value = $stringLettersMixedCase.value;
		} ; 

		country returns[String value]: COUNTRY stringLettersMixedCase DOUBLE_QUOTES{
			if ($stringLettersMixedCase.value.length() > 48){
				notifyErrorListeners("Country too long... Must have a maximum of 48 chars!");
				$value = "invalid_value";
			}
			else $value = $stringLettersMixedCase.value;
		} ; 

		state returns[String value]: STATE stringLettersMixedCase DOUBLE_QUOTES{
			if ($stringLettersMixedCase.value.length() > 48){
				notifyErrorListeners("State too long... Must have a maximum of 48 chars!");
				$value = "invalid_value";
			}
			else $value = $stringLettersMixedCase.value;
		} ;  

		city returns[String value]: CITY stringLettersMixedCase DOUBLE_QUOTES{
			if ($stringLettersMixedCase.value.length() > 48){
				notifyErrorListeners("City too long... Must have a maximum of 48 chars!");
				$value = "invalid_value";
			}
			else $value = $stringLettersMixedCase.value;
		} ;  

		name returns[String value]: NAME stringLettersMixedCase DOUBLE_QUOTES{
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

		ident returns[String value]: IDENT stringLettersMixedCase DOUBLE_QUOTES {
			if ($stringLettersMixedCase.value.length() > 4){
				notifyErrorListeners("Ident too long... Must have a maximum of 4 chars!");
				$value = "invalid_value";
			}
			else $value = $stringLettersMixedCase.value;
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

	airportElements: services* deleteAirport* deletes tower* runway* start* helipad* com* 
		taxiwayPoint* taxiwayParking* taxiName* taxiwayPath* jetway*
		aprons* apronEdgeLights* boundaryFence* blastFence* waypoint*;

		services: OpenServices servicesElements EndServices;

			servicesElements: fuel*;

				//bools = {typeFuel, availabilityFuel}
				fuel locals[boolean[] bools = {false, false}]: 
					OpenFuel fuelAttributes[$bools]* SLASH_CLOSE
					{
						if (!$bools[0])
							notifyErrorListeners("Missing type attribute in Fuel Element");
						if(!$bools[1])
							notifyErrorListeners("Missing availability attribute in Fuel Element");
					};

					fuelAttributes[boolean[] bools]: 
						typefuel{
							if ($bools[0] == true) 
								notifyErrorListeners("Multiple type attribute in Fuel Element");
							else $bools[0] = true;}

						| availabilityFuel{
							if ($bools[1] == true) 
								notifyErrorListeners("Multiple availability attribute in Fuel Element");
							else $bools[1] = true;};
				
						/*typefuel: TYPE EQUALS DOUBLE_QUOTES TYPESFUEL_WORDS DOUBLE_QUOTES;*/
						typefuel returns[String value]: TYPE stringLettersMixedCase DOUBLE_QUOTES{
							String[] types = {"73", "87", "100", "130", "145", "MOGAS", "JET", "JETA", "JETA1", "JETAP", "JETB", "JET4", "JET5", "UNKNOWN"};
							int i = 0;
							for (i = 0;  i < types.length; i++){
								if ($stringLettersMixedCase.value.equals(types[i]))
									break;
							}
							if (i == types.length){
								notifyErrorListeners("Invalid fuel type... Input: "+$stringLettersMixedCase.value);
								$value = "invalid_value";
							}
							else $value = $stringLettersMixedCase.value;
						};

						availabilityFuel: AVAILABILITY AVAILABILITY_WORDS DOUBLE_QUOTES ;
	
	
	
	deletes: deleteAirport* deleteRunway* deleteStart* deleteFrequency*;
	
	deleteAirport: OpenDeleteAirport deleteAirportAttributes* SLASH_CLOSE;
	
		deleteAirportAttributes: DELETEAIRPORTATRIBUTES EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;

	deleteRunway locals[boolean[] bools = {false, false, false}]: 
		OpenDeleteRunway deleteRunwayAttributes[$bools]* {
				if (!$bools[0])
					notifyErrorListeners("Missing surface attribute in DeleteRunway element");
				if(!$bools[1])
					notifyErrorListeners("Missing number attribute in DeleteRunway element");
			}
			SLASH_CLOSE;
	
		deleteRunwayAttributes [boolean[] bools]: 
			surface {if ($bools[0] == true) 
						notifyErrorListeners("Multiple surface attribute in DeleteRunway element");
					else $bools[0] = true;}
			| number {if ($bools[1] == true) 
						notifyErrorListeners("Multiple number attribute in DeleteRunway element");
					else $bools[1] = true;}
			| designator {if ($bools[2] == true) 
							notifyErrorListeners("Multiple designator attribute in DeleteRunway element");
						else $bools[2] = true;};
		
	deleteStart locals[boolean[] bools = {false, false, false}]: 
		OpenDeleteStart deleteStartAttributes[$bools]* {
				if (!$bools[0])
					notifyErrorListeners("Missing surface attribute in DeleteRunway element");
				if(!$bools[1])
					notifyErrorListeners("Missing number attribute in DeleteRunway element");
			}SLASH_CLOSE;
		
		deleteStartAttributes [boolean[] bools]: 
			typeDeleteStart {if ($bools[0] == true) 
								notifyErrorListeners("Multiple type attribute in DeleteStart element");
							else $bools[0] = true;}
			| number {if ($bools[1] == true) 
						notifyErrorListeners("Multiple number attribute in DeleteStart element");
					else $bools[1] = true;}
			| designator {if ($bools[2] == true) 
							notifyErrorListeners("Multiple designator attribute in DeleteStart element");
						else $bools[2] = true;};


			typeDeleteStart returns[String value]: TYPE stringLettersMixedCase DOUBLE_QUOTES{
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
	
	deleteFrequency locals[boolean[] bools = {false, false}]: 
		OpenDeleteFrequency deleteFrequencyAttributes[$bools]* {
				if (!$bools[0])
					notifyErrorListeners("Missing frequency attribute in DeleteFrequency element");
				if(!$bools[1])
					notifyErrorListeners("Missing type attribute in DeleteFrequency element");
			}SLASH_CLOSE;
		
		deleteFrequencyAttributes [boolean[] bools]: 
			frequency {if ($bools[0] == true) 
								notifyErrorListeners("Multiple frequency attribute in DeleteFrequency element");
							else $bools[0] = true;}
			| typeDeleteFrequency {if ($bools[1] == true) 
								notifyErrorListeners("Multiple type attribute in DeleteFrequency element");
							else $bools[1] = true;};
		
			typeDeleteFrequency returns[String value]: TYPE stringLettersMixedCase DOUBLE_QUOTES{
				String[] types = {"APPROACH", "ASOS", "ATIS", "AWOS", "CENTER", "CLEARANCE", "CLEARANCE_PRE_TAXI", 
					"CTAF", "DEPARTURE", "FSS", "GROUND", "MULTICOM", "REMOTE_CLEARANCE_DELIVERY", "TOWER", "UNICOM"};
				int i = 0;
				for (i = 0;  i < types.length; i++){
					if ($stringLettersMixedCase.value.equals(types[i]))
						break;
				}
				if (i == types.length){
					notifyErrorListeners("Invalid delete frequency type... Input: "+$stringLettersMixedCase.value);
					$value = "invalid_value";
				}
				else $value = $stringLettersMixedCase.value;
			};
		
	tower locals[boolean[] bools = {false, false, false}]: 
		OpenTower towerAttributes[$bools]* ( SLASH_CLOSE | (CLOSE EndTower) );

		towerAttributes [boolean[] bools]: 
			latitude {if ($bools[0] == true) 
						notifyErrorListeners("Multiple latitude attribute in Tower element");
					else $bools[0] = true;}
			| longitude {if ($bools[1] == true) 
							notifyErrorListeners("Multiple longitude attribute in Tower element");
						else $bools[1] = true;}
			| altitude {if ($bools[2] == true) 
							notifyErrorListeners("Multiple altitude attribute in Tower element");
						else $bools[2] = true;} ;

	runway locals[boolean[] bools = {false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,false,false,false}]: 
		OpenRunway runwayAttributes[$bools]* {
				if (!$bools[0])
					notifyErrorListeners("Missing latitude attribute in Runway element");
				if (!$bools[1])
					notifyErrorListeners("Missing longitude attribute in Runway element");
				if (!$bools[2])
					notifyErrorListeners("Missing altitude attribute in Runway element");
				if (!$bools[3])
					notifyErrorListeners("Missing surface attribute in Runway element");
				if (!$bools[4])
					notifyErrorListeners("Missing heading attribute in Runway element");
				if (!$bools[5])
					notifyErrorListeners("Missing length attribute in Runway element");
				if (!$bools[6])
					notifyErrorListeners("Missing width attribute in Runway element");
				if (!$bools[7])
					notifyErrorListeners("Missing number attribute in Runway element");
				if (!$bools[8] && !$bools[9])
					notifyErrorListeners("Missing designator or primaryDesignator attribute in Runway element");
				if ($bools[8] && $bools[9])
					notifyErrorListeners("Only one from designator and primaryDesignator should be set in Runway element.");
				if ($bools[9] && $bools[10])
					notifyErrorListeners("Only one from primaryDesignator and secondaryDesignator should be set in Runway element.");

			}CLOSE runwayElements EndRunway;

		runwayAttributes[boolean[] bools]:  
			  latitude {if ($bools[0] == true) 
						notifyErrorListeners("Multiple latitude attribute in Runway element");
					else $bools[0] = true;}
			| longitude {if ($bools[1] == true) 
						notifyErrorListeners("Multiple longitude attribute in Runway element");
					else $bools[1] = true;}
			| altitude {if ($bools[2] == true) 
						notifyErrorListeners("Multiple altitude attribute in Runway element");
					else $bools[2] = true;}
			| surface {if ($bools[3] == true) 
						notifyErrorListeners("Multiple surface attribute in Runway element");
					else $bools[3] = true;}
			| heading {if ($bools[4] == true) 
						notifyErrorListeners("Multiple heading attribute in Runway element");
					else $bools[4] = true;}
			| length {if ($bools[5] == true) 
						notifyErrorListeners("Multiple length attribute in Runway element");
					else $bools[5] = true;}
			| width {if ($bools[6] == true) 
						notifyErrorListeners("Multiple width attribute in Runway element");
					else $bools[6] = true;}
			| number {if ($bools[7] == true) 
						notifyErrorListeners("Multiple number attribute in Runway element");
					else $bools[7] = true;}
			| designator {if ($bools[8] == true) 
						notifyErrorListeners("Multiple designator attribute in Runway element");
					else $bools[8] = true;}
			| primaryDesignator {if ($bools[9] == true) 
						notifyErrorListeners("Multiple primaryDesignator attribute in Runway element");
					else $bools[9] = true;}
			| secondaryDesignator {if ($bools[10] == true) 
						notifyErrorListeners("Multiple secondaryDesignator attribute in Runway element");
					else $bools[10] = true;}
			| patternAltitude {if ($bools[11] == true) 
						notifyErrorListeners("Multiple patternAltitude attribute in Runway element");
					else $bools[11] = true;}
			| primaryTakeoff {if ($bools[12] == true) 
						notifyErrorListeners("Multiple primaryTakeoff attribute in Runway element");
					else $bools[12] = true;}
			| primaryLanding {if ($bools[13] == true) 
						notifyErrorListeners("Multiple primaryLanding attribute in Runway element");
					else $bools[13] = true;}
			| primaryPattern {if ($bools[14] == true) 
						notifyErrorListeners("Multiple primaryPattern attribute in Runway element");
					else $bools[14] = true;}
			| secondaryTakeoff {if ($bools[15] == true) 
						notifyErrorListeners("Multiple secondaryTakeoff attribute in Runway element");
					else $bools[15] = true;}
			| secondaryLanding {if ($bools[16] == true) 
						notifyErrorListeners("Multiple secondaryLanding attribute in Runway element");
					else $bools[16] = true;}
			| secondaryPattern {if ($bools[17] == true) 
						notifyErrorListeners("Multiple secondaryPattern attribute in Runway element");
					else $bools[17] = true;}
			| primaryMarkingBias {if ($bools[18] == true) 
						notifyErrorListeners("Multiple primaryMarkingBias attribute in Runway element");
					else $bools[18] = true;}
			| secondaryMarkingBias {if ($bools[19] == true) 
						notifyErrorListeners("Multiple secondaryMarkingBias attribute in Runway element");
					else $bools[19] = true;
				}; 

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

					markingAttributes: alternateThreshold | alternateTouchdown | alternateFixedDistance 
						| alternatePrecision | leadingZeroIdent | noThresholdEndArrows
						| edges | threshold | fixedDistance | touchdown | dashes
						| identMarkings | precision | edgePavement | singleEnd | primaryClosed		
						| secondaryClosed | primaryStol | secondaryStol;


						alternateThreshold: ALTERNATETHRESHOLD EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						alternateTouchdown: ALTERNATETOUCHDOWN EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						alternateFixedDistance: ALTERNATEFIXEDDISTANCE EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						alternatePrecision: ALTERNATEPRECISION EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						leadingZeroIdent: LEADINGZEROIDENT EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						noThresholdEndArrows: NOTHRESHOLDENDARROWS EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						edges: EDGES EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						threshold: THRESHOLD EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						fixedDistance: FIXEDDISTANCE EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						touchdown: TOUCHDOWN EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						dashes: DASHES EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						identMarkings: IDENT bool DOUBLE_QUOTES;
						precision: PRECISION EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						edgePavement: EDGEPAVEMENT EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						singleEnd: SINGLEEND EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						primaryClosed: PRIMARYCLOSED EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						secondaryClosed: SECONDARYCLOSED EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						primaryStol: PRIMARYSTOL EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						secondaryStol: SECONDARYSTOL EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;

				lights locals[boolean[] bools = {false,false,false}]: 
					OpenLight lightAttributes[$bools]* {
							if (!$bools[0])
								notifyErrorListeners("Missing center attribute in Light element");
							if (!$bools[1])
								notifyErrorListeners("Missing edge attribute in Light element");
							if (!$bools[2])
								notifyErrorListeners("Missing centerRed attribute in Light element");
						} SLASH_CLOSE;

					lightAttributes [boolean[] bools]: 
						center {if ($bools[0] == true) 
									notifyErrorListeners("Multiple center attribute in Light element");
								else $bools[0] = true;}
						| edge {if ($bools[1] == true) 
									notifyErrorListeners("Multiple edge attribute in Light element");
								else $bools[1] = true;}
						| centerRed {if ($bools[2] == true) 
									notifyErrorListeners("Multiple centerRed attribute in Light element");
								else $bools[2] = true;};

						center: CENTER LEVELS DOUBLE_QUOTES ;
						edge: EDGE LEVELS DOUBLE_QUOTES;
						centerRed: CENTER_RED EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;


				offsetThreshold locals[boolean[] bools = {false, false, false, false}]:
					OpenOffsetThreshold offsetThresholdAttributes[$bools]* {
							if (!$bools[0])
								notifyErrorListeners("Missing end attribute in OffsetThreshold element");
							if (!$bools[1])
								notifyErrorListeners("Missing length attribute in OffsetThreshold element");
						}SLASH_CLOSE;

					offsetThresholdAttributes [boolean[] bools]: 
						end {if ($bools[0] == true) 
								notifyErrorListeners("Multiple end attribute in OffsetThreshold element");
							else $bools[0] = true;}
						| length {if ($bools[1] == true) 
								notifyErrorListeners("Multiple length attribute in OffsetThreshold element");
							else $bools[1] = true;}
						| width {if ($bools[2] == true) 
								notifyErrorListeners("Multiple width attribute in OffsetThreshold element");
							else $bools[2] = true;}
						| surface {if ($bools[3] == true) 
								notifyErrorListeners("Multiple surface attribute in OffsetThreshold element");
							else $bools[3] = true;};

						end: END PRIORITY DOUBLE_QUOTES;


				blastPad locals[boolean[] bools = {false, false, false, false}]:
					OpenBlastPad blastPadAttributes[$bools]* {
							if (!$bools[0])
								notifyErrorListeners("Missing end attribute in BlastPad element");
							if (!$bools[1])
								notifyErrorListeners("Missing length attribute in BlastPad element");
						}SLASH_CLOSE;

					blastPadAttributes  [boolean[] bools]: 
						end {if ($bools[0] == true) 
								notifyErrorListeners("Multiple end attribute in BlastPad element");
							else $bools[0] = true;}
						| length {if ($bools[1] == true) 
								notifyErrorListeners("Multiple length attribute in BlastPad element");
							else $bools[1] = true;}
						| width {if ($bools[2] == true) 
								notifyErrorListeners("Multiple width attribute in BlastPad element");
							else $bools[2] = true;}
						| surface {if ($bools[3] == true) 
								notifyErrorListeners("Multiple surface attribute in BlastPad element");
							else $bools[3] = true;};

				overrun locals[boolean[] bools = {false, false, false, false}]:
					 OpenOverrun overrunAttributes[$bools]* {
							if (!$bools[0])
								notifyErrorListeners("Missing end attribute in Overrun element");
							if (!$bools[1])
								notifyErrorListeners("Missing length attribute in Overrun element");
						} SLASH_CLOSE;

					overrunAttributes  [boolean[] bools]: 
						end {if ($bools[0] == true) 
								notifyErrorListeners("Multiple end attribute in Overrun element");
							else $bools[0] = true;}
						| length {if ($bools[1] == true) 
								notifyErrorListeners("Multiple length attribute in Overrun element");
							else $bools[1] = true;}
						| width {if ($bools[2] == true) 
								notifyErrorListeners("Multiple width attribute in Overrun element");
							else $bools[2] = true;}
						| surface {if ($bools[3] == true) 
								notifyErrorListeners("Multiple surface attribute in Overrun element");
							else $bools[3] = true;};

				approachLights locals[boolean[] bools = {false, false, false, false, false, false}]:
					OpenApproachLights approachLightsAttributes[$bools]* {
							if (!$bools[0])
								notifyErrorListeners("Missing end attribute in ApproachLights element");
						}SLASH_CLOSE;

					approachLightsAttributes [boolean[] bools]: 
						end {if ($bools[0] == true) 
								notifyErrorListeners("Multiple end attribute in ApproachLights element");
							else $bools[0] = true;}
						| system {if ($bools[1] == true) 
								notifyErrorListeners("Multiple system attribute in ApproachLights element");
							else $bools[1] = true;}
						| strobes {if ($bools[2] == true) 
								notifyErrorListeners("Multiple strobes attribute in ApproachLights element");
							else $bools[2] = true;}
						| reil {if ($bools[3] == true) 
								notifyErrorListeners("Multiple reil attribute in ApproachLights element");
							else $bools[3] = true;}
						| touchdown {if ($bools[4] == true) 
								notifyErrorListeners("Multiple touchdown attribute in ApproachLights element");
							else $bools[4] = true;}
						| endLights {if ($bools[5] == true) 
								notifyErrorListeners("Multiple endLights attribute in ApproachLights element");
							else $bools[5] = true;};

						system: SYSTEM SYSTEM_OPTIONS DOUBLE_QUOTES;
						strobes: STROBES integerValue DOUBLE_QUOTES;
						reil: REIL EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;
						endLights: ENDLIGHTS EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES; 

				vasi locals[boolean[] bools = {false, false, false, false, false, false, false}]: 
					OpenVasi vasiAttributes[$bools]*{
							if (!$bools[0])
								notifyErrorListeners("Missing end attribute in Vasi element");
							if (!$bools[1])
								notifyErrorListeners("Missing type attribute in Vasi element");
							if (!$bools[2])
								notifyErrorListeners("Missing side attribute in Vasi element");
							if (!$bools[3])
								notifyErrorListeners("Missing biasX attribute in Vasi element");
							if (!$bools[4])
								notifyErrorListeners("Missing biasZ attribute in Vasi element");
							if (!$bools[5])
								notifyErrorListeners("Missing spacing attribute in Vasi element");
							if (!$bools[6])
								notifyErrorListeners("Missing length attribute in Vasi element");
						} SLASH_CLOSE;

					vasiAttributes [boolean[] bools]: 
						end {if ($bools[0] == true) 
								notifyErrorListeners("Multiple end attribute in Vasi element");
							else $bools[0] = true;}
						| typevasi {if ($bools[1] == true) 
								notifyErrorListeners("Multiple type attribute in Vasi element");
							else $bools[1] = true;}
						| side {if ($bools[2] == true) 
								notifyErrorListeners("Multiple side attribute in Vasi element");
							else $bools[2] = true;}
						| biasX {if ($bools[3] == true) 
								notifyErrorListeners("Multiple biasX attribute in Vasi element");
							else $bools[3] = true;}
						| biasZ {if ($bools[4] == true) 
								notifyErrorListeners("Multiple biasZ attribute in Vasi element");
							else $bools[4] = true;}
						| spacing {if ($bools[5] == true) 
								notifyErrorListeners("Multiple spacing attribute in Vasi element");
							else $bools[5] = true;}
						| pitch {if ($bools[6] == true) 
								notifyErrorListeners("Multiple pitch attribute in Vasi element");
							else $bools[6] = true;};

						typevasi returns[String value]: TYPE stringLettersMixedCase DOUBLE_QUOTES{
							String[] types = {"PAPI2", "PAPI4",	"PVASI", "TRICOLOR", "TVASI", "VASI21", "VASI22", "VASI23", "VASI31", 
							"VASI32", "VASI33","BALL","APAP","PANELS"};
							int i = 0;
							for (i = 0;  i < types.length; i++){
								if ($stringLettersMixedCase.value.equals(types[i]))
									break;
							}
							if (i == types.length){
								notifyErrorListeners("Invalid vasi type... Input:" +$stringLettersMixedCase.value);
								$value = "invalid_value";
							}
							else $value = $stringLettersMixedCase.value;
						};

						side: SIDE LEFT_RIGHT DOUBLE_QUOTES;
						
						spacing returns[float value]: SPACING floatingPointValue units_all? DOUBLE_QUOTES{
							if ($floatingPointValue.value < 0){
								notifyErrorListeners("Invalid spacing... Must be positive... input:" + $floatingPointValue.value);
								$value = -1;
							}
							else $value = $floatingPointValue.value;	
						}; // units default: meters

						pitch returns[float value]: PITCH floatingPointValue DOUBLE_QUOTES{
							if ($floatingPointValue.value < 0 || $floatingPointValue.value > 9.9){
								notifyErrorListeners("Invalid pitch... Must be between 0.0 and 9.9... input:" + $floatingPointValue.value);
								$value = -1;
							}
							else $value = $floatingPointValue.value;	
						};/*0.0-9.9*/


				ils locals[boolean[] bools = {false, false, false, false, false, false, false, false, false, false, false, false}]: 
					OpenIls ilsAttributes[$bools]* {
							if (!$bools[0])
								notifyErrorListeners("Missing latitude attribute in Ils element");
							if (!$bools[1])
								notifyErrorListeners("Missing longitude attribute in Ils element");
							if (!$bools[2])
								notifyErrorListeners("Missing altitude attribute in Ils element");
							if (!$bools[3])
								notifyErrorListeners("Missing heading attribute in Ils element");
							if (!$bools[4])
								notifyErrorListeners("Missing frequency attribute in Ils element");
							if (!$bools[5])
								notifyErrorListeners("Missing end attribute in Ils element");
							if (!$bools[7])
								notifyErrorListeners("Missing magvar attribute in Ils element");
							if (!$bools[8])
								notifyErrorListeners("Missing ident attribute in Ils element");

						}CLOSE ilsElements  CloseIls;

					ilsAttributes [boolean[] bools]: 
						latitude {if ($bools[0] == true) 
									notifyErrorListeners("Multiple latitude attribute in Ils element");
								else $bools[0] = true;}
						| longitude {if ($bools[1] == true) 
									notifyErrorListeners("Multiple longitude attribute in Ils element");
								else $bools[1] = true;}
						| altitude {if ($bools[2] == true) 
									notifyErrorListeners("Multiple altitude attribute in Ils element");
								else $bools[2] = true;}
						| heading {if ($bools[3] == true) 
									notifyErrorListeners("Multiple heading attribute in Ils element");
								else $bools[3] = true;}
						| frequency {if ($bools[4] == true) 
									notifyErrorListeners("Multiple frequency attribute in Ils element");
								else $bools[4] = true;}
						| end {if ($bools[5] == true) 
									notifyErrorListeners("Multiple end attribute in Ils element");
								else $bools[5] = true;}
						| range {if ($bools[6] == true) 
									notifyErrorListeners("Multiple range attribute in Ils element");
								else $bools[6] = true;}
						| magvar {if ($bools[7] == true) 
									notifyErrorListeners("Multiple magvar attribute in Ils element");
								else $bools[7] = true;}
						| ident {if ($bools[8] == true) 
									notifyErrorListeners("Multiple ident attribute in Ils element");
								else $bools[8] = true;}
						| width {if ($bools[9] == true) 
									notifyErrorListeners("Multiple width attribute in Ils element");
								else $bools[9] = true;}
						| ils_name {if ($bools[10] == true) 
									notifyErrorListeners("Multiple name attribute in Ils element");
								else $bools[10] = true;}
						| backCourse {if ($bools[11] == true) 
									notifyErrorListeners("Multiple backCourse attribute in Ils element");
								else $bools[11] = true;}; 
					
						ils_name returns[String value]: NAME stringLettersMixedCase DOUBLE_QUOTES{
							if ($stringLettersMixedCase.value.length() > 48){
								notifyErrorListeners("Ils name too long... Must have a maximum of 48 chars!");
								$value = "invalid_value";
							}
							else $value = $stringLettersMixedCase.value;
						} ; 

						range: RANGE floatingPointValue units_all? DOUBLE_QUOTES;

						backCourse: BACKCOURSE EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;

					ilsElements: glideSlope* dme*; 

						glideSlope:  OpenGlideSlope glideSlopeAttributes* SLASH_CLOSE;

							glideSlopeAttributes: latitude | longitude | altitude | pitch | range ;

						dme:  OpendDme dmeAttributes* SLASH_CLOSE;

							dmeAttributes: latitude | longitude | altitude | range;



  /* -----------------------------------------------------------*/
		


	start locals[boolean[] bools = {false, false, false, false, false, false, false}]: 
		OpenStart startAttributes[$bools]* {
				if (!$bools[1])
					notifyErrorListeners("Missing latitude attribute in Start element");
				if (!$bools[2])
					notifyErrorListeners("Missing longitude attribute in Start element");
				if (!$bools[3])
					notifyErrorListeners("Missing altitude attribute in Start element");
				if (!$bools[4])
					notifyErrorListeners("Missing heading attribute in Start element");

			}SLASH_CLOSE;

		startAttributes [boolean[] bools]: 
			type {if ($bools[0] == true) 
					notifyErrorListeners("Multiple type attribute in Start element");
				else $bools[0] = true;}
			| latitude {if ($bools[1] == true) 
					notifyErrorListeners("Multiple latitude attribute in Start element");
				else $bools[1] = true;}
			| longitude {if ($bools[2] == true) 
					notifyErrorListeners("Multiple longitude attribute in Start element");
				else $bools[2] = true;}
			| altitude {if ($bools[3] == true) 
					notifyErrorListeners("Multiple altitude attribute in Start element");
				else $bools[3] = true;}
			| heading {if ($bools[4] == true) 
					notifyErrorListeners("Multiple heading attribute in Start element");
				else $bools[4] = true;}
			| number {if ($bools[5] == true) 
					notifyErrorListeners("Multiple number attribute in Start element");
				else $bools[5] = true;}
			| designator {if ($bools[6] == true) 
					notifyErrorListeners("Multiple designator attribute in Start element");
				else $bools[6] = true;};

	helipad locals[boolean[] bools = {false, false, false, false, false, false, false, false, false, false, false, false, false, false}]: 
		OpenHelipad helipadAttributes[$bools]* {
			if (!$bools[1])
				notifyErrorListeners("Missing latitude attribute in Helipad Element");
			if(!$bools[2])
				notifyErrorListeners("Missing longitude attribute in Helipad Element");
			if(!$bools[3])
				notifyErrorListeners("Missing altitude attribute in Helipad Element");
			if(!$bools[4])
				notifyErrorListeners("Missing surface attribute in Helipad Element");
			if(!$bools[5])
				notifyErrorListeners("Missing heading attribute in Helipad Element");
			if(!$bools[6])
				notifyErrorListeners("Missing length attribute in Helipad Element");
			if (!$bools[7])
				notifyErrorListeners("Missing width attribute in Helipad Element");
			if (!$bools[8])
				notifyErrorListeners("Missing type attribute in Helipad Element");
		}SLASH_CLOSE ;

		helipadAttributes [boolean[] bools]: 
			latitude {if ($bools[1] == true) 
						notifyErrorListeners("Multiple latitude attribute in Helipad Element");
						else $bools[1] = true;}
			| longitude {if ($bools[2] == true) 
						notifyErrorListeners("Multiple longitude attribute in Helipad Element");
						else $bools[2] = true;}
			| altitude {if ($bools[3] == true) 
						notifyErrorListeners("Multiple altitude attribute in Helipad Element");
						else $bools[3] = true;}
			| surface {if ($bools[4] == true) 
						notifyErrorListeners("Multiple surface attribute in Helipad Element");
						else $bools[4] = true;}
			| heading {if ($bools[5] == true) 
							notifyErrorListeners("Multiple heading attribute in Helipad element");
						else $bools[5] = true;}
			| length {if ($bools[6] == true) 
							notifyErrorListeners("Multiple length attribute in Helipad element");
						else $bools[6] = true;}
			| width {if ($bools[7] == true) 
							notifyErrorListeners("Multiple width attribute in Helipad element");
						else $bools[7] = true;}
			| helipad_type {if ($bools[8] == true) 
							notifyErrorListeners("Multiple type attribute in Helipad element");
						else $bools[8] = true;}
			| closed {if ($bools[9] == true) 
							notifyErrorListeners("Multiple closed attribute in Helipad element");
						else $bools[9] = true;}
			| transparent {if ($bools[10] == true) 
							notifyErrorListeners("Multiple transparent attribute in Helipad element");
						else $bools[10] = true;}
			| red {if ($bools[11] == true) 
							notifyErrorListeners("Multiple red attribute in Helipad element");
						else $bools[11] = true;}
			| green {if ($bools[12] == true) 
							notifyErrorListeners("Multiple green attribute in Helipad element");
						else $bools[12] = true;}
			| blue {if ($bools[13] == true) 
							notifyErrorListeners("Multiple blue attribute in Helipad element");
						else $bools[13] = true;}; 

			helipad_type returns[String value]: 
				TYPE stringLettersMixedCase DOUBLE_QUOTES{
					String[] types = {"NONE", "CIRCLE", "H", "MEDICAL", "SQUARE"};
					int i = 0;
					for (i = 0;  i < types.length; i++){
						if ($stringLettersMixedCase.value.equals(types[i]))
							break;
					}
					if (i == types.length){
						notifyErrorListeners("Invalid Helipad type... Input:"+$stringLettersMixedCase.value);
						$value = "invalid_value";
					}
					else $value = $stringLettersMixedCase.value;
				};

			closed: CLOSED EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;

			transparent: TRANSPARENT EQUALS DOUBLE_QUOTES bool DOUBLE_QUOTES;

			red returns[int value]: RED integerValue DOUBLE_QUOTES{
				if ($integerValue.value < 0 || $integerValue.value > 255){
					String err = "Invalid red... Must be between 0 and 255... ";
					err = err + "input:" + $integerValue.value;
					notifyErrorListeners(err);
					$value = -1; // ???
				}
				else $value = $integerValue.value;
			};/*0-255*/

			green returns[int value]: GREEN integerValue DOUBLE_QUOTES{
				if ($integerValue.value < 0 || $integerValue.value > 255){
					String err = "Invalid green... Must be between 0 and 255... ";
					err = err + "input:" + $integerValue.value;
					notifyErrorListeners(err);
					$value = -1; // ???
				}
				else $value = $integerValue.value;
			};/*0-255*/

			blue returns[int value]: BLUE integerValue DOUBLE_QUOTES{
				if ($integerValue.value < 0 || $integerValue.value > 255){
					String err = "Invalid blue... Must be between 0 and 255... ";
					err = err + "input:" + $integerValue.value;
					notifyErrorListeners(err);
					$value = -1; // ???
				}
				else $value = $integerValue.value;
			};/*0-255*/

	com locals[boolean[] bools = {false, false, false}]: 
		OpenCom comAttributes[$bools]* {
				if (!$bools[0])
					notifyErrorListeners("Missing frequency attribute in Com element");
				if (!$bools[1])
					notifyErrorListeners("Missing type attribute in Com element");
				if (!$bools[2])
					notifyErrorListeners("Missing name attribute in Com element");
			}SLASH_CLOSE;

		comAttributes [boolean[] bools]: 
			frequency {if ($bools[0] == true) 
					notifyErrorListeners("Multiple frequency attribute in Com element");
				else $bools[0] = true;}
			| type {if ($bools[1] == true) 
					notifyErrorListeners("Multiple type attribute in Com element");
				else $bools[1] = true;}
			| name {if ($bools[2] == true) 
					notifyErrorListeners("Multiple name attribute in Com element");
				else $bools[2] = true;};

			/*nameCom: NAME EQUALS DOUBLE_QUOTES stringLettersMixedCase DOUBLE_QUOTES ;*/


////////////////////////////////////////////////////////////////////////////////////////////////
/* -------------------TAXIWAYPOINT -----------------------------------------------------------------*/
	taxiwayPoint locals[boolean[] bools = {false, false, false, false, false, false, false}]: 
		OpenTaxiwayPoint taxiwayPointAttributes[$bools]* {
				if (!$bools[0])
					notifyErrorListeners("Missing index attribute in TaxiwayPoint element");
				if (!$bools[1])
					notifyErrorListeners("Missing type attribute in TaxiwayPoint element");
				if (($bools[3] || $bools[4]) && ($bools[5] || $bools[6]))
					notifyErrorListeners("Choose between latitude/longitude and biasX/biasY attributes in TaxiwayPoint element");
				else{
					if (!$bools[5] && !$bools[6]){ //latitude and longitude chosen
						if (!$bools[3])
							notifyErrorListeners("Missing latitude attribute in TaxiwayPoint element");
						if (!$bools[4])
							notifyErrorListeners("Missing longitude attribute in TaxiwayPoint element");
					}
					else if (!!$bools[5] && !$bools[6]){
						if (!$bools[5])
							notifyErrorListeners("Missing biasX attribute in TaxiwayPoint element");
						if (!$bools[6])
							notifyErrorListeners("Missing biasY attribute in TaxiwayPoint element");
					}
					else{
						notifyErrorListeners("Missing latitude/longitude or biasX/biasY attributes in TaxiwayPoint element");
					}
				}

			}SLASH_CLOSE; 

		taxiwayPointAttributes [boolean[] bools]: 
			taxiway_index {if ($bools[0] == true) 
							notifyErrorListeners("Multiple index attribute in TaxiwayPoint element");
						else $bools[0] = true;}
			| taxiwaypoint_type {if ($bools[1] == true) 
							notifyErrorListeners("Multiple type attribute in TaxiwayPoint element");
						else $bools[1] = true;}
			| taxiway_orientation {if ($bools[2] == true) 
							notifyErrorListeners("Multiple orientation attribute in TaxiwayPoint element");
						else $bools[2] = true;}
			| latitude {if ($bools[3] == true) 
							notifyErrorListeners("Multiple latitude attribute in TaxiwayPoint element");
						else $bools[3] = true;}
			| longitude {if ($bools[4] == true) 
							notifyErrorListeners("Multiple longitude attribute in TaxiwayPoint element");
						else $bools[4] = true;}
			| biasX {if ($bools[5] == true) 
							notifyErrorListeners("Multiple biasX attribute in TaxiwayPoint element");
						else $bools[5] = true;}
			| biasY {if ($bools[6] == true) 
							notifyErrorListeners("Multiple biasY attribute in TaxiwayPoint element");
						else $bools[6] = true;};


		taxiwaypoint_type returns[String value]: TYPE stringLettersMixedCase DOUBLE_QUOTES{
							String[] types = {"NORMAL", "HOLD_SHORT", "ILS_HOLD_SHORT", "HOLD_SHORT_NO_DRAW", "ILS_HOLD_SHORT_NO_DRAW"};
							int i = 0;
							for (i = 0;  i < types.length; i++){
								if ($stringLettersMixedCase.value.equals(types[i]))
									break;
							}
							if (i == types.length){
								notifyErrorListeners("Invalid taxiway point type... Input:"+$stringLettersMixedCase.value);
								$value = "invalid_value";
							}
							else $value = $stringLettersMixedCase.value;
						};

			taxiway_index returns[int index]: INDEX integerValue DOUBLE_QUOTES
									{
										if ($integerValue.value < 0 || $integerValue.value > 3999){
											String err = "Invalid index... Must be between 0 and 3999... ";
											err = err + "input:" + $integerValue.value;
											notifyErrorListeners(err);
											$index = -1; // ???
										}
										else{
											$index = $integerValue.value;
											taxiwaypoint_indexes.add($index);
										}

									}; /*0-3999*/
			taxiway_orientation: ORIENTATION ORIENTATIONTYPE DOUBLE_QUOTES; 

	/*-------------------------------TaxiwayParking-----------------------------------------------------*/
	taxiwayParking locals[boolean[] bools = {false, false, false, false, false, false, false, false, false, false, false, false, false}]: 
		OpenTaxiwayParking taxiwayParkingAttributes[$bools]* {
				if (!$bools[0])
					notifyErrorListeners("Missing index attribute in TaxiwayParking element");
				if (!$bools[1])
					notifyErrorListeners("Missing type attribute in TaxiwayParking element");
				if (($bools[1] || $bools[2]) && ($bools[3] || $bools[4]))
					notifyErrorListeners("Choose between latitude/longitude and biasX/biasY attributes in TaxiwayParking element");
				else{
					if (!$bools[3] && !$bools[4]){ //latitude and longitude chosen
						if (!$bools[1])
							notifyErrorListeners("Missing latitude attribute in TaxiwayParking element");
						if (!$bools[2])
							notifyErrorListeners("Missing longitude attribute in TaxiwayParking element");
					}
					else if (!!$bools[3] && !$bools[4]){
						if (!$bools[3])
							notifyErrorListeners("Missing biasX attribute in TaxiwayParking element");
						if (!$bools[4])
							notifyErrorListeners("Missing biasY attribute in TaxiwayParking element");
					}
					else{
						notifyErrorListeners("Missing latitude/longitude or biasX/biasY attributes in TaxiwayParking element");
					}
				}
				if (!$bools[5])
					notifyErrorListeners("Missing heading attribute in TaxiwayParking element");
				if (!$bools[6])
					notifyErrorListeners("Missing radius attribute in TaxiwayParking element");
				if (!$bools[7])
					notifyErrorListeners("Missing type attribute in TaxiwayParking element");
				if (!$bools[8])
					notifyErrorListeners("Missing name attribute in TaxiwayParking element");
				if (!$bools[9])
					notifyErrorListeners("Missing number attribute in TaxiwayParking element");
				if (!$bools[11])
					notifyErrorListeners("Missing pushBack attribute in TaxiwayParking element");

			}SLASH_CLOSE; 

		taxiwayParkingAttributes [boolean[] bools]: 
			taxiwayparking_index {if ($bools[0] == true) 
							notifyErrorListeners("Multiple index attribute in TaxiwayParking element");
						else $bools[0] = true;}
			| latitude {if ($bools[1] == true) 
							notifyErrorListeners("Multiple latitude attribute in TaxiwayParking element");
						else $bools[1] = true;}
			| longitude {if ($bools[2] == true) 
							notifyErrorListeners("Multiple longitude attribute in TaxiwayParking element");
						else $bools[2] = true;}
			| biasX {if ($bools[3] == true) 
							notifyErrorListeners("Multiple biasX attribute in TaxiwayParking element");
						else $bools[3] = true;}
			| biasY {if ($bools[4] == true) 
							notifyErrorListeners("Multiple biasY attribute in TaxiwayParking element");
						else $bools[4] = true;}
			| heading {if ($bools[5] == true) 
							notifyErrorListeners("Multiple heading attribute in TaxiwayParking element");
						else $bools[5] = true;}
			| taxiway_radius {if ($bools[6] == true) 
							notifyErrorListeners("Multiple radius attribute in TaxiwayParking element");
						else $bools[6] = true;}
			| taxiwayparking_type {if ($bools[7] == true) 
							notifyErrorListeners("Multiple type attribute in TaxiwayParking element");
						else $bools[7] = true;}
			| taxiwayparking_name {if ($bools[8] == true) 
							notifyErrorListeners("Multiple name attribute in TaxiwayParking element");
						else $bools[8] = true;}
			| taxiway_number {if ($bools[9] == true) 
							notifyErrorListeners("Multiple number attribute in TaxiwayParking element");
						else $bools[9] = true;}
			| taxiway_airlineCodes {if ($bools[10] == true) 
							notifyErrorListeners("Multiple airlineCodes attribute in TaxiwayParking element");
						else $bools[10] = true;}
			| taxiway_pushBack {if ($bools[11] == true) 
							notifyErrorListeners("Multiple pushBack attribute in TaxiwayParking element");
						else $bools[11] = true;}
			| taxiway_teeOffset+; //pode ter vários offsets


			taxiwayparking_index returns[int index]: INDEX integerValue DOUBLE_QUOTES
					{
						if ($integerValue.value < 0 || $integerValue.value > 3999){
							String err = "Invalid index... Must be between 0 and 3999... ";
							err = err + "input:" + $integerValue.value;
							notifyErrorListeners(err);
							$index = -1; // ???
						}
						else {
							$index = $integerValue.value;
							taxiwayparking_indexes.add($index);
						}

					}; /*0-3999*/

			taxiway_radius: RADIUS floatingPointValue units_all? DOUBLE_QUOTES;
			taxiwayparking_type returns[String value]: TYPE stringLettersMixedCase DOUBLE_QUOTES{
							String[] types = {"NONE", "DOCK_GA", "FUEL", "GATE_HEAVY", "GATE_MEDIUM", "GATE_SMALL", "RAMP_CARGO", 
											"RAMP_GA", "RAMP_GA_LARGE", "RAMP_GA_MEDIUM", "RAMP_GA_SMALL", "RAMP_MIL_CARGO", "RAMP_MIL_COMBAT", "VEHICLE"};
							int i = 0;
							for (i = 0;  i < types.length; i++){
								if ($stringLettersMixedCase.value.equals(types[i]))
									break;
							}
							if (i == types.length){
								notifyErrorListeners("Invalid taxiway parking type... Input:"+$stringLettersMixedCase.value);
								$value = "invalid_value";
							}
							else $value = $stringLettersMixedCase.value;
						};
			taxiwayparking_name returns[String value]: NAME stringLettersMixedCase DOUBLE_QUOTES{
							String[] types = {"PARKING", "DOCK", "GATE", "GATE_A", "GATE_B", "GATE_C", "GATE_D", "GATE_E", "GATE_F", "GATE_G", 
							"GATE_H", "GATE_I", "GATE_J", "GATE_K", "GATE_L", "GATE_M", "GATE_N", "GATE_O", "GATE_P", "GATE_Q", "GATE_R", "GATE_S", 
							"GATE_T", "GATE_U", "GATE_V", "GATE_W", "GATE_X", "GATE_Y", "GATE_Z", "NONE", "N_PARKING", "NE_PARKING", "NW_PARKING", 
							"SE_PARKING", "S_PARKING", "SW_PARKING", "W_PARKING", "E_PARKING"};
							int i = 0;
							for (i = 0;  i < types.length; i++){
								if ($stringLettersMixedCase.value.equals(types[i]))
									break;
							}
							if (i == types.length){
								notifyErrorListeners("Invalid taxiway parking name... Input:"+$stringLettersMixedCase.value);
								$value = "invalid_value";
							}
							else $value = $stringLettersMixedCase.value;
						};
			taxiway_number: NUMBER NUMBER_VALUES DOUBLE_QUOTES;/*0-3999 TODO*/
			taxiway_airlineCodes: AIRLINECODES AIRLINECODESVALUES DOUBLE_QUOTES;
			taxiway_pushBack: PUSHBACK PUSHBACKVALUES DOUBLE_QUOTES;
			taxiway_teeOffset: TEEOFFSET floatingPointValue DOUBLE_QUOTES;/*0.1-50.0 TODO*/

	/*--------------------------------------TAXINAME-------------------------------*/
	taxiName locals[boolean[] bools = {false, false}]: 
		OpenTaxiName taxiNameAttributes[$bools]* {
				if (!$bools[0])
					notifyErrorListeners("Missing index attribute in TaxiName element");
				if (!$bools[1])
					notifyErrorListeners("Missing name attribute in TaxiName element");
			} SLASH_CLOSE;

		taxiNameAttributes [boolean[] bools]: 
			taxiNameIndex {if ($bools[0] == true) 
							notifyErrorListeners("Multiple index attribute in TaxiName element");
						else $bools[0] = true;}
			| taxiNameName {if ($bools[1] == true) 
							notifyErrorListeners("Multiple name attribute in TaxiName element");
						else $bools[1] = true;};

			taxiNameIndex returns[int index]: INDEX integerValue DOUBLE_QUOTES
							{
								if ($integerValue.value < 0 || $integerValue.value > 255){
									String err = "Invalid index... Must be between 0 and 255... ";
									err = err + "input:" + $integerValue.value;
									notifyErrorListeners(err);
									$index = -1; // ???
								}
								else $index = $integerValue.value;

							};/*0-255*/

			taxiNameName returns[String value]: NAME stringLettersMixedCase? DOUBLE_QUOTES{
				if($stringLettersMixedCase.text == null) $value = "";
				else if($stringLettersMixedCase.value.length() > 8) {
					notifyErrorListeners("TaxiName name too long... Must have a maximum of 8 chars!");
					$value = "invalid_value";
				}
				else $value = $stringLettersMixedCase.value;
			};

	/*-----------------------------------------------------TAXIWAYPATH-----------------------------------------*/
	taxiwayPath locals[boolean[] bools = {false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false}]: 
		OpenTaxiwayPath taxiwayPathAttributes[$bools]* {
				if (!$bools[0])
					notifyErrorListeners("Missing type attribute in TaxiwayPath element");
				if (!$bools[1])
					notifyErrorListeners("Missing start attribute in TaxiwayPath element");
				if (!$bools[2])
					notifyErrorListeners("Missing end attribute in TaxiwayPath element");
				if (!$bools[3])
					notifyErrorListeners("Missing width attribute in TaxiwayPath element");
				if (!$bools[4])
					notifyErrorListeners("Missing weightLimit attribute in TaxiwayPath element");
				if (!$bools[5])
					notifyErrorListeners("Missing surface attribute in TaxiwayPath element");
				/*if (!$bools[6])
					notifyErrorListeners("Missing drawSurface attribute in TaxiwayPath element");
				if (!$bools[7])
					notifyErrorListeners("Missing drawDetail attribute in TaxiwayPath element");*/
				/*if (!$bools[14])
					notifyErrorListeners("Missing number attribute in TaxiwayPath element");
				if (!$bools[15])
					notifyErrorListeners("Missing designator attribute in TaxiwayPath element");
				if (!$bools[16])
					notifyErrorListeners("Missing name attribute in TaxiwayPath element");*/
			}SLASH_CLOSE;

		taxiwayPathAttributes [boolean[] bools]: 
			type {if ($bools[0] == true) 
					notifyErrorListeners("Multiple type attribute in TaxiwayPath element");
				else $bools[0] = true;}
			| taxiway_start {if ($bools[1] == true) 
					notifyErrorListeners("Multiple start attribute in TaxiwayPath element");
				else $bools[1] = true;}
			| taxiway_end {if ($bools[2] == true) 
					notifyErrorListeners("Multiple end attribute in TaxiwayPath element");
				else $bools[2] = true;}
			| width {if ($bools[3] == true) 
					notifyErrorListeners("Multiple width attribute in TaxiwayPath element");
				else $bools[3] = true;}
			| taxiway_weightLimit {if ($bools[4] == true) 
					notifyErrorListeners("Multiple weightLimit attribute in TaxiwayPath element");
				else $bools[4] = true;}
			| surface {if ($bools[5] == true) 
					notifyErrorListeners("Multiple surface attribute in TaxiwayPath element");
				else $bools[5] = true;}
			| drawSurface {if ($bools[6] == true) 
					notifyErrorListeners("Multiple drawSurface attribute in TaxiwayPath element");
				else $bools[6] = true;}
			| drawDetail {if ($bools[7] == true) 
					notifyErrorListeners("Multiple drawDetail attribute in TaxiwayPath element");
				else $bools[7] = true;}
			| taxiway_centerLine {if ($bools[8] == true) 
					notifyErrorListeners("Multiple centerLine attribute in TaxiwayPath element");
				else $bools[8] = true;}
			| taxiway_centerLineLighted {if ($bools[9] == true) 
					notifyErrorListeners("Multiple centerLineLighted attribute in TaxiwayPath element");
				else $bools[9] = true;}
			| taxiway_leftEdge {if ($bools[10] == true) 
					notifyErrorListeners("Multiple leftEdge attribute in TaxiwayPath element");
				else $bools[10] = true;}
			| taxiway_leftEdgeLighted {if ($bools[11] == true) 
					notifyErrorListeners("Multiple leftEdgeLighted attribute in TaxiwayPath element");
				else $bools[11] = true;}
			| taxiway_rightEdge {if ($bools[12] == true) 
					notifyErrorListeners("Multiple rightEdge attribute in TaxiwayPath element");
				else $bools[12] = true;}
			| taxiway_rightEdgeLighted {if ($bools[13] == true) 
					notifyErrorListeners("Multiple rightEdgeLighted attribute in TaxiwayPath element");
				else $bools[13] = true;}
			| taxiway_number {if ($bools[14] == true) 
					notifyErrorListeners("Multiple number attribute in TaxiwayPath element");
				else $bools[14] = true;}
			| designator {if ($bools[15] == true) 
					notifyErrorListeners("Multiple designator attribute in TaxiwayPath element");
				else $bools[15] = true;}
			| taxiwaypath_name {if ($bools[16] == true) 
					notifyErrorListeners("Multiple name attribute in TaxiwayPath element");
				else $bools[16] = true;};

			taxiwaypath_type returns[String value]: TYPE stringLettersMixedCase DOUBLE_QUOTES{
							String[] types = {"RUNWAY", "PARKING", "TAXI", "PATH", "CLOSED", "VEHICLE"};
							int i = 0;
							for (i = 0;  i < types.length; i++){
								if ($stringLettersMixedCase.value.equals(types[i]))
									break;
							}
							if (i == types.length){
								notifyErrorListeners("Invalid taxiway path type... Input:"+$stringLettersMixedCase.value);
								$value = "invalid_value";
							}
							else $value = $stringLettersMixedCase.value;
						};
			
			taxiway_start returns[int value]: START integerValue DOUBLE_QUOTES{
					if ($integerValue.value < 0 || $integerValue.value > 3999){
						String err = "Invalid index... Must be between 0 and 3999... ";
						err = err + "input:" + $integerValue.value;
						notifyErrorListeners(err);
						$value = -1; // ???
					}
					else if (!taxiway_index_is_defined($integerValue.value)){
						notifyErrorListeners("No taxiway point with index "+$integerValue.value);
						$value = -1; // ???
					}
					else $value = $integerValue.value;

				};/*0-3999*/
		
			taxiway_end returns[int value]: END INT_NUMBER2 DOUBLE_QUOTES{
					int temp = Integer.parseInt($INT_NUMBER2.text);
					if (temp < 0 || temp > 3999){
						String err = "Invalid index... Must be between 0 and 3999... ";
						err = err + "input:" + temp;
						notifyErrorListeners(err);
						$value = -1; // ???
					}
					else if (!taxiway_index_is_defined(temp)){
						notifyErrorListeners("No taxiway point with index "+temp);
						$value = -1; // ???
					}
					else $value = temp;
				}; /*0-3999*/
			
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
			
			taxiwaypath_name returns[int value]: NAME stringLettersMixedCase DOUBLE_QUOTES {
					int i = Integer.parseInt($stringLettersMixedCase.value);
						if (i < 0 || i > 255){
							String err = "Invalid taxiway path name... Must be between 0 and 255... ";
							err = err + "input:" + i;
							notifyErrorListeners( err );
							$value = -1;
						}
						else $value = i;
					};


	jetway locals[boolean[] bools = {false, false}]: 
		OpenJetway jetwayAttributes[$bools]* {
				if (!$bools[0])
					notifyErrorListeners("Missing gateName attribute in Jetway element");
				if (!$bools[1])
					notifyErrorListeners("Missing parkingNumber attribute in Jetway element");
			}CLOSE jetwayElements CloseJetway;

		jetwayAttributes [boolean[] bools]: 
			gateName {if ($bools[0]) 
					notifyErrorListeners("Multiple gateName attribute in Jetway element");
				else $bools[0] = true;}
			| parkingNumber {if ($bools[1]) 
					notifyErrorListeners("Multiple parkingNumber attribute in Jetway element");
				else $bools[1] = true;};

			gateName: GATENAME GATENAME_WORDS DOUBLE_QUOTES;

			parkingNumber: PARKINGNUMBER integerValue DOUBLE_QUOTES;

		jetwayElements: ;

	aprons: StartAprons apron* CloseAprons;

		apron: OpenApron apronAttributes* CLOSE vertex* EndApron;

			apronAttributes: surface | drawSurface | drawDetail;

			vertex: OpenVertex vertexAttributes* SLASH_CLOSE;

				vertexAttributes: latitude | longitude | biasX | biasY;

	apronEdgeLights: StartApronEdgeLights apronEdgeLightsElements EndApronEdgeLights;

		apronEdgeLightsElements: edgeLights* ;

			edgeLights: StartEdgeLights vertex* EndEdgeLights;

	/* TODO taxiwaySign: OpenTaxiwaySign taxiwaySignAttributes SLASH_CLOSE;

		taxiwaySignAttributes: latitude longitude heading; */


	boundaryFence : OpenBoundaryFence boundaryFenceAttributes* CLOSE boundaryFenceElements* CloseBoundaryFence;

		boundaryFenceAttributes: instanceId | profile  ;
		  
			instanceId: INSTANCE_ID GUID DOUBLE_QUOTES; 

			profile: PROFILE GUID DOUBLE_QUOTES;

		boundaryFenceElements: vertex vertex vertex* ;


	blastFence : OpenBlastFence blastFenceAttributes* SLASH_CLOSE blastFenceElements* CloseBlastFence;

		blastFenceAttributes: instanceId | profile  ;

		blastFenceElements: vertex vertex vertex* ;


	waypoint locals[boolean[] bools = {false, false, false, false, false, false}]: 
		OpenWaypoint waypointAttributes[$bools]* {
				if (!$bools[0])
					notifyErrorListeners("Missing latitude attribute in Waypoint element");
				if (!$bools[1])
					notifyErrorListeners("Missing longitude attribute in Waypoint element");
				if (!$bools[2])
					notifyErrorListeners("Missing waypointType attribute in Waypoint element");
				if (!$bools[3])
					notifyErrorListeners("Missing magvar attribute in Waypoint element");
				if (!$bools[4])
					notifyErrorListeners("Missing waypointRegion attribute in Waypoint element");
				if (!$bools[5])
					notifyErrorListeners("Missing waypointIdent attribute in Waypoint element");
			}CLOSE waypointElements EndWaypoint;

		waypointAttributes [boolean[] bools]: 
			latitude {if ($bools[0]) 
					notifyErrorListeners("Multiple latitude attribute in Waypoint element");
				else $bools[0] = true;}
			| longitude {if ($bools[1]) 
					notifyErrorListeners("Multiple longitude attribute in Waypoint element");
				else $bools[1] = true;}
			| waypointType {if ($bools[2]) 
					notifyErrorListeners("Multiple waypointType attribute in Waypoint element");
				else $bools[2] = true;}
			| magvar {if ($bools[3]) 
					notifyErrorListeners("Multiple magvar attribute in Waypoint element");
				else $bools[3] = true;}
			| waypointRegion {if ($bools[4]) 
					notifyErrorListeners("Multiple waypointRegion attribute in Waypoint element");
				else $bools[4] = true;}
			| waypointIdent {if ($bools[5]) 
					notifyErrorListeners("Multiple waypointIdent attribute in Waypoint element");
				else $bools[5] = true;};

			waypointType: WAYPOINTTYPE WAYPOINTTYPE_WORDS DOUBLE_QUOTES;

			waypointRegion: WAYPOINTREGION stringLettersMixedCase DOUBLE_QUOTES;

			waypointIdent: WAYPOINTIDENT stringLettersMixedCase DOUBLE_QUOTES;

		waypointElements: route* ;

			route: OpenRoute routeAttributes* CLOSE routeElements EndRoute;

				routeAttributes: routeType | route_name ;

					routeType: ROUTETYPE ROUTETYPE_WORDS DOUBLE_QUOTES ; 

					route_name returns[String value]: NAME stringLettersMixedCase DOUBLE_QUOTES{
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