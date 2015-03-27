// Generated from Calc.g4 by ANTLR 4.5
import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.misc.*;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class CalcLexer extends Lexer {
	static { RuntimeMetaData.checkVersion("4.5", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		NUM=1, OP1=2, OP2=3, OPEN=4, CLOSE=5, WS=6, TAG_START_OPEN=7, TAG_END_OPEN=8, 
		TAG_CLOSE=9, TAG_EMPTY_CLOSE=10, ATTR_EQ=11, ATTR_VALUE=12, PCDATA=13, 
		GENERIC_ID=14;
	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	public static final String[] ruleNames = {
		"NUM", "OP1", "OP2", "OPEN", "CLOSE", "WS", "TAG_START_OPEN", "TAG_END_OPEN", 
		"TAG_CLOSE", "TAG_EMPTY_CLOSE", "ATTR_EQ", "ATTR_VALUE", "PCDATA", "GENERIC_ID", 
		"NAMECHAR", "DIGIT", "LETTER"
	};

	private static final String[] _LITERAL_NAMES = {
		null, null, null, null, "'('", "')'", null, "'<'", "'</'"
	};
	private static final String[] _SYMBOLIC_NAMES = {
		null, "NUM", "OP1", "OP2", "OPEN", "CLOSE", "WS", "TAG_START_OPEN", "TAG_END_OPEN", 
		"TAG_CLOSE", "TAG_EMPTY_CLOSE", "ATTR_EQ", "ATTR_VALUE", "PCDATA", "GENERIC_ID"
	};
	public static final Vocabulary VOCABULARY = new VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	@Deprecated
	public static final String[] tokenNames;
	static {
		tokenNames = new String[_SYMBOLIC_NAMES.length];
		for (int i = 0; i < tokenNames.length; i++) {
			tokenNames[i] = VOCABULARY.getLiteralName(i);
			if (tokenNames[i] == null) {
				tokenNames[i] = VOCABULARY.getSymbolicName(i);
			}

			if (tokenNames[i] == null) {
				tokenNames[i] = "<INVALID>";
			}
		}
	}

	@Override
	@Deprecated
	public String[] getTokenNames() {
		return tokenNames;
	}

	@Override

	public Vocabulary getVocabulary() {
		return VOCABULARY;
	}


	public CalcLexer(CharStream input) {
		super(input);
		_interp = new LexerATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	@Override
	public String getGrammarFileName() { return "Calc.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public String[] getModeNames() { return modeNames; }

	@Override
	public ATN getATN() { return _ATN; }

	@Override
	public void action(RuleContext _localctx, int ruleIndex, int actionIndex) {
		switch (ruleIndex) {
		case 6:
			TAG_START_OPEN_action((RuleContext)_localctx, actionIndex);
			break;
		case 7:
			TAG_END_OPEN_action((RuleContext)_localctx, actionIndex);
			break;
		case 8:
			TAG_CLOSE_action((RuleContext)_localctx, actionIndex);
			break;
		case 9:
			TAG_EMPTY_CLOSE_action((RuleContext)_localctx, actionIndex);
			break;
		}
	}
	private void TAG_START_OPEN_action(RuleContext _localctx, int actionIndex) {
		switch (actionIndex) {
		case 0:
			 tagMode = true; 
			break;
		}
	}
	private void TAG_END_OPEN_action(RuleContext _localctx, int actionIndex) {
		switch (actionIndex) {
		case 1:
			 tagMode = true; 
			break;
		}
	}
	private void TAG_CLOSE_action(RuleContext _localctx, int actionIndex) {
		switch (actionIndex) {
		case 2:
			 tagMode = false; 
			break;
		}
	}
	private void TAG_EMPTY_CLOSE_action(RuleContext _localctx, int actionIndex) {
		switch (actionIndex) {
		case 3:
			 tagMode = false; 
			break;
		}
	}
	@Override
	public boolean sempred(RuleContext _localctx, int ruleIndex, int predIndex) {
		switch (ruleIndex) {
		case 8:
			return TAG_CLOSE_sempred((RuleContext)_localctx, predIndex);
		case 9:
			return TAG_EMPTY_CLOSE_sempred((RuleContext)_localctx, predIndex);
		case 10:
			return ATTR_EQ_sempred((RuleContext)_localctx, predIndex);
		case 11:
			return ATTR_VALUE_sempred((RuleContext)_localctx, predIndex);
		case 12:
			return PCDATA_sempred((RuleContext)_localctx, predIndex);
		case 13:
			return GENERIC_ID_sempred((RuleContext)_localctx, predIndex);
		}
		return true;
	}
	private boolean TAG_CLOSE_sempred(RuleContext _localctx, int predIndex) {
		switch (predIndex) {
		case 0:
			return  tagMode ;
		}
		return true;
	}
	private boolean TAG_EMPTY_CLOSE_sempred(RuleContext _localctx, int predIndex) {
		switch (predIndex) {
		case 1:
			return  tagMode ;
		}
		return true;
	}
	private boolean ATTR_EQ_sempred(RuleContext _localctx, int predIndex) {
		switch (predIndex) {
		case 2:
			return  tagMode ;
		}
		return true;
	}
	private boolean ATTR_VALUE_sempred(RuleContext _localctx, int predIndex) {
		switch (predIndex) {
		case 3:
			return  tagMode ;
		}
		return true;
	}
	private boolean PCDATA_sempred(RuleContext _localctx, int predIndex) {
		switch (predIndex) {
		case 4:
			return  !tagMode ;
		}
		return true;
	}
	private boolean GENERIC_ID_sempred(RuleContext _localctx, int predIndex) {
		switch (predIndex) {
		case 5:
			return  tagMode ;
		}
		return true;
	}

	public static final String _serializedATN =
		"\3\u0430\ud6d1\u8206\uad2d\u4417\uaef1\u8d80\uaadd\2\20{\b\1\4\2\t\2\4"+
		"\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13\t"+
		"\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22"+
		"\3\2\6\2\'\n\2\r\2\16\2(\3\3\3\3\3\4\3\4\3\5\3\5\3\6\3\6\3\7\6\7\64\n"+
		"\7\r\7\16\7\65\3\7\3\7\3\b\3\b\3\b\3\t\3\t\3\t\3\t\3\t\3\n\3\n\3\n\3\n"+
		"\3\13\3\13\3\13\3\13\3\13\3\13\3\f\3\f\3\f\3\r\3\r\3\r\7\rR\n\r\f\r\16"+
		"\rU\13\r\3\r\3\r\3\r\7\rZ\n\r\f\r\16\r]\13\r\3\r\5\r`\n\r\3\16\3\16\6"+
		"\16d\n\16\r\16\16\16e\3\17\3\17\3\17\5\17k\n\17\3\17\7\17n\n\17\f\17\16"+
		"\17q\13\17\3\20\3\20\3\20\5\20v\n\20\3\21\3\21\3\22\3\22\2\2\23\3\3\5"+
		"\4\7\5\t\6\13\7\r\b\17\t\21\n\23\13\25\f\27\r\31\16\33\17\35\20\37\2!"+
		"\2#\2\3\2\f\3\2\62;\4\2--//\4\2,,\61\61\5\2\13\f\17\17\"\"\3\2$$\3\2)"+
		")\3\2>>\4\2<<aa\5\2/\60<<aa\4\2C\\c|\u0081\2\3\3\2\2\2\2\5\3\2\2\2\2\7"+
		"\3\2\2\2\2\t\3\2\2\2\2\13\3\2\2\2\2\r\3\2\2\2\2\17\3\2\2\2\2\21\3\2\2"+
		"\2\2\23\3\2\2\2\2\25\3\2\2\2\2\27\3\2\2\2\2\31\3\2\2\2\2\33\3\2\2\2\2"+
		"\35\3\2\2\2\3&\3\2\2\2\5*\3\2\2\2\7,\3\2\2\2\t.\3\2\2\2\13\60\3\2\2\2"+
		"\r\63\3\2\2\2\179\3\2\2\2\21<\3\2\2\2\23A\3\2\2\2\25E\3\2\2\2\27K\3\2"+
		"\2\2\31N\3\2\2\2\33a\3\2\2\2\35g\3\2\2\2\37u\3\2\2\2!w\3\2\2\2#y\3\2\2"+
		"\2%\'\t\2\2\2&%\3\2\2\2\'(\3\2\2\2(&\3\2\2\2()\3\2\2\2)\4\3\2\2\2*+\t"+
		"\3\2\2+\6\3\2\2\2,-\t\4\2\2-\b\3\2\2\2./\7*\2\2/\n\3\2\2\2\60\61\7+\2"+
		"\2\61\f\3\2\2\2\62\64\t\5\2\2\63\62\3\2\2\2\64\65\3\2\2\2\65\63\3\2\2"+
		"\2\65\66\3\2\2\2\66\67\3\2\2\2\678\b\7\2\28\16\3\2\2\29:\7>\2\2:;\b\b"+
		"\3\2;\20\3\2\2\2<=\7>\2\2=>\7\61\2\2>?\3\2\2\2?@\b\t\4\2@\22\3\2\2\2A"+
		"B\6\n\2\2BC\7@\2\2CD\b\n\5\2D\24\3\2\2\2EF\6\13\3\2FG\7\61\2\2GH\7@\2"+
		"\2HI\3\2\2\2IJ\b\13\6\2J\26\3\2\2\2KL\6\f\4\2LM\7?\2\2M\30\3\2\2\2N_\6"+
		"\r\5\2OS\7$\2\2PR\n\6\2\2QP\3\2\2\2RU\3\2\2\2SQ\3\2\2\2ST\3\2\2\2TV\3"+
		"\2\2\2US\3\2\2\2V`\7$\2\2W[\7)\2\2XZ\n\7\2\2YX\3\2\2\2Z]\3\2\2\2[Y\3\2"+
		"\2\2[\\\3\2\2\2\\^\3\2\2\2][\3\2\2\2^`\7)\2\2_O\3\2\2\2_W\3\2\2\2`\32"+
		"\3\2\2\2ac\6\16\6\2bd\n\b\2\2cb\3\2\2\2de\3\2\2\2ec\3\2\2\2ef\3\2\2\2"+
		"f\34\3\2\2\2gj\6\17\7\2hk\5#\22\2ik\t\t\2\2jh\3\2\2\2ji\3\2\2\2ko\3\2"+
		"\2\2ln\5\37\20\2ml\3\2\2\2nq\3\2\2\2om\3\2\2\2op\3\2\2\2p\36\3\2\2\2q"+
		"o\3\2\2\2rv\5#\22\2sv\5!\21\2tv\t\n\2\2ur\3\2\2\2us\3\2\2\2ut\3\2\2\2"+
		"v \3\2\2\2wx\4\62;\2x\"\3\2\2\2yz\t\13\2\2z$\3\2\2\2\f\2(\65S[_ejou\7"+
		"\b\2\2\3\b\2\3\t\3\3\n\4\3\13\5";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}