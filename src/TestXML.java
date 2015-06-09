
import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.ANTLRFileStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.gui.TreeViewer;

import classes.Airport;
import classes.Helipad;
import classes.Runway;
import classes.Start;
import classes.Taxiway;
import classes.TaxiwayParking;
import classes.TaxiwayPath;
import classes.TaxiwayPoint;
import classes.TaxiwayPointParking;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;

import g4.XMLLexer;
import g4.XMLParser;

class TestXML{

	@SuppressWarnings("resource")
	public static ParseTree parse(String fileNameToParse,
		String lexerGrammarFileName,
		String parserGrammarFileName,
		String startRule) throws IOException
	{
		int frameWidth = 1400;
		int frameHeight = 800;
		JFrame frame = new JFrame("Antlr AST");

		ANTLRInputStream input = new ANTLRFileStream(fileNameToParse);
		//ANTLRInputStream input = new ANTLRInputStream(System.in); // or read stdin
		XMLLexer lexer = new XMLLexer(input);
		CommonTokenStream tokens = new CommonTokenStream(lexer);
		XMLParser parser = new XMLParser(tokens);

		//COMENTAR LINHAS ABAIXO PARA VER ERROS DEFAULT DO ANTLR4
		parser.removeErrorListeners();
		ErrorListener errList = new ErrorListener(frame);
		parser.addErrorListener(errList);
		
		ParseTree tree = parser.document();

		
		
		File folder = new File("output");
		if(!folder.isDirectory())
			folder.mkdir();
		

		FileWriter outputFile = new FileWriter("output\\conversion.xml", false);
		
		ArrayList<Airport> bases = new ArrayList<Airport>();
		for (int i = 0; i < tree.getChildCount(); i++){
			//bases.add(new Airport());
			bases.add(parseAirport(tree.getChild(i)));
			String baseSDL = bases.get(i).toSDL("");
			//System.out.println(baseSDL);
			outputFile.write(baseSDL);
		}
		
		outputFile.close();		
		
		//new java.util.Scanner(System.in).nextLine();
		
		//show AST in GUI
		/*JPanel panel = new JPanel();

		TreeViewer viewr = new TreeViewer(Arrays.asList(
				parser.getRuleNames()),tree);
		//viewr.setScale(1.5);//scale a little
		panel.add(viewr);

		JScrollPane scrollPane = new JScrollPane(panel);
		scrollPane.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED);
		scrollPane.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED);
		scrollPane.setBounds(0, 0, frameWidth, (int) (frameHeight*0.6));
		scrollPane.setPreferredSize(new Dimension(frameWidth, (int) (frameHeight*0.6)));

		//frame.add(scrollPane, BorderLayout.NORTH);

		//errList.getErrorsPanel().setDimension(frameWidth, (int) (frameHeight*0.4));
		errList.getErrorsPanel().setDimension(frameWidth, (int) (frameHeight));
		frame.add(errList.getErrorsPanel(), BorderLayout.SOUTH);

		frame.pack();
		frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		frame.setVisible(true);*/

		return tree;
	}

	
	private static Airport parseAirport(ParseTree child) {
		
		Airport a = new Airport();
		ArrayList<Start> starts = new ArrayList<Start>();
		ArrayList<TaxiwayPoint> taxiwayPoints = new ArrayList<TaxiwayPoint>();
		ArrayList<TaxiwayParking> taxiwayParkings = new ArrayList<TaxiwayParking>();
		ArrayList<TaxiwayPath> taxiwayPaths = new ArrayList<TaxiwayPath>();
		ArrayList<Helipad> helipads = new ArrayList<Helipad>(); 
		ArrayList<Utility> utilities = new ArrayList<Utility>();
		
		for (int i = 0; i < child.getChildCount(); i++){
			ParseTree current = child.getChild(i);
			//System.out.println("Parsing: "+current.getText());
			
			String[] parts = current.getText().split("=");
			if (parts.length == 2){ //attributes
				switch(parts[0]){
					case("region"): 
					a.getLocation().setRegion(current.getChild(0).getChild(1).getText());
					break;
					case("country"): 
					a.getLocation().setCountry(current.getChild(0).getChild(1).getText());
					break;
					case("state"): 
					a.getLocation().setState(current.getChild(0).getChild(1).getText());
					break;
					case("city"): 
					a.getLocation().setCity(current.getChild(0).getChild(1).getText());
					break;
					case("name"):
					a.setName(current.getChild(0).getChild(1).getText());
					break;
					case("lat"):
					a.getLocation().getCoordinates().setLatitude(current.getChild(0).getChild(1).getText());
					break;
					case("lon"):
					a.getLocation().getCoordinates().setLongitude(current.getChild(0).getChild(1).getText());
					break;
					case("alt"):
					String altitude = current.getChild(0).getChild(1).getText();
					if(!current.getChild(0).getChild(2).equals("\"")){
						a.getLocation().getCoordinates().setAltUnits(current.getChild(0).getChild(2).getText());
					}
					a.getLocation().getCoordinates().setAltitude(altitude);
					break;	
					case("ident"):
					a.setICAO(current.getChild(0).getChild(1).getText()); 
					break;
					case("magvar"):
					a.setMagvar(current.getChild(0).getChild(1).getText());
					break;
				}
			}
			else{ //airport elements
				//System.out.println("\n\n\n\nParsing airport elements:\n");
				
				for (int j = 0; j < current.getChildCount(); j++){ //iterate over airport elements
					ParseTree currentElement = current.getChild(j);
					String elementText = currentElement.getText();
					if (elementText == null || elementText.length() == 0)
						continue;
					//System.out.println("Parsing: "+elementText);
					//System.out.println("element text size: "+elementText.length());
					
					String elementNameText = currentElement.getChild(0).getText();
					//System.out.println("elementNameText: "+elementNameText);

					
					//get only element name
					/////////////////////////////////////////					
					int openIndex = elementNameText.indexOf("<");
					int closeIndex = elementNameText.indexOf(">");
					int spaceIndex = elementNameText.indexOf(" "); if (spaceIndex < 0) spaceIndex = closeIndex;
					int elementNameEnd = (closeIndex < spaceIndex)? closeIndex : spaceIndex;
					if (elementNameEnd < 0)
						elementNameEnd = elementNameText.length();
					String elementName = elementNameText.substring(openIndex+1, elementNameEnd);
					//System.out.println("Element name: #"+elementName+"#");
					////////////////////////////////////////////
					
					
					switch(elementName){
						case ("Runway"):{
							Runway rw = parseRunway(currentElement);
						//System.out.println(rw.toSDL(""));
							a.addRunway(rw);
							break;
						}
						case("Start"):{
							Start start = parseStart(currentElement);
						//System.out.println("Start parsed (?)");
							starts.add(start);
							break;
						}
						
						case("TaxiwayPoint"):{
							TaxiwayPoint tp = parseTaxiwayPoint(currentElement);
						//System.out.println("Start parsed (?)");
							taxiwayPoints.add(tp);
							break;
						}
						
						case("TaxiwayParking"):{
							TaxiwayParking tp = parseTaxiwayParking(currentElement);
						//System.out.println("Start parsed (?)");
							taxiwayParkings.add(tp);
							break;
						}
						
						case("TaxiwayPath"):{
							TaxiwayPath tp = parseTaxiwayPath(currentElement);
						//System.out.println("TaxiwayPath parsed (?)");
							taxiwayPaths.add(tp);
							break;
						}
						
						case("Helipad"):{
							Helipad h = parseHelipad(currentElement);
						//System.out.println("Helipad parsed (?)");
							helipads.add(h);
							break;						
						}
						case("Tower"):{
							Utility u = parseUtility(currentElement,"tower");
						//System.out.println("Utility parsed (?)");
							utilities.add(u);
							break;						
						}
						default: 
						System.out.println("not parsing element: "+elementName);
					}
					
				}
			}
		}
		
		a.setHelipads(helipads);
		
		System.out.println("number of starts: "+starts.size());
		System.out.println("number of taxiway points: "+taxiwayPoints.size());
		System.out.println("number of taxiway parkings: "+taxiwayParkings.size());
		
		/*for(TaxiwayParking tp: taxiwayParkings){
			String m = "TW Parking: "+"index-> "+tp.getIndex()+" = radius->"+tp.getRadius()+tp.getRadiusUnits();
			System.out.println(m);
		}*/
		
		//remove all paths with type PARKING or PATH //dunno why, mas n ligam bem
		ArrayList<TaxiwayPath> parkingPaths = new ArrayList<TaxiwayPath>();
		for ( int i = 0; i < taxiwayPaths.size(); i++){
			String thisType = taxiwayPaths.get(i).getType();
			String thisName = (taxiwayPaths.get(i).getName() == null)? "notnull" : taxiwayPaths.get(i).getName();
			if ((!thisType.equals("TAXI") && !thisType.equals("RUNWAY")) || thisName.equals("0")){
				//System.out.println("removing: "+thisType);
				parkingPaths.add(taxiwayPaths.remove(i--));
			}
		}
		
		
		ArrayList<ArrayList<Taxiway>> runwaysTaxiways = generatePaths(taxiwayPoints, taxiwayParkings,taxiwayPaths);
		a.setTaxiways(runwaysTaxiways.get(1));
		
		ArrayList<Taxiway> runways = runwaysTaxiways.get(0);
		ArrayList<Runway> currentRunways = a.getRunways();
		
		for(Runway r : currentRunways){
			for(Taxiway t : runways){
				if(t.getNumber().equals(r.getNumber()))
					r.setPath(t);
			}
		}
		
		
		//Fetch IATA online based on ICAO
		String answer;
		try {
			answer = readURL(new URL("http://www.airport-data.com/api/ap_info.json?icao="+a.getICAO()));
			if (answer == null)
				throw new Exception();
			int index_iata = answer.indexOf("iata");
			if (index_iata < 0)
				throw new Exception();
			index_iata += 7;
			
			answer = answer.substring(index_iata);
			int index_double_quotes = answer.indexOf("\"");
			if (index_double_quotes < 0)
				throw new Exception();
			
			answer = answer.substring(0, index_double_quotes);
			
			a.setIATA(answer);
			
		} catch (Exception ee){}
		
		return a;
	}

	
	private static Runway parseRunway(ParseTree runway){
		Runway rw = new Runway();
		for (int i = 0; i < runway.getChildCount(); i++){
			ParseTree current = runway.getChild(i);
			//System.out.println("Parsing inside runway: "+current.getText());
			
			String[] parts = current.getText().split("=");
			if (parts.length == 2){ //attributes
				switch(parts[0]){
					case("lat"): 
					rw.getCoordinates().setLatitude(current.getChild(0).getChild(1).getText());
					break;
					case("lon"):
					rw.getCoordinates().setLongitude(current.getChild(0).getChild(1).getText());
					break;
					case("alt"):
					String altitude = current.getChild(0).getChild(1).getText();
					if(!current.getChild(0).getChild(2).equals("\"")){
						rw.getCoordinates().setAltUnits(current.getChild(0).getChild(2).getText());
					}
					rw.getCoordinates().setAltitude(altitude);
					break;	
					case("surface"):
					rw.setSurface(current.getChild(0).getChild(1).getText());
					break;
					case("length"):
					String length = current.getChild(0).getChild(1).getText();
					if(!current.getChild(0).getChild(2).equals("\"")){
						rw.setLengthUnits(current.getChild(0).getChild(2).getText());
					}
					rw.setLength(length);
					break;
					case("width"):
					String width = current.getChild(0).getChild(1).getText();
					if(!current.getChild(0).getChild(2).equals("\"")){
						rw.setWidthUnits(current.getChild(0).getChild(2).getText());
					}
					rw.setWidth(width);
					break;
					case("number"):
					rw.setNumber(current.getChild(0).getChild(1).getText());
					break;
					
				}	
			}
			else{
				//not parsing runway elements
			}
		}
		return rw;
	}
	
	private static Start parseStart(ParseTree start){
		Start s = new Start();
		for (int i = 0; i < start.getChildCount(); i++){
			ParseTree current = start.getChild(i);
			//System.out.println("Parsing inside Start: "+current.getText());
			
			String[] parts = current.getText().split("=");
			if (parts.length == 2){ //attributes
				switch(parts[0]){
					case("lat"): 
					s.getCoordinates().setLatitude(current.getChild(0).getChild(1).getText());
					break;
					case("lon"):
					s.getCoordinates().setLongitude(current.getChild(0).getChild(1).getText());
					break;
					case("alt"):
					String altitude = current.getChild(0).getChild(1).getText();
					if(!current.getChild(0).getChild(2).equals("\"")){
						s.getCoordinates().setAltUnits(current.getChild(0).getChild(2).getText());
					}
					s.getCoordinates().setAltitude(altitude);
					break;	
					case("type"):
					s.setType(current.getChild(0).getChild(1).getText());
					break;
					case("heading"):
					s.setHeading(current.getChild(0).getChild(1).getText());
					break;
					case("number"):
					s.setNumber(current.getChild(0).getChild(1).getText());
					break;
					case("designator"):
					s.setDesignator(current.getChild(0).getChild(1).getText());
					break;
					
				}	
			}
			else{
				//not parsing start elements
			}
		}
		return s;
	}
	
	
	private static Helipad parseHelipad(ParseTree helipad){
		Helipad h = new Helipad();
		for (int i = 0; i < helipad.getChildCount(); i++){
			ParseTree current = helipad.getChild(i);
			//System.out.println("Parsing inside Start: "+current.getText());
			
			String[] parts = current.getText().split("=");
			if (parts.length == 2){ //attributes
				switch(parts[0]){
					case("lat"): 
					h.getCoordinates().setLatitude(current.getChild(0).getChild(1).getText());
					break;
					case("lon"):
					h.getCoordinates().setLongitude(current.getChild(0).getChild(1).getText());
					break;
					case("alt"):
					String altitude = current.getChild(0).getChild(1).getText();
					if(!current.getChild(0).getChild(2).equals("\"")){
						h.getCoordinates().setAltUnits(current.getChild(0).getChild(2).getText());
					}
					h.getCoordinates().setAltitude(altitude);
					break;	
					case("type"):
					h.setType(current.getChild(0).getChild(1).getText());
					break;
					case("length"):
					if(!current.getChild(0).getChild(2).equals("\"")){
						h.setRadiusUnit(current.getChild(0).getChild(2).getText());
					}
					
					//we're calculating radius from length (assuming the helipad is circular)
					h.calculateRadius(current.getChild(0).getChild(1).getText()); 
					break;
					case("surface"):
					h.setSurface(current.getChild(0).getChild(1).getText());
					break;
					
				}	
			}
			else{
				//not parsing helipad elements
			}
		}
		return h;
	}

	private static Utility parseUtility(ParseTree utility, String type){
		Utility u = new Utility();
		for (int i = 0; i < utility.getChildCount(); i++) {
			ParseTree current = utility.getChild(i);
			//System.out.println("Parsing inside Start: "+current.getText());
			
			String[] parts = current.getText().split("=");
			if (parts.length == 2){ //attributes
				switch(parts[0]){
					case("lat"): 
					u.getCoordinates().setLatitude(current.getChild(0).getChild(1).getText());
					break;
					case("lon"):
					u.getCoordinates().setLongitude(current.getChild(0).getChild(1).getText());
					break;
					case("alt"):
					String altitude = current.getChild(0).getChild(1).getText();
					if(!current.getChild(0).getChild(2).equals("\"")){
						u.getCoordinates().setAltUnits(current.getChild(0).getChild(2).getText());
					}
					u.getCoordinates().setAltitude(altitude);
					break;
				}
			}
			else{
				//not parsing utility elements
			}
		}
		u.setType(type);
		if(type.equals("tower")) u.setDesignation("Tower");

		return u;
	}
	
	private static TaxiwayPoint parseTaxiwayPoint(ParseTree start){
		TaxiwayPoint tp = new TaxiwayPoint();
		for (int i = 0; i < start.getChildCount(); i++){
			ParseTree current = start.getChild(i);
			//System.out.println("Parsing inside TaxiwayPoint: "+current.getText());
			
			String[] parts = current.getText().split("=");
			if (parts.length == 2){ //attributes
				switch(parts[0]){
					case("lat"): 
					tp.getCoordinates().setLatitude(current.getChild(0).getChild(1).getText());
					break;
					case("lon"):
					tp.getCoordinates().setLongitude(current.getChild(0).getChild(1).getText());
					break;
					case("alt"):
					String altitude = current.getChild(0).getChild(1).getText();
					if(!current.getChild(0).getChild(2).equals("\"")){
						tp.getCoordinates().setAltUnits(current.getChild(0).getChild(2).getText());
					}
					tp.getCoordinates().setAltitude(altitude);
					break;	
					case("type"):
					tp.setType(current.getChild(0).getChild(1).getText());
					break;
					case("index"):
					tp.setIndex(current.getChild(0).getChild(1).getText());
					break;
					
				}	
			}
			else{
				//not parsing TaxiwayPoint elements
			}
		}
		return tp;
	}
	
	private static TaxiwayParking parseTaxiwayParking(ParseTree start){
		TaxiwayParking tp = new TaxiwayParking();
		for (int i = 0; i < start.getChildCount(); i++){
			ParseTree current = start.getChild(i);
			//System.out.println("Parsing inside TaxiwayParking: "+current.getText());
			
			String[] parts = current.getText().split("=");
			if (parts.length == 2){ //attributes
				switch(parts[0]){
					case("lat"): 
					tp.getCoordinates().setLatitude(current.getChild(0).getChild(1).getText());
					break;
					case("lon"):
					tp.getCoordinates().setLongitude(current.getChild(0).getChild(1).getText());
					break;
					case("alt"):
					String altitude = current.getChild(0).getChild(1).getText();
					if(!current.getChild(0).getChild(2).equals("\"")){
						tp.getCoordinates().setAltUnits(current.getChild(0).getChild(2).getText());
					}
					tp.getCoordinates().setAltitude(altitude);
					break;	
					case("type"):
					tp.setType(current.getChild(0).getChild(1).getText());
					break;
					case("index"):
					tp.setIndex(current.getChild(0).getChild(1).getText());
					break;
					case("radius"):
					String radius = current.getChild(0).getChild(1).getText();
					if(!current.getChild(0).getChild(2).equals("\"")){
						tp.setRadiusUnits(current.getChild(0).getChild(2).getText());
					}
					tp.setRadius(radius);
					break;	
					
				}	
			}
			else{
				//not parsing TaxiwayParking elements
			}
		}
		return tp;
	}
	
	private static TaxiwayPath parseTaxiwayPath(ParseTree start){
		TaxiwayPath tp = new TaxiwayPath();
		for (int i = 0; i < start.getChildCount(); i++){
			ParseTree current = start.getChild(i);
			//System.out.println("Parsing inside TaxiwayPath: "+current.getText());
			
			String[] parts = current.getText().split("=");
			if (parts.length == 2){ //attributes
				switch(parts[0]){
					case("type"):
					tp.setType(current.getChild(0).getChild(1).getText());
					break;
					case("start"):
					tp.setStart(current.getChild(0).getChild(1).getText());
					break;
					case("end"):
					tp.setEnd(current.getChild(0).getChild(1).getText());
					break;
					case("width"):
					String width = current.getChild(0).getChild(1).getText();
					if(!current.getChild(0).getChild(2).equals("\"")){
						tp.setWidthUnits(current.getChild(0).getChild(2).getText());
					}
					tp.setWidth(width);
					break;	
					case("number"):
					tp.setNumber(current.getChild(0).getChild(1).getText());
					break;
					case("name"):
					tp.setName(current.getChild(0).getChild(1).getText());
					break;
					case("surface"):
					tp.setSurface(current.getChild(0).getChild(1).getText());
					break;
				}
			}
			else{
				//not parsing TaxiwayPath elements
			}
		}
		return tp;
	}

	
	public static ArrayList<ArrayList<Taxiway>> generatePaths(ArrayList<TaxiwayPoint> taxiwayPoints, ArrayList<TaxiwayParking> taxiwayParkings, ArrayList<TaxiwayPath> taxiwayPaths){
		ArrayList<ArrayList<Taxiway>> ret = new ArrayList<ArrayList<Taxiway>>();
 		ret.add(new ArrayList<Taxiway>());//runways [0]
 		ret.add(new ArrayList<Taxiway>());//taxiways [1]
 		
 		ArrayList<TaxiwayPath> taxiwayPathsCopy = new ArrayList<TaxiwayPath>(taxiwayPaths);
 		while(!taxiwayPathsCopy.isEmpty()){
			//System.out.println("paths size: "+taxiwayPathsCopy.size());
 			
			Taxiway taxiway = new Taxiway(); //taxiway to add to return array
			TaxiwayPath temp = taxiwayPathsCopy.remove(0);
			taxiway.setSurface(temp.getSurface());
			taxiway.setWidth(temp.getWidth());
			taxiway.setWidthUnits(temp.getWidthUnits());
			taxiway.setType(temp.getType());
			
			
			// get all taxiwaypaths with this name or number
			ArrayList<TaxiwayPath> currentPath = new ArrayList<TaxiwayPath>();
			currentPath.add(temp);
			
			if(temp.getName() != null)
				getTaxiwayPathsWithSameName(temp, taxiwayPathsCopy, currentPath);
			else getTaxiwayPathsWithSameNumber(temp, taxiwayPathsCopy, currentPath);
			
			System.out.println("## Paths with same name/number ("+temp.getName()+"): " + currentPath.size());
			
			/*if (temp.getName()!=null)
				System.out.println("## name: "+temp.getName());
				else System.out.println("## number: "+temp.getNumber());*/
			//order taxiwaypaths
				ArrayList<TaxiwayPath> sortedPath = new ArrayList<TaxiwayPath>();
			sortedPath.add(currentPath.remove(0)); //add first path to list
			
			TaxiwayPath tp = null;
			
			//search for taxiwaypaths which link to last one
			while( (tp = getNextPath(sortedPath.get(sortedPath.size()-1).getEnd(), currentPath)) != null){
				sortedPath.add(tp);
				currentPath.remove(tp);
			}

			//search for taxiwaypaths which link to first one
			while( (tp = getPreviousPath(sortedPath.get(0).getStart(), currentPath)) != null){
				sortedPath.add(0, tp);
				currentPath.remove(tp);
			}
			
			System.out.println("	## ordered path size " + sortedPath.size() + "(left on previous array: " + currentPath.size() + ")\n");
			
			//GET matching taxiwaypoint
			ArrayList<TaxiwayPointParking> pointsSequence = new ArrayList<TaxiwayPointParking>();
			for(TaxiwayPath t : sortedPath){
				String index = t.getStart();
				for (TaxiwayPoint t1 : taxiwayPoints){
					if (t1.getIndex().equals(index)){
						pointsSequence.add(t1);
						break;
					}
				}
			}
			//add last node
			String index = sortedPath.get(sortedPath.size()-1).getEnd();
			for (TaxiwayPoint t1 : taxiwayPoints){
				if (t1.getIndex().equals(index)){
					pointsSequence.add(t1);
					break;
				}
			}
			
			//print generated path//////////
			System.out.println(" #### PATH: ####");
			
			for(TaxiwayPointParking t2 : pointsSequence)
				System.out.print(t2.getIndex() + " -> ");
			System.out.println("\n");
			//////////////////////////////
			
			
			
			
			taxiway.setPath(pointsSequence);
			System.out.println(taxiway.getId());
			//set taxiway id, based on its type
			switch(taxiway.getType()){
				case("TAXI"):
				
				//we're adding "0" to numbers lower than 10. ex.: 8 -> 08
				int num;
				try{
					num = Integer.parseInt(temp.getName());
				}
				catch(Exception e){
					num = -1;
				}
				String newId = "";
				if (num < 0)
					newId = temp.getName();
				else{
					if (num < 10)
						newId = "0" + num;
					else newId = String.valueOf(num);
				}
				//////////////////////////////////////////
				taxiway.setId("x"+newId);
				break;
				
				case("RUNWAY"):
				taxiway.setIdRunway();
				ret.get(0).add(taxiway);
				break;
			}
			
			for(TaxiwayPointParking t2 : pointsSequence)
				t2.addConnectedTaxiway(taxiway.getId());
			
			
			switch(taxiway.getType()){
				case("TAXI"): ret.get(1).add(taxiway); break;
				case("RUNWAY"): taxiway.setNumber(temp.getNumber());ret.get(0).add(taxiway); break;
			}
			
		}

		
		return ret;
	}
	
	
	public static TaxiwayPath getNextPath(String wantedStart, ArrayList<TaxiwayPath> paths){
		for (TaxiwayPath t : paths)
			if (t.getStart().equals(wantedStart))
				return t;
			return null;
		}
		
		public static TaxiwayPath getPreviousPath(String wantedEnd, ArrayList<TaxiwayPath> paths){
			for (TaxiwayPath t : paths)
				if (t.getEnd().equals(wantedEnd))
					return t;
				return null;
			}
			
			private static void getTaxiwayPathsWithSameName(TaxiwayPath temp, ArrayList<TaxiwayPath> taxiwayPathsCopy, ArrayList<TaxiwayPath> currentPath) {
				String name = temp.getName();
				for(int i = 0; i < taxiwayPathsCopy.size(); i++){
					if(taxiwayPathsCopy.get(i).getName() != null){
						if (taxiwayPathsCopy.get(i).getName().equals(name)){
							currentPath.add(taxiwayPathsCopy.remove(i--));
						}
					}
				}	
			}
			
			private static void getTaxiwayPathsWithSameNumber(TaxiwayPath temp, ArrayList<TaxiwayPath> taxiwayPathsCopy, ArrayList<TaxiwayPath> currentPath) {
				String number = temp.getNumber();
				for(int i = 0; i < taxiwayPathsCopy.size(); i++){
					if(taxiwayPathsCopy.get(i).getNumber() != null){
						if (taxiwayPathsCopy.get(i).getNumber().equals(number)){
							currentPath.add(taxiwayPathsCopy.remove(i--));
						}
					}
				}
			}


			public static void recursiveTreePrint(ParseTree tree, String offset){
				System.out.println(offset+tree.getText());
				int count = tree.getChildCount();
				
				for (int i = 0; i < count; i++){
					recursiveTreePrint(tree.getChild(i), offset+"  ");	
				}		
			}
			
			
			private static String readURL(URL url) {		
				String inputLine = "";
				try{
					URLConnection yc = url.openConnection();
					BufferedReader in = new BufferedReader(
						new InputStreamReader(
							yc.getInputStream()));
					
					String inputLineTemp;
					while ((inputLineTemp = in.readLine()) != null)
						inputLine += inputLineTemp;
					in.close();
				}
				catch(IOException e){
					return null;
				}
				
				return inputLine;
			}
			
			public static void main(String[] args)  throws IOException{
				String fileName;
				if (args.length < 1)
					fileName = "pom.xml";
				else fileName = args[0];
				ParseTree t = parse(fileName, "XMLLexer.g4", "XMLParser.g4", "document");
				System.out.println(t.getChild(0));
			}
		}