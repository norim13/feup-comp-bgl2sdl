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

	public String measured;
	
	
	public Coordinates() {
		latitude = "XXX";
		longitude = "XXX";
		altitude = "XXX";
		measured = "XXX";

	}
	
	public String toSDL(String offset){
		String ret = 
		offset+"<coordinates>\n"+
			offset+"	<latitude>"+latitude+"</latitude>\n"+
			offset+"	<longitude>"+longitude+"</longitude>\n"+
			offset+"	<altitude measured=\""+measured+"\">"+altitude+"<altitude>\n"+
		offset+"</coordinates>\n";
		
		return ret;
	}
}