package classes;

public class Parking {

	public String parkingType, id, designation, description;
	public Coordinates coordinates;
	public Radius radius;
	public TaxiwayPointParking connectsTo;
	
	
	public Parking() {
		parkingType = "XXX Parking Type XXX";
		id = "XXX id XXX";
		designation = "XXX Designation XXX";
		description = "XXX Description XXX";
		coordinates = new Coordinates();
		radius = new Radius(); //TODO n sei de onde vem o radius
		connectsTo = new TaxiwayPoint();
	}
	
	public String toSDL(String offset){
		String ret = 
			offset+"<parking parkingType=\"" + parkingType + "\" id=\"" + id + "\" >\n"+
				offset+"	<designation>" + designation + "</designation>\n"+
				offset+"	<description>" + description + "</description>\n"+
				offset+"	<airlines />\n" + 
				coordinates.toSDL(offset+"	") + 
				radius.toSDL(offset+"	")+
				offset+"	<connectsToTaxiway xway=\""+connectsTo.getConnectedTaxiways().get(0)+"\">\n"+
					connectsTo.getCoordinates().toSDL(offset+"		")+
				offset+"	</connectsToTaxiway>\n"+
			offset+"</parking>\n";
		
		return ret;
	}

	public String getParkingType() {
		return parkingType;
	}

	public void setParkingType(String parkingType) {
		this.parkingType = parkingType;
	}

	public String getId() {
		return id;
	}

	/**
	 * gets id straight from bgl, and converts it to sdl id (and also sets designation)
	 * @param id
	 */
	public void setId(String id) {
		
		try{
			int i = Integer.parseInt(id);
			if (i < 10)
				this.id = "p0"+i;
			else this.id = "p"+i;
		}
		catch (Exception e){
			this.id = id;
		}
		this.designation = "Parking "+id;
	}

	public String getDesignation() {
		return designation;
	}

	public void setDesignation(String designation) {
		this.designation = designation;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Coordinates getCoordinates() {
		return coordinates;
	}

	public void setCoordinates(Coordinates coordinates) {
		this.coordinates = coordinates;
	}

	public Radius getRadius() {
		return radius;
	}

	public void setRadius(Radius radius) {
		this.radius = radius;
	}

	public TaxiwayPointParking getConnectsTo() {
		return connectsTo;
	}

	public void setConnectsTo(TaxiwayPointParking connectsTo) {
		this.connectsTo = connectsTo;
	}
	
	/**
	<parking parkingType="Medium" id="p16">
		<designation>Parking Ramp P</designation>
		<description>Usually used for medium sized aircraft</description>
		<airlines />
		<coordinates>
			<latitude>48º 31' 38.12'' N</latitude>
			<longitude>123º 1' 35.01'' W</longitude>
			<altitude measured="amsl">121</altitude>
		</coordinates>
		<radius lengthUnit="Foot">32</radius>
		<connectsToTaxiway xway="x06">
			<coordinates>
				<latitude>48º 31' 38.12'' N</latitude>
				<longitude>123º 1' 33.23'' W</longitude>
				<altitude measured="amsl">121</altitude>
			</coordinates>
		</connectsToTaxiway>
	</parking>
	*/
}