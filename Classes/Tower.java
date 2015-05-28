package classes;

public class Tower {

	public String id,designation,radius,height;

	public Coordinate coordinate;

	public Tower() {
		id="u01";
		designation="Tower";
		radius="2.55";
		height="129";
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