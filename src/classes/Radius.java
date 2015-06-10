package classes;

public class Radius {

	public float value;
	public String units;
	
	public Radius(){
		this.value= -1;
		this.units = "Meter";
	}
	
	public float getValue() {
		return value;
	}



	public void setValue(float value) {
		this.value = value;
	}



	public String getUnits() {
		return units;
	}



	public void setUnits(String un) {
		
		switch(un){
			case "M": this.units = "Meter"; break;
			case "N": this.units = "Nautical Mile"; break;
			case "F": this.units = "Foot"; break;
		}		
		
	}



	public String toSDL(String offset){
		String ret = offset+"<radius lengthUnit=\""+units+"\">"+value+"</radius>\n";
		return ret;
	}

}