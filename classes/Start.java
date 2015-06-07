package classes;

public class Start{
	public String type, heading, number, designator;
	
	public Coordinates coordinates;
	
	public Start(){
		this.coordinates =  new Coordinates();
	}
	
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getHeading() {
		return heading;
	}

	public void setHeading(String heading) {
		this.heading = heading;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getDesignator() {
		return designator;
	}

	public void setDesignator(String designator) {
		this.designator = designator;
	}

	public Coordinates getCoordinates() {
		return coordinates;
	}

	public void setCoordinates(Coordinates coordinates) {
		this.coordinates = coordinates;
	}

}

/*
 * 
 * element in bgl
 * 
 * <Start
      type="RUNWAY"
      lat="41.45240683"
      lon="-87.01929230"
      alt="235.00079346"
      heading="90.130000"
      number="10"
      designator="NONE"/>
 * 
 * 
 * 
 * */
