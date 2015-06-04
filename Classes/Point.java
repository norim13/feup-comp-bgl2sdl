package classes;

import java.util.ArrayList;

public class Point {

	public Coordinates coordinates;
	public ArrayList<String> connectsTo;
	public String start_or_end;
	
	
	public Point(String s) {
		coordinates = new Coordinates();
		connectsTo = new ArrayList<String>();
		start_or_end = s;
	}
	
	public String toSDL(String offset){
		String ret = 
		"<"+start_or_end+"point>"+
			coordinates.toSDL(offset+"	")+connectsToToSDL()+			
		"</"+start_or_end+"point>";
		
		return ret;
	}

	public String connectsToToSDL() {
		String temp = "<connectsTo>";

		for(String s: connectsTo) {
			temp += s;
		}

		temp += "</connectsTo>";
		return temp;
	}

	public void addConnectsTo(String idr) {
		connectsTo.add("<xway idr=\""+idr+"\"/>");
	}
}