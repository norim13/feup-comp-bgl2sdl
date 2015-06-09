package classes;

public class Coordinates {

	public String latitude, longitude, altitude;
	
	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public String getAltitude() {
		return altitude;
	}

	public void setAltitude(String altitude) {
		this.altitude = altitude;
	}

	public String getMeasured() {
		return measured;
	}

	public void setMeasured(String measured) {
		this.measured = measured;
	}

	public String measured, altUnits;
	
	
	public Coordinates() {
		latitude = "XXX";
		longitude = "XXX";
		altitude = "XXX";
		measured = "amsl";
		altUnits = "XX";

	}
	
	public String getAltUnits() {
		return altUnits;
	}

	public void setAltUnits(String altU) {
		switch(altU){
		case "M": this.altUnits = "Meter"; break;
		case "N": this.altUnits = "Nautical Mile"; break;
		case "F": this.altUnits = "Foot"; break;
		}
		
	}

	public String toSDL(String offset){
		String ret = 
		offset+"<coordinates>\n"+
			offset+"	<latitude>"+latitude+"</latitude>\n"+
			offset+"	<longitude>"+longitude+"</longitude>\n"+
			offset+"	<altitude measured=\""+measured+"\""+
				(altUnits == null? "" : (" lengthUnit=\""+altUnits+"\""))
						+ ">"+altitude+"</altitude>\n"+
		offset+"</coordinates>\n";
		
		return ret;
	}
}


/**
<xs:attributeGroup name="lengthUnitGroup">
<xs:attribute name="lengthUnit" use="required">
<xs:simpleType>
<xs:restriction base="xs:string">
<xs:enumeration value="Nautical Mile"/>
<xs:enumeration value="Mile (Statute)"/>
<xs:enumeration value="Kilometer"/>
<xs:enumeration value="Inch"/>
<xs:enumeration value="Centimeter"/>
<xs:enumeration value="Meter"/>
<xs:enumeration value="Foot"/>
</xs:restriction>
</xs:simpleType>
</xs:attribute>
</xs:attributeGroup>


*/