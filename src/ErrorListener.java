
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.swing.JFrame;
import org.antlr.v4.runtime.BaseErrorListener;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.Parser;
import org.antlr.v4.runtime.RecognitionException;
import org.antlr.v4.runtime.Recognizer;
import org.antlr.v4.runtime.Token;


public class ErrorListener extends BaseErrorListener {
	
	private ErrorsPanel errorsPanel;
	public ErrorsPanel getErrorsPanel() {
		return errorsPanel;
	}

	public ArrayList<Error> errorList; 
	public ErrorListener(JFrame frame){
		errorList = new ArrayList<Error>();
		errorsPanel = new ErrorsPanel(errorList);		
	}
	

	@Override
	public void syntaxError(Recognizer<?, ?> recognizer, Object offendingSymbol, int line, int charPositionInLine, String msg, RecognitionException e) {
		List<String> stack = ((Parser) recognizer).getRuleInvocationStack();
		Collections.reverse(stack);
		StringBuilder buf = new StringBuilder();
		//buf.append("rule stack: " + stack + " ");
		buf.append("line " + line + /*":" + charPositionInLine + " at " + offendingSymbol +*/ ": " + msg);

		errorList.add(new Error(line,"", msg));
		
	}

	protected void underlineError(Recognizer<?, ?> recognizer, Token offendingToken,	int line, int charPositionInLine) {
		
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
