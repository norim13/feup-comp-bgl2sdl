package classes;

import java.util.ArrayList;

public class Airport {

	public String   name, ident, ICAO, IATA, region, magvar;
	
	public ContactPerson contactPerson;
	public int id;
	public Location location;
	private ArrayList<Runway> runways;
	
	public ArrayList<Runway> getRunways() {
		return runways;
	}

	public void setMagvar(String magvar) {
		this.magvar = magvar;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getICAO() {
		return ICAO;
	}

	public void setICAO(String iCAO) {
		ICAO = iCAO;
	}

	public String getIATA() {
		return IATA;
	}

	public void setIATA(String iATA) {
		IATA = iATA;
	}

	public ContactPerson getContactPerson() {
		return contactPerson;
	}

	public void setContactPerson(ContactPerson contactPerson) {
		this.contactPerson = contactPerson;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Location getLocation() {
		return location;
	}

	public void setLocation(Location location) {
		this.location = location;
	}

	

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIdent() {
		return ident;
	}

	public void setIdent(String ident) {
		this.ident = ident;
	}


	public String getMagvar() {
		return magvar;
	}

	public void addRunway(Runway rw){
		this.runways.add(rw);
	}
	
	public Airport() {
		name="xxxxxxxxxxxxx";
		ident="xxxxxxxxxxxxx";
		ICAO="XXXXX";
		IATA="XXXXX";
		this.contactPerson = new ContactPerson();
		this.location = new Location();
		
		this.runways = new ArrayList<Runway>();
	}
	
	public String toSDL(String offset){
		String msg = 
				offset+"<baseOfOperations id=\"b"+id+"\">\n"+
					offset+"	<name>"+name+"</name>\n"+
					offset+"	<mobility water=\"false\" underwater=\"false\" land=\"true\" air=\"true\" />\n"+
					offset+"	<description>XXX Description XXX</description>\n"+
					offset+"	<history>XXX History XXX</history>\n"+
					contactPerson.toSDL(offset+"	")+
					location.toSDL(offset+"	")+
					offset+"	<availability available=\"always\" />\n"+
					offset+"	<airport>\n"+
						offset+"		<name>"+name+"</name>\n"+
						offset+"		<description>XXX Description XXX</description>\n"+
						contactPerson.toSDL(offset+"			")+
						location.toSDL(offset+"			")+
						offset+"		<ICAO>"+ICAO+"</ICAO>\n"+
						offset+"		<IATA>"+IATA+"</IATA>\n"+
						offset+"		<magVar>"+magvar+"</magVar>\n"+
						
						offset+"		<runways>\n"+
							printRunways(offset+"			")+
						offset+"		</runways>\n"+			
					
					offset+"	</airport>\n"+
				offset+"</baseOfOperations>\n";
		return msg;
	}
	
	
	public String printRunways(String offset){
		String msg = "";
		for(Runway r : runways){
			msg += r.toSDL(offset);
		}
		return msg;
	}
	
	
	
}