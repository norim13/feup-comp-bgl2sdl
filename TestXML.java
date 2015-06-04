
import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.ANTLRFileStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.gui.TreeViewer;

import classes.Airport;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.util.ArrayList;
import java.util.Arrays;
import java.io.IOException;

class TestXML{

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
		//parser.setErrorHandler(new BailErrorStrategy());
		
		ParseTree tree = parser.document();

		ArrayList<Airport> bases = new ArrayList<Airport>();
		for (int i = 0; i < tree.getChildCount(); i++){
			//bases.add(new Airport());
			bases.add(parseAirport(tree.getChild(i)));
			System.out.println(bases.get(i).toSDL(""));
		}
		
				
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
		
		for (int i = 0; i < child.getChildCount(); i++){
			ParseTree current = child.getChild(i);
			System.out.println("Parsing: "+current.getText());
			
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
				i += 2;
					break;
				case("alt"):
					System.out.println("Parsing altitude...");
					String altitude = current.getChild(0).getChild(1).getText();
					if(!current.getChild(0).getChild(2).equals("\"")){
						altitude += current.getChild(0).getChild(2).getText();
					}
					System.out.println(altitude);
					a.getLocation().getCoordinates().setAltitude(altitude);
					break;	
				}
			}				
		}
		return a;
	}


	public static void recursiveTreePrint(ParseTree tree, String offset){
		System.out.println(offset+tree.getText());
		int count = tree.getChildCount();
		
		for (int i = 0; i < count; i++){
			recursiveTreePrint(tree.getChild(i), offset+"  ");	
		}
		
		
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