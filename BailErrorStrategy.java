
import org.antlr.v4.runtime.*;

public class BailErrorStrategy extends DefaultErrorStrategy {
	/**
	 * Instead of recovering from exception e, rethrow it wrapped in a generic
	 * RuntimeException so it is not caught by the rule function catches.
	 * Exception e is the "cause" of the RuntimeException.
	 */
	@Override
	public void recover(Parser recognizer, RecognitionException e) {
		//recognizer.notifyErrorListeners("errororororororo3");
		throw new RuntimeException(e);
	}

	/**
	 * Make sure we don't attempt to recover inline; if the parser successfully
	 * recovers, it won't throw an exception.
	 */
	@Override
	public Token recoverInline(Parser recognizer) throws RecognitionException {
		//recognizer.notifyErrorListeners("errororororororo2");
		throw new RuntimeException(new InputMismatchException(recognizer));
		//return null;
		
	}

	/** Make sure we don't attempt to recover from problems in subrules. */
	@Override
	public void sync(Parser recognizer) {
		//recognizer.notifyErrorListeners("errororororororo1");
	}

	@Override
	public void reportNoViableAlternative(Parser parser, NoViableAltException e) throws RecognitionException {
		// ANTLR generates Parser subclasses from grammars and
		// Parser extends Recognizer. Parameter parser is a
		// pointer to the parser that detected the error
		String msg = "can't choose between alternatives"; // nonstandard msg
		parser.notifyErrorListeners(e.getOffendingToken(), msg, e);
	}
}