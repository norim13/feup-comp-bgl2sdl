package classes;

public class Helipad {
	public Coordinates coordinates;
	public String designation, radius;
	public String surface, id;
	
	public Runway(){
		
		coordinates = new Coordinates();
		surface="XXXXXXX";
		radius = "XXXXX";

		id = "XXXXX"; //TODO ID sequencial (por static provavelmente)
	}
	
	public String toSDL(String offset){
		String msg = 
				offset+"<helipad id=\""+ id +"\" >\n"+
						coordinates.toSDL(offset+"	")+
						offset+"	<designation>"+designation+"</designation>\n"+
						offset+"	<surface>"+surface+"</surface>\n"+
						offset+"	<radius>"+radius+"</radius>\n"+
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
		this.surface = surface;
	}

	public String getRadius() {
		return radius;
	}

	public void setRadius(String radius) {
		this.radius = radius;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}	
}