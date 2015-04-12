
import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.ANTLRFileStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.LexerInterpreter;
import org.antlr.v4.runtime.ParserInterpreter;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import org.antlr.v4.runtime.tree.gui.TreeViewer;
import org.antlr.v4.tool.Grammar;
import org.antlr.v4.tool.LexerGrammar;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;
import org.antlr.v4.runtime.misc.*;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import java.awt.Dimension;
import java.util.Arrays;
import java.util.Iterator;
import java.io.IOException;



class TestXML{

	public static ParseTree parse(String fileNameToParse,
	                              String lexerGrammarFileName,
	                              String parserGrammarFileName,
	                              String startRule) throws IOException
	{
	    final LexerGrammar lg = (LexerGrammar) Grammar.load(lexerGrammarFileName);
	    final Grammar pg = Grammar.load(parserGrammarFileName);
	    ANTLRFileStream input = new ANTLRFileStream(fileNameToParse);
	    LexerInterpreter lexEngine = lg.createLexerInterpreter(input);
	    CommonTokenStream tokens = new CommonTokenStream(lexEngine);
	    ParserInterpreter parser = pg.createParserInterpreter(tokens);

            //COMENTAR LINHAS ABAIXO PARA VER ERROS DEFAULT DO ANTLR4
	    	parser.removeErrorListeners();
            parser.addErrorListener(new ErrorListener());
           // parser.setErrorHandler(new BailErrorStrategy());
            
          
            ParseTree tree;
        try{
        	tree = parser.parse(pg.getRule(startRule).index);
        }
	    catch(Exception e){
	    	System.out.println("exception no parse: "+e.getClass().toString());
	    	return null;
	    }

	   // System.out.println("parse tree: " + tree.toStringTree(parser));

	    
	    //show AST in GUI
        JFrame frame = new JFrame("Antlr AST");
        JPanel panel = new JPanel();
        	

        

        TreeViewer viewr = new TreeViewer(Arrays.asList(
                parser.getRuleNames()),tree);
        //viewr.setScale(1.5);//scale a little
        panel.add(viewr);

        JScrollPane scrollPane = new JScrollPane(panel);
        scrollPane.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED);
        scrollPane.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED);
        scrollPane.setBounds(0, 0, 1850, 600);
        JPanel contentPane = new JPanel(null);
        contentPane.setPreferredSize(new Dimension(1850, 600));
        contentPane.add(scrollPane);
        frame.setContentPane(contentPane);
        frame.pack();
        frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        frame.setVisible(true);


        /*frame.add(panel);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(200,200);
        frame.setVisible(true);*/



	    return tree;
	}

	public static void main(String[] args)  throws IOException{
		String fileName;
                if (args.length < 1)
                        fileName = "pom.xml";
                else fileName = args[0];
                ParseTree t = parse(fileName, "XMLLexer.g4", "XMLParser.g4", "document");
	}


   
     

}