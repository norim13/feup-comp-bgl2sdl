package classes;

public class TaxiwayPath {

	public String type, start, end, widthUnits, width, number, name, surface;

	

	public TaxiwayPath(){
		surface="XXXXX";
		type="XXXX";
		start="XX";
		end="XX";
		widthUnits="Meters";
		width="XXX";
		number=null;
		name = null;
	}
	
	
	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public String getWidthUnits() {
		return widthUnits;
	}

	public void setWidthUnits(String altU) {
		switch(altU){
		case "M": this.widthUnits = "Meter"; break;
		case "N": this.widthUnits = "Nautical Mile"; break;
		case "F": this.widthUnits = "Foot"; break;
		}		
	}

	public String getWidth() {
		return width;
	}

	public void setWidth(String width) {
		this.width = width;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}
	
	public String getSurface() {
		return surface;
	}


	public void setSurface(String surface) {
		this.surface = surface;
	}

	
}