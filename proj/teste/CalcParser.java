// Generated from Calc.g4 by ANTLR 4.5
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class CalcParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.5", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		NUM=1, OP1=2, OP2=3, OPEN=4, CLOSE=5, WS=6, TAG_START_OPEN=7, TAG_END_OPEN=8, 
		TAG_CLOSE=9, TAG_EMPTY_CLOSE=10, ATTR_EQ=11, ATTR_VALUE=12, PCDATA=13, 
		GENERIC_ID=14;
	public static final int
		RULE_start = 0, RULE_exp = 1, RULE_term = 2, RULE_fact = 3;
	public static final String[] ruleNames = {
		"start", "exp", "term", "fact"
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

	@Override
	public String getGrammarFileName() { return "Calc.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }

	public CalcParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}
	public static class StartContext extends ParserRuleContext {
		public ExpContext exp;
		public ExpContext exp() {
			return getRuleContext(ExpContext.class,0);
		}
		public TerminalNode EOF() { return getToken(CalcParser.EOF, 0); }
		public StartContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_start; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CalcListener ) ((CalcListener)listener).enterStart(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CalcListener ) ((CalcListener)listener).exitStart(this);
		}
	}

	public final StartContext start() throws RecognitionException {
		StartContext _localctx = new StartContext(_ctx, getState());
		enterRule(_localctx, 0, RULE_start);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(8);
			((StartContext)_localctx).exp = exp(0);
			setState(9);
			match(EOF);
			System.out.println("Result: " + ((StartContext)_localctx).exp.v);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ExpContext extends ParserRuleContext {
		public int v;
		public ExpContext e;
		public TermContext term;
		public Token OP1;
		public TermContext term() {
			return getRuleContext(TermContext.class,0);
		}
		public TerminalNode OP1() { return getToken(CalcParser.OP1, 0); }
		public ExpContext exp() {
			return getRuleContext(ExpContext.class,0);
		}
		public ExpContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_exp; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CalcListener ) ((CalcListener)listener).enterExp(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CalcListener ) ((CalcListener)listener).exitExp(this);
		}
	}

	public final ExpContext exp() throws RecognitionException {
		return exp(0);
	}

	private ExpContext exp(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		ExpContext _localctx = new ExpContext(_ctx, _parentState);
		ExpContext _prevctx = _localctx;
		int _startState = 2;
		enterRecursionRule(_localctx, 2, RULE_exp, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			{
			setState(13);
			((ExpContext)_localctx).term = term(0);
			((ExpContext)_localctx).v =  ((ExpContext)_localctx).term.valor;
			}
			_ctx.stop = _input.LT(-1);
			setState(23);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,0,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new ExpContext(_parentctx, _parentState);
					_localctx.e = _prevctx;
					_localctx.e = _prevctx;
					pushNewRecursionContext(_localctx, _startState, RULE_exp);
					setState(16);
					if (!(precpred(_ctx, 2))) throw new FailedPredicateException(this, "precpred(_ctx, 2)");
					setState(17);
					((ExpContext)_localctx).OP1 = match(OP1);
					setState(18);
					((ExpContext)_localctx).term = term(0);
					if((((ExpContext)_localctx).OP1!=null?((ExpContext)_localctx).OP1.getText():null).equals("+")) 
					                                              ((ExpContext)_localctx).v =  ((ExpContext)_localctx).e.v + ((ExpContext)_localctx).term.valor; 
					                                          else 
					                                              ((ExpContext)_localctx).v =  ((ExpContext)_localctx).e.v - ((ExpContext)_localctx).term.valor;
					}
					} 
				}
				setState(25);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,0,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class TermContext extends ParserRuleContext {
		public int valor;
		public TermContext a;
		public FactContext fact;
		public Token OP2;
		public FactContext fact() {
			return getRuleContext(FactContext.class,0);
		}
		public TerminalNode OP2() { return getToken(CalcParser.OP2, 0); }
		public TermContext term() {
			return getRuleContext(TermContext.class,0);
		}
		public TermContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_term; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CalcListener ) ((CalcListener)listener).enterTerm(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CalcListener ) ((CalcListener)listener).exitTerm(this);
		}
	}

	public final TermContext term() throws RecognitionException {
		return term(0);
	}

	private TermContext term(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		TermContext _localctx = new TermContext(_ctx, _parentState);
		TermContext _prevctx = _localctx;
		int _startState = 4;
		enterRecursionRule(_localctx, 4, RULE_term, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			{
			setState(27);
			((TermContext)_localctx).fact = fact();
			((TermContext)_localctx).valor =  ((TermContext)_localctx).fact.value;
			}
			_ctx.stop = _input.LT(-1);
			setState(37);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,1,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new TermContext(_parentctx, _parentState);
					_localctx.a = _prevctx;
					_localctx.a = _prevctx;
					pushNewRecursionContext(_localctx, _startState, RULE_term);
					setState(30);
					if (!(precpred(_ctx, 2))) throw new FailedPredicateException(this, "precpred(_ctx, 2)");
					setState(31);
					((TermContext)_localctx).OP2 = match(OP2);
					setState(32);
					((TermContext)_localctx).fact = fact();
					if((((TermContext)_localctx).OP2!=null?((TermContext)_localctx).OP2.getText():null).equals("*")) 
					                                              ((TermContext)_localctx).valor =  ((TermContext)_localctx).a.valor * ((TermContext)_localctx).fact.value; 
					                                          else 
					                                              ((TermContext)_localctx).valor =  ((TermContext)_localctx).a.valor / ((TermContext)_localctx).fact.value;
					}
					} 
				}
				setState(39);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,1,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class FactContext extends ParserRuleContext {
		public int value;
		public Token NUM;
		public ExpContext exp;
		public TerminalNode NUM() { return getToken(CalcParser.NUM, 0); }
		public TerminalNode OPEN() { return getToken(CalcParser.OPEN, 0); }
		public ExpContext exp() {
			return getRuleContext(ExpContext.class,0);
		}
		public TerminalNode CLOSE() { return getToken(CalcParser.CLOSE, 0); }
		public FactContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_fact; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof CalcListener ) ((CalcListener)listener).enterFact(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof CalcListener ) ((CalcListener)listener).exitFact(this);
		}
	}

	public final FactContext fact() throws RecognitionException {
		FactContext _localctx = new FactContext(_ctx, getState());
		enterRule(_localctx, 6, RULE_fact);
		try {
			setState(47);
			switch (_input.LA(1)) {
			case NUM:
				enterOuterAlt(_localctx, 1);
				{
				setState(40);
				((FactContext)_localctx).NUM = match(NUM);
				((FactContext)_localctx).value =  Integer.parseInt((((FactContext)_localctx).NUM!=null?((FactContext)_localctx).NUM.getText():null));
				}
				break;
			case OPEN:
				enterOuterAlt(_localctx, 2);
				{
				setState(42);
				match(OPEN);
				setState(43);
				((FactContext)_localctx).exp = exp(0);
				setState(44);
				match(CLOSE);
				((FactContext)_localctx).value =  ((FactContext)_localctx).exp.v;
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public boolean sempred(RuleContext _localctx, int ruleIndex, int predIndex) {
		switch (ruleIndex) {
		case 1:
			return exp_sempred((ExpContext)_localctx, predIndex);
		case 2:
			return term_sempred((TermContext)_localctx, predIndex);
		}
		return true;
	}
	private boolean exp_sempred(ExpContext _localctx, int predIndex) {
		switch (predIndex) {
		case 0:
			return precpred(_ctx, 2);
		}
		return true;
	}
	private boolean term_sempred(TermContext _localctx, int predIndex) {
		switch (predIndex) {
		case 1:
			return precpred(_ctx, 2);
		}
		return true;
	}

	public static final String _serializedATN =
		"\3\u0430\ud6d1\u8206\uad2d\u4417\uaef1\u8d80\uaadd\3\20\64\4\2\t\2\4\3"+
		"\t\3\4\4\t\4\4\5\t\5\3\2\3\2\3\2\3\2\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3\3"+
		"\3\7\3\30\n\3\f\3\16\3\33\13\3\3\4\3\4\3\4\3\4\3\4\3\4\3\4\3\4\3\4\7\4"+
		"&\n\4\f\4\16\4)\13\4\3\5\3\5\3\5\3\5\3\5\3\5\3\5\5\5\62\n\5\3\5\2\4\4"+
		"\6\6\2\4\6\b\2\2\62\2\n\3\2\2\2\4\16\3\2\2\2\6\34\3\2\2\2\b\61\3\2\2\2"+
		"\n\13\5\4\3\2\13\f\7\2\2\3\f\r\b\2\1\2\r\3\3\2\2\2\16\17\b\3\1\2\17\20"+
		"\5\6\4\2\20\21\b\3\1\2\21\31\3\2\2\2\22\23\f\4\2\2\23\24\7\4\2\2\24\25"+
		"\5\6\4\2\25\26\b\3\1\2\26\30\3\2\2\2\27\22\3\2\2\2\30\33\3\2\2\2\31\27"+
		"\3\2\2\2\31\32\3\2\2\2\32\5\3\2\2\2\33\31\3\2\2\2\34\35\b\4\1\2\35\36"+
		"\5\b\5\2\36\37\b\4\1\2\37\'\3\2\2\2 !\f\4\2\2!\"\7\5\2\2\"#\5\b\5\2#$"+
		"\b\4\1\2$&\3\2\2\2% \3\2\2\2&)\3\2\2\2\'%\3\2\2\2\'(\3\2\2\2(\7\3\2\2"+
		"\2)\'\3\2\2\2*+\7\3\2\2+\62\b\5\1\2,-\7\6\2\2-.\5\4\3\2./\7\7\2\2/\60"+
		"\b\5\1\2\60\62\3\2\2\2\61*\3\2\2\2\61,\3\2\2\2\62\t\3\2\2\2\5\31\'\61";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}