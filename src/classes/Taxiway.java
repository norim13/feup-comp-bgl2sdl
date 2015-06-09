package classes;

import java.util.ArrayList;

public class Taxiway{
	
	/*public static int id_count = 0;
	
	public static int getNextId(){
		return id_count++;
	}*/
	
	public String designation, surface, width, widthUnits, type, number;
	public ArrayList<TaxiwayPointParking> path;
	public String id;

	/**
	 * 
	 * @param finalTaxiway -> if true, constructor will generate final id (based on static counter id_c), if false, id will be negative.
	 */
	public Taxiway(){
		path = new ArrayList<TaxiwayPointParking>();
		designation = "XXXXX"; //TODO fetch this data in TaxiName
		surface = "XXXXX";
		width = "XXX";
		widthUnits="Meters";
		type="XXXXXX";
		id = "XXXX";
		number = "XXXX";
	}
	
	
	public String generatePointsSequence(String offset){
		String msg = "";
		
		msg += offset+"<startpoint>\n"+
				path.get(0).getCoordinates().toSDL(offset+"	")+
				offset+"	<connectsTo>\n"+
					path.get(0).printConnections(offset+"		", this.id)+
				offset+"	</connectsTo>\n"+
			offset+"</startpoint>\n";
		
		if (path.size() > 2){
			for (int i = 1;  i < path.size()-1; i++){
				msg += offset+"<midpoint>\n"+
						path.get(i).getCoordinates().toSDL(offset+"	")+
						offset+"	<connectsTo>\n"+
							path.get(i).printConnections(offset+"		", this.id)+
						offset+"	</connectsTo>\n"+
					offset+"</midpoint>\n";
			}
		}
		
		msg += offset+"<endpoint>\n"+
				path.get(path.size()-1).getCoordinates().toSDL(offset+"	")+
				offset+"	<connectsTo>\n"+
					path.get(path.size()-1).printConnections(offset+"		", this.id)+
				offset+"	</connectsTo>\n"+
			offset+"</endpoint>\n";

		return msg;
		
	}
	
	public String generateStartpointSDL(String offset){
		String msg = "";
		
		msg += offset+"<startpoint>\n"+
				path.get(0).getCoordinates().toSDL(offset+"	")+
				offset+"	<connectsTo>\n"+
					path.get(0).printConnections(offset+"		", this.id)+
				offset+"	</connectsTo>\n"+
			offset+"</startpoint>\n";
		return msg;
	}
	
	public String generateEndpointSDL(String offset){
		String msg = "";
		msg += offset+"<endpoint>\n"+
				path.get(path.size()-1).getCoordinates().toSDL(offset+"	")+
				offset+"	<connectsTo>\n"+
					path.get(path.size()-1).printConnections(offset+"		", this.id)+
				offset+"	</connectsTo>\n"+
			offset+"</endpoint>\n";

		return msg;
	}
	
	public String toSDL(String offset){
		String msg ="";
		msg += 
				offset+"<taxiway id=\""+ this.id +"\" >\n"+
					offset+"	<designation>Taxiway "+this.designation+"</designation>\n"+
					offset+"	<surface>"+this.surface+"</surface>\n"+
					offset+"	<width lengthUnit=\""+widthUnits+"\" >"+width+"</width>\n"+
					offset+"	<path>\n"+
					generatePointsSequence(offset+"		")+
					offset+"	</path>\n"+
				offset+"</taxiway>\n";
					
		return msg;
	}
	
	
	public String getDesignation() {
		return designation;
	}

	public void setDesignation(String designation) {
		this.designation = designation;
	}

	public String getSurface() {
		return surface;
	}

	public void setSurface(String surface) {
		this.surface = surface;
	}

	public String getWidth() {
		return width;
	}

	public void setWidth(String width) {
		this.width = width;
	}

	public String getWidthUnits() {
		return widthUnits;
	}

	public void setWidthUnits(String altU) {
		switch(altU){
		case "M": this.widthUnits = "Meter"; break;
		case "N": this.widthUnits = "Nautical Mile"; break;
		case "F": this.widthUnits = "Foot"; break;
		}		
	}

	public ArrayList<TaxiwayPointParking> getPath() {
		return path;
	}

	public void setPath(ArrayList<TaxiwayPointParking> path) {
		this.path = path;
		//path.get(0).getIndex()
	}


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public void setIdRunway() {
		this.setId("r"+path.get(0).getIndex()+"-"+path.get(path.size()-1).getIndex());
		
	}


	public String getNumber() {
		return number;
	}


	public void setNumber(String number) {
		this.number = number;
	}



	
	
}