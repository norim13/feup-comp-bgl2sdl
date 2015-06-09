package classes;

public class Location {

	public String address, zipCode, city, state, country, region;
	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public Coordinates coordinates;
	
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public Coordinates getCoordinates() {
		return coordinates;
	}

	public void setCoordinates(Coordinates coordinates) {
		this.coordinates = coordinates;
	}

	public Location(){
		address = "xxxxxxxxxxxxx";
		zipCode = "xxxxxxxxxxxxx";
		city="xxxxxxxxxxxxx";
		state="xxxxxxxxxxxxx";
		country="xxxxxxxxxxxxx";
		region="xxxxxxxxxxxxx";
		coordinates = new Coordinates();
	}
	
	public String toSDL(String offset){
		String msg =
			offset+"<location>\n"+
					offset+"	<address>"+address+"</address>\n"+
					offset+"	<zipCode>"+zipCode+"</zipCode>\n"+
					offset+"	<city>"+city+"</city>\n"+
					offset+"	<stateDistrictRegion>"+ region + ", " + state + "</stateDistrictRegion>\n"+ //TODO ver se aqui é só o state
					offset+"	<country>"+country+"</country>\n"+
					coordinates.toSDL(offset+"	")+
			offset+"</location>\n";			
				
		return msg;
	}
}

/*

<location>
				<address>xxxxxxxxxxxxx</address>
				<zipCode>xxxxxxxxxxxxx</zipCode>
				<city>Whidbey Island</city>
				<stateDistrictRegion>Island County, WA</stateDistrictRegion>
				<country>USA</country>
				<coordinates>
					<latitude>48º 21' 6.49'' N</latitude>
					<longitude>122º 39' 21.26'' W</longitude>
					<altitude measured="amsl">47</altitude>
				</coordinates>
			</location>

*/