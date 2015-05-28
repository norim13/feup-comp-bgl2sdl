package classes;

public class Coordinates {

	public String latitude, longitude, altitude;
	public String measured;
	
	
	public Coordinates() {
		latitude = "XXX";
		longitude = "XXX";
		altitude = "XXX";
		measured = "XXX";

	}
	
	public String toSDL(){
		String ret = 
		"<coordinates>"+
			"<latitude>"+latitude+"</latitude>"+
			"<longitude>"+longitude+"</longitude>"+
			"<altitude measured=\""+measured+"\">"+altitude+"<altitude>"+
		"</coordinates>";
		
		return ret;
	}
}