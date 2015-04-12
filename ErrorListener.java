
import java.awt.Color;
import java.awt.Container;
import java.awt.GridLayout;
import java.util.BitSet;
import java.util.Collections;
import java.util.List;

import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JLabel;

import org.antlr.v4.runtime.ANTLRErrorListener;
import org.antlr.v4.runtime.BaseErrorListener;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.Parser;
import org.antlr.v4.runtime.RecognitionException;
import org.antlr.v4.runtime.Recognizer;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.atn.ATNConfigSet;
import org.antlr.v4.runtime.dfa.DFA;

/*
public class ErrorListener implements ANTLRErrorListener{

	@Override
	public void reportAmbiguity(Parser arg0, DFA arg1, int arg2, int arg3,
			boolean arg4, BitSet arg5, ATNConfigSet arg6) {
		System.out.println("ERRO1") ;
		System.out.println(arg6.toString());
	}

	@Override
	public void reportAttemptingFullContext(Parser arg0, DFA arg1, int arg2,
			int arg3, BitSet arg4, ATNConfigSet arg5) {
		System.out.println("ERRO2") ;
		System.out.println(arg5.toString());
		
	}

	@Override
	public void reportContextSensitivity(Parser arg0, DFA arg1, int arg2,
			int arg3, int arg4, ATNConfigSet arg5) {
		System.out.println("ERRO3") ;
		System.out.println(arg5.toString());
		
		
	}

	@Override
	public void syntaxError(Recognizer<?, ?> arg0, Object arg1, int arg2,
			int arg3, String arg4, RecognitionException arg5) {
		System.out.println("ERRO4") ;
		System.out.println(arg5.getLocalizedMessage()+"#"+arg5.getMessage());
	}

}*/
public class ErrorListener extends BaseErrorListener {
	
	private JDialog dialog;
	private Container contentPane;
	private GridLayout layout;
	public ErrorListener(){
		dialog = new JDialog();
		contentPane = dialog.getContentPane();
		layout = new GridLayout();
		contentPane.setLayout(layout);
		contentPane.setBackground(Color.white);
		dialog.setTitle("Syntax error");
	}
	
	/*public void syntaxError(Recognizer<?, ?> recognizer, Object offendingSymbol, int line, int charPositionInLine, String msg, RecognitionException e) {		
		System.err.println("line " + line + ":" + charPositionInLine + " "	+ msg);
		underlineError(recognizer, (Token) offendingSymbol, line, charPositionInLine);
	}*/
	@Override
	public void syntaxError(Recognizer<?, ?> recognizer, Object offendingSymbol, int line, int charPositionInLine, String msg, RecognitionException e) {
		List<String> stack = ((Parser) recognizer).getRuleInvocationStack();
		Collections.reverse(stack);
		StringBuilder buf = new StringBuilder();
		//buf.append("rule stack: " + stack + " ");
		buf.append("line " + line + /*":" + charPositionInLine + " at " + offendingSymbol +*/ ": " + msg);
		layout.setRows(layout.getRows()+1);
		addToPanel(buf.toString());
		
	}

	public void addToPanel(String str){
		contentPane.add(new JLabel(str));
		dialog.pack();
		dialog.setLocationRelativeTo(null);
		dialog.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		dialog.setVisible(true);
	}
	
	protected void underlineError(Recognizer recognizer, Token offendingToken,	int line, int charPositionInLine) {
		
		CommonTokenStream tokens = (CommonTokenStream) recognizer.getInputStream();
		String input = tokens.getTokenSource().getInputStream().toString();
		String[] lines = input.split("\n");
		String errorLine = lines[line - 1];
		System.err.println(errorLine);
		for (int i = 0; i < charPositionInLine; i++)
			System.err.print(" ");
		int start = offendingToken.getStartIndex();
		int stop = offendingToken.getStopIndex();
		if (start >= 0 && stop >= 0) {
			for (int i = start; i <= stop; i++)
				System.err.print("^");
		}
		System.err.println();
	}
}
