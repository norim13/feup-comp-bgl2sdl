package classes;

/*
There are four types of utilities – Tower, Fuel Facility, Battery Facility and Water
Facility – with three common elements:

In addition to these three elements, the Tower also has an element specifying its height; both
Fuel and Water Facilities have the available quantity of fuel or water, respectively; and the
Fuel Facility has an indication of the type of fuel it provides.
*/

public class Utility {
	public Coordinates coordinates;
	public String designation, radius, radiusUnit;

	public String id;
	public static int idCount = 1;
	
	public static int getNextId(){
		return idCount++;
	}

	public String type; //tower, fuel facility, battery facility, water facility

	public String height, heightUnit; //tower
	public String quantity; // fuel, water
	public String fuelType; //fuel
	
	//we're adding "0" to numbers lower than 10. ex.: 8 -> 08
	public String idToString(int num) {
		String newId = "";
		if (num < 0)
			newId = "_void";
		else{
			if (num < 10)
				newId = "0" + num;
			else newId = String.valueOf(num);
		}
		return newId;
	}

	public Utility(){
		designation = "XXXXXXX";
		coordinates = new Coordinates();
		radius = "XXXXX";
		radiusUnit = "Meter";
		height = "XXXXX";
		heightUnit = "Meter";
		quantity = "XXXXXX";
		fuelType = "XXXXXX";
		id = "u"+ idToString(Utility.getNextId());
	}
	
	public String toSDL(String offset){
		String msg = 
		offset+"<"+type+" id=\""+ id +"\""+ (this.type.equals("fuelFacility")? " fuelType=\""+this.fuelType + "\" " : "")  +">\n"+
		coordinates.toSDL(offset+"	")+
		offset+"	<designation>"+designation+"</designation>\n"+
		offset+"	<radius lengthUnit=\""+this.radiusUnit+"\">"+radius+"</radius>\n"+
		((type.equals("tower"))? (offset+"	<height lengthUnit=\""+this.heightUnit+"\">"+height+"</height>\n") : "") +
		offset+"</"+type+">\n";
		return msg;
	}
	
	public Coordinates getCoordinates() {
		return coordinates;
	}

	public void setCoordinates(Coordinates coordinates) {
		this.coordinates = coordinates;
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

	public String getHeight() {
		return height;
	}

	public void setHeight(String height) {
		this.height = height;
	}

	public String getHeightUnit() {
		return heightUnit;
	}

	public void setHeightUnit(String altU) {
		switch(altU){
			case "M": this.heightUnit = "Meter"; break;
			case "N": this.heightUnit = "Nautical Mile"; break;
			case "F": this.heightUnit = "Foot"; break;
		}		
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

	public void setType(String t) {
		if (t.equals("fuel"))
			this.type = "fuelFacility";
		else this.type = t;
	}	

	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String qt) {
		this.quantity = qt;
	}	

	public String getFuelType() {
		return fuelType;
	}

	public void setFuelType(String ft) {
		this.fuelType = ft;
	}

	public String getDesignation() {
		return designation;
	}

	public void setDesignation(String d) {
		this.designation = d;
	}
}