package classes;

import java.util.ArrayList;

public class StartEndPoint {
	
	private boolean start; //true if start, false if end
	private Coordinates coordinates;
	private ArrayList<String> connectsTo;
	
	StartEndPoint(String t){
		if (t.equals("start"))
			start = true;
		else start  = false;
		
		coordinates = new Coordinates();
		connectsTo = new ArrayList<String>();
	}
	
	public String connectsToSDL(String offset){
		String msg = offset+"<connectsTo>\n";
		
		for(String s : connectsTo){
			msg += offset+"	"+ "<xway idr=\""+s+"\" />\n";
		}
		
		msg += offset+"</connectsTo>\n";
		return msg;
	}
	
	
	public String toSDL(String offset){
		String msg = 
				offset+ ((start)? "<startpoint>" : "<endpoint>")+"\n"+
						coordinates.toSDL(offset+"	")+
						connectsToSDL(offset+"	")+
				offset+ ((start)? "</startpoint>" : "</endpoint>")+"\n";
		return msg;
	}
	
	
	public void addConnectsTo(String c){
		getConnectsTo().add(c);
	}

	public Coordinates getCoordinates() {
		return coordinates;
	}

	public void setCoordinates(Coordinates coordinates) {
		this.coordinates = coordinates;
	}

	public ArrayList<String> getConnectsTo() {
		return connectsTo;
	}


}