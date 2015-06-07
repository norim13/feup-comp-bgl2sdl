package classes;

public class ContactPerson {

	public String name, title, institution, position,
		address, zipCode, city, stateDistrictRegion,country,
		telephone, cellphone, fax, email;
	
	
	public ContactPerson() {
		name = "XXX Name XXX";
		title = "XXX Title XXX";
		institution = "XXX Institution XXX";
		position = "XXX Position XXX";
		address = "XXX Address XXX";
		zipCode = "XXX ZipCode XXX";
		city = "XXX City XXX";
		stateDistrictRegion = "XXX State XXX";
		country = "XXX Country XXX";
		telephone = "XXX Telephone XXX";
		cellphone = "XXX Cellphone XXX";
		fax = "XXX Fax XXX";
		email = "XXX email XXX";
	}
	
	public String toSDL(String offset){
		String ret = 
		offset+"<contactPerson>\n"+
			offset+"	<name>"+name+"</name>\n"+
			offset+"	<title>"+title+"</title>\n"+
			offset+"	<institution>"+institution+"</institution>\n"+
			offset+"	<position>"+position+"</position>\n"+
			offset+"	<address>"+address+"</address>\n"+
			offset+"	<zipCode>"+zipCode+"</zipCode>\n"+
			offset+"	<city>"+city+"</city>\n"+
			offset+"	<stateDistrictRegion>"+stateDistrictRegion+"</stateDistrictRegion>\n"+
			offset+"	<country>"+country+"</country>\n"+
			offset+"	<telephone>"+telephone+"</telephone>\n"+
			offset+"	<cellphone>"+cellphone+"</cellphone>\n"+
			offset+"	<fax>"+fax+"</fax>\n"+
			offset+"	<email>"+email+"</email>\n"+
		offset+"</contactPerson>\n";
		
		return ret;
	}
}