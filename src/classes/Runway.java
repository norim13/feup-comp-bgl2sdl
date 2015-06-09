package classes;

import java.util.ArrayList;

public class Runway {
	
	public Coordinates coordinates;
	public String length, lengthUnits, width, widthUnits;
	public String surface, id;
	public StartEndPoint startBaseEnd, endBaseEnd, startReciprocalEnd, endReciprocalEnd;
	
	public String baseEndDesignation, reciprocalEndDesignation;
	public String baseEndHeading, reciprocalEndHeading;
	 
	public String number;
	
	public Taxiway path;
	
	
	public Runway(){
		
		coordinates = new Coordinates();
		length = "XXXX";
		lengthUnits="Meter";
		width="XXXX";
		widthUnits="Meter";
		surface="XXXXXXX";
		
		startBaseEnd = new StartEndPoint("start");
		endBaseEnd = new StartEndPoint("end");
		startReciprocalEnd = new StartEndPoint("start");
		endReciprocalEnd = new StartEndPoint("end");
		
		baseEndDesignation = "XX"; 
		reciprocalEndDesignation = "XX";
		baseEndHeading = "XXX";
		reciprocalEndHeading = "XXX";
		
		id = "XXXXX"; //TODO ID é "rAA-BB" -> AA é a designation de baseEnd e BB é a designation de reciprocalEnd
		
		path = new Taxiway();
		
		
	}
	
	public void setLengthUnits(String altU) {
		switch(altU){
		case "M": this.lengthUnits = "Meter"; break;
		case "N": this.lengthUnits = "Nautical Mile"; break;
		case "F": this.lengthUnits = "Foot"; break;
		}		
	}
	
	public void setWidthUnits(String altU) {
		switch(altU){
		case "M": this.lengthUnits = "Meter"; break;
		case "N": this.lengthUnits = "Nautical Mile"; break;
		case "F": this.lengthUnits = "Foot"; break;
		}		
	}
	
	public String toSDL(String offset){
		String msg = 
				offset+"<runway id=\""+  "r"+ baseEndDesignation + "-" +  reciprocalEndDesignation    +"\" >\n"+
						coordinates.toSDL(offset+"	")+
						offset+"	<length lengthUnit=\""+lengthUnits+"\" >"+length+"</length>\n"+
						offset+"	<width lengthUnit=\""+widthUnits+"\" >"+width+"</width>\n"+
						offset+"	<surface>"+surface+"</surface>\n"+
						
						offset+"	<baseEnd>\n"+
							offset+"		<designation>"+baseEndDesignation+"</designation>\n"+
							path.generateStartpointSDL(offset+"		")+//startBaseEnd.toSDL(offset+"		")+
							offset+"		<heading headingType=\"True\">"+baseEndHeading+"</heading>\n"+
							path.generateEndpointSDL(offset+"		")+//endBaseEnd.toSDL(offset+"		")+
						offset+"	</baseEnd>\n"+
						
						offset+"	<reciprocalEnd>\n"+
							offset+"		<designation>"+reciprocalEndDesignation+"</designation>\n"+
							startReciprocalEnd.toSDL(offset+"		")+
							offset+"		<heading headingType=\"True\">"+reciprocalEndHeading+"</heading>\n"+
							endReciprocalEnd.toSDL(offset+"		")+
					offset+"	</reciprocalEnd>\n"+
				offset+"</runway>\n";
		return msg;
	}
	
	
	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	
	public Coordinates getCoordinates() {
		return coordinates;
	}

	public void setCoordinates(Coordinates coordinates) {
		this.coordinates = coordinates;
	}

	public String getLength() {
		return length;
	}

	public void setLength(String length) {
		this.length = length;
	}

	public String getWidth() {
		return width;
	}

	public void setWidth(String width) {
		this.width = width;
	}

	public String getWidthUnits() {
		return widthUnits;
	}


	public String getSurface() {
		return surface;
	}

	public void setSurface(String surface) {
		this.surface = surface;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getLengthUnits() {
		return lengthUnits;
	}

	public Taxiway getPath() {
		return path;
	}

	public void setPath(Taxiway path) {
		this.path = path;
		this.setId(path.getId());
		this.baseEndDesignation = path.getNumber();
	}
}