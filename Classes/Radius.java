package classes;

public class Radius {

	public float value;
	public String units;
	
	public Radius(){
		this.value= -1;
		this.units = "M";
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



	public void setUnits(String units) {
		this.units = units;
	}



	public String toSDL(){
		String ret = "radius=\""+value+units+"\"";
		return ret;
	}

}