package classes;

public class Helipad {
	public Coordinates coordinates;
	public String designation, radius, radiusUnit;
	public String surface, id, type;
	
	public static int idCount = 1;
	
	public static int getNextId(){
		return idCount++;
	}
	
	public Helipad(){
		designation = "XXXXXXX";
		coordinates = new Coordinates();
		surface="XXXXXXX";
		radius = "XXXXX";
		radiusUnit = "Meter";
		id = "h"+String.valueOf(Helipad.getNextId()); 
	}
	
	public String toSDL(String offset){
		String msg = 
				offset+"<helipad id=\""+ id +"\" >\n"+
						coordinates.toSDL(offset+"	")+
						offset+"	<designation>"+designation+"</designation>\n"+
						offset+"	<surface>"+surface+"</surface>\n"+
						offset+"	<radius lengthUnit=\""+this.radiusUnit+"\">"+radius+"</radius>\n"+
				offset+"</helipad>\n";
		return msg;
	}
	
	public Coordinates getCoordinates() {
		return coordinates;
	}

	public void setCoordinates(Coordinates coordinates) {
		this.coordinates = coordinates;
	}

	public String getSurface() {
		return surface;
	}

	public void setSurface(String surface) {
		String first = surface.substring(0, 1);
		String rem = surface.substring(1, surface.length());
		this.surface = first.toUpperCase()+rem.toLowerCase();
		
		//Concrete, Grass, Water, Grass_bumpy, Asphalt, Short_grass, Long_grass, Hard_turf, 
		//Snow, Ice, Urban, Forest, Dirt, Coral, Gravel, Oil_treated, Steel_mats, Bituminus, 
		//Brick, Macadam, Planks, Sand, Shale, Tarmac, Wood, Cement
	}

	public String getRadius() {
		return radius;
	}

	public void setRadius(String radius) {
		this.radius = radius;
	}

	public String getRadiusUnit() {
		return radiusUnit;
	}


	public void setRadiusUnit(String altU) {
		switch(altU){
		case "M": this.radiusUnit = "Meter"; break;
		case "N": this.radiusUnit = "Nautical Mile"; break;
		case "F": this.radiusUnit = "Foot"; break;
		}		
	}

	public void calculateRadius(String length) {
		this.radius = ""+Double.parseDouble(length)/2.0;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}	
}