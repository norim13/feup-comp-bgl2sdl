

class Error{
	
	String message;
	int line;
	String type;

	public Error(int line, String type, String message){
		this.message = message;
		this.type = type;
		this.line = line;
	}
	
	public String getMessage() {
		return message;
	}

	public int getLine() {
		return line;
	}

	public String getType() {
		return type;
	}
}