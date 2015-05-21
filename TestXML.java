
import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.ANTLRFileStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.gui.TreeViewer;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;

import java.awt.BorderLayout;
import java.awt.Dimension;
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

		//show AST in GUI

		JPanel panel = new JPanel();

		TreeViewer viewr = new TreeViewer(Arrays.asList(
				parser.getRuleNames()),tree);
		//viewr.setScale(1.5);//scale a little
		panel.add(viewr);

		JScrollPane scrollPane = new JScrollPane(panel);
		scrollPane.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED);
		scrollPane.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED);
		scrollPane.setBounds(0, 0, frameWidth, (int) (frameHeight*0.6));
		scrollPane.setPreferredSize(new Dimension(frameWidth, (int) (frameHeight*0.6)));

		frame.add(scrollPane, BorderLayout.NORTH);

		errList.getErrorsPanel().setDimension(frameWidth, (int) (frameHeight*0.4));
		frame.add(errList.getErrorsPanel(), BorderLayout.SOUTH);

		frame.pack();
		frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		frame.setVisible(true);

		return tree;
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