package classes;

public abstract class TaxiwayPointParking {

	public String type, index;
	public Coordinates coordinates;
	
	public TaxiwayPointParking(){
		coordinates = new Coordinates();
		type = "XXXXX";
		index = "XX";
	}
	
	
	
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getIndex() {
		return index;
	}
	public void setIndex(String index) {
		this.index = index;
	}
	public Coordinates getCoordinates() {
		return coordinates;
	}

	

	
}