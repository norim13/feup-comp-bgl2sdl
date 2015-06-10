package classes;

public class TaxiwayParking extends TaxiwayPointParking{

	public String radius, radiusUnits;
	public String number;
	
	public TaxiwayParking(){
		super();
		radius = "XXXXX";
		radiusUnits = "Meter";
		number = "XXX";
	}
	

	public String getRadius() {
		return radius;
	}

	public void setRadius(String radius) {
		this.radius = radius;
	}

	public String getRadiusUnits() {
		return radiusUnits;
	}
	
	public void setRadiusUnits(String altU) {
		switch(altU){
		case "M": this.radiusUnits = "Meter"; break;
		case "N": this.radiusUnits = "Nautical Mile"; break;
		case "F": this.radiusUnits = "Foot"; break;
		}		
	}


	public String getNumber() {
		return number;
	}


	public void setNumber(String number) {
		this.number = number;
	}

	
}