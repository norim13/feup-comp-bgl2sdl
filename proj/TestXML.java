
import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.ANTLRFileStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.LexerInterpreter;
import org.antlr.v4.runtime.ParserInterpreter;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.tool.Grammar;
import org.antlr.v4.tool.LexerGrammar;

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
	    ParseTree t = parser.parse(pg.getRule(startRule).index);
	    System.out.println("parse tree: " + t.toStringTree(parser));
	    return t;
	}

	public static void main(String[] args)  throws IOException{
		ParseTree t = parse("AF2.bgl.xml", "XMLLexer.g4", "XMLParser.g4", "document");
	}


}