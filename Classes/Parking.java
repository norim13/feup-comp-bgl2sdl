package classes;

public class Parking {

	public String parkingType, id, designation, description;
	public Coordinates coordinates;
	public Radius radius;
	public TaxiwayPoint connectsTo;
	
	
	public ContactPerson() {
		parkingType = "XXX Parking Type XXX";
		id = "XXX id XXX";
		designation = "XXX Designation XXX";
		description = "XXX Description XXX";
		coordinates = new Coordinates();
		radius = new Radius();
		connectsTo = new TaxiwayPoint();
	}
	
	public String toSDL(){
		String ret = 
			"<parking parkingType=\"" + parkingType + "\"id=\"" + id + "\" > "+
				"<designation>" + designation + "</designation>"+
				"<description>" + description + "</description>"+
				"<airlines />"
				coordinates.toSDL() + 
				radius.toSDL()+
				"<connectsToTaxiway xway=\""+connectsTo.getId()+"\">"+
					connectsTo.getCoordinates().toSDL()+
				"</connectsTo>"+
			"</parking>";
		
		return ret;
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