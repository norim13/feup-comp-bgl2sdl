package classes;

public class Tower {

	public String id,designation,radius,height;

	public Coordinate coordinate;

	public Tower() {
		id="XXX Id XXX";
		designation="XXX Designation XXX";
		radius="XXX Radius XXX";
		height="XXX Height XXX";
		coordinate= new Coordinate();
	}

	public String toSDL(){
		String ret = 
		"<tower id="+id+">"+
			"<designation>"+designation+"</designation>"+
			coordinate.toSDL
			+"<radius lengthUnit=\"Meter\">"radius"</radius>"+
			"<height lengthUnit=\"Meter\">"height"</height>";
		"</tower>";
		
		return ret;
	}
	
}