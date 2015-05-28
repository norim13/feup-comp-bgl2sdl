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
	
	public String toSDL(){
		String ret = 
		"<contactPerson>"+
			"<name>"+name+"</name>"+
			"<title>"+title+"</title>"+
			"<institution>"+institution+"</institution>"+
			"<position>"+position+"</position>"+
			"<address>"+address+"</address>"+
			"<zipCode>"+zipCode+"</zipCode>"+
			"<city>"+city+"</city>"+
			"<stateDistrictRegion>"+stateDistrictRegion+"</stateDistrictRegion>"+
			"<country>"+country+"</country>"+
			"<telephone>"+telephone+"</telephone>"+
			"<cellphone>"+cellphone+"</cellphone>"+
			"<fax>"+fax+"</fax>"+
			"<email>"+email+"</email>"+
		"</contactPerson>";
		
		return ret;
	}
}