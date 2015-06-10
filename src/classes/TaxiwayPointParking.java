package classes;

import java.util.ArrayList;

public abstract class TaxiwayPointParking {

	public String type, index;
	public Coordinates coordinates;
	public ArrayList<String> connectedTaxiways;
	
	public TaxiwayPointParking(){
		coordinates = new Coordinates();
		type = "XXXXX";
		index = "XX";
		connectedTaxiways = new ArrayList<String>();
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

	public ArrayList<String> getConnectedTaxiways() {
		return connectedTaxiways;
	}

	public void setConnectedTaxiways(ArrayList<String> connectedTaxiways) {
		this.connectedTaxiways = connectedTaxiways;
	}

	public void setCoordinates(Coordinates coordinates) {
		this.coordinates = coordinates;
	}
	
	public void addConnectedTaxiway(String i){
		connectedTaxiways.add(i);
	}
	
	public String printConnections(String offset, String currentId){
		String msg = "";
		for (int i = 0; i < connectedTaxiways.size(); i++)
			if (!connectedTaxiways.get(i).equals(currentId)){
				if (connectedTaxiways.get(i).substring(0, 1).equals("r"))
					msg += offset+"<rway idr=\""+connectedTaxiways.get(i)+"\" />\n";
				else if (connectedTaxiways.get(i).substring(0, 1).equals("x"))
					msg += offset+"<xway idr=\""+connectedTaxiways.get(i)+"\" />\n";
				else System.out.println("print connections, taxiway point -> index: "+this.index+"unknown connection");
			}

		return msg;
	}



	public abstract String getNumber();

	
}