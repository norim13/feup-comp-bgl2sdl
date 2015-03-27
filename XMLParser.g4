parser grammar XMLParser;

options { tokenVocab=XMLLexer; }

document    :  airport;



airport: OpenAirport airportAttributes* CLOSE  EndAirport; 



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

region: REGION EQUALS STRING_LETTERS ; /* String (48 characters max) */
country: COUNTRY EQUALS STRING_LETTERS ; /* String (48 characters max) */
state: STATE EQUALS STRING_LETTERS ; /* String (48 characters max) */
city: CITY EQUALS STRING_LETTERS ; /* String (48 characters max) */
name: NAME EQUALS STRING_LETTERS ; /* String (48 characters max) */

latitude: LAT EQUALS DOUBLE_QUOTES floatingPointValue DOUBLE_QUOTES ;
									 	/* 	-90 to +90 degrees 
											Format can be decimal or degrees-minutes-seconds
										*/
longitude: LON EQUALS DOUBLE_QUOTES floatingPointValue DOUBLE_QUOTES; 
										/* 	-180 to +180 degrees 
											Format can be decimal or degrees-minutes-seconds
										*/
altitude: ALT EQUALS DOUBLE_QUOTES floatingPointValue (Meters | Feet) DOUBLE_QUOTES;
										 /* 	Any floating point value. Altitude may 
												be suffixed by 'M' or 'F' to designate 
												meters or feet. Default is meters. */

magvar:  MAGVAR EQUALS DOUBLE_QUOTES floatingPointValue DOUBLE_QUOTES ;
											 /* -360.0 to 360.0 floating point value. 
												Default = 0.0. East magvar is negative, West magvar is positive. */

ident: IDENT EQUALS STRING_LETTERS ; /*  	String (4 characters max)*/
airportTestRadius: AIRPORTTESTRADIUS EQUALS DOUBLE_QUOTES IntegerValue (Meters | Feet | NauticalMiles) DOUBLE_QUOTES ; 
														/*  	Distance in feet, meters or 
															Nautical miles (F, M, N suffix).
														*/

trafficScalar: TRAFFICSCALAR EQUALS DOUBLE_QUOTES floatingPointValue DOUBLE_QUOTES ; 
														/* Value between 0.01 and 1.0. */


floatingPointValue: FloatingPointValue | IntegerValue ;

