// Generated from Calc.g4 by ANTLR 4.5
import org.antlr.v4.runtime.misc.NotNull;
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link CalcParser}.
 */
public interface CalcListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link CalcParser#start}.
	 * @param ctx the parse tree
	 */
	void enterStart(CalcParser.StartContext ctx);
	/**
	 * Exit a parse tree produced by {@link CalcParser#start}.
	 * @param ctx the parse tree
	 */
	void exitStart(CalcParser.StartContext ctx);
	/**
	 * Enter a parse tree produced by {@link CalcParser#exp}.
	 * @param ctx the parse tree
	 */
	void enterExp(CalcParser.ExpContext ctx);
	/**
	 * Exit a parse tree produced by {@link CalcParser#exp}.
	 * @param ctx the parse tree
	 */
	void exitExp(CalcParser.ExpContext ctx);
	/**
	 * Enter a parse tree produced by {@link CalcParser#term}.
	 * @param ctx the parse tree
	 */
	void enterTerm(CalcParser.TermContext ctx);
	/**
	 * Exit a parse tree produced by {@link CalcParser#term}.
	 * @param ctx the parse tree
	 */
	void exitTerm(CalcParser.TermContext ctx);
	/**
	 * Enter a parse tree produced by {@link CalcParser#fact}.
	 * @param ctx the parse tree
	 */
	void enterFact(CalcParser.FactContext ctx);
	/**
	 * Exit a parse tree produced by {@link CalcParser#fact}.
	 * @param ctx the parse tree
	 */
	void exitFact(CalcParser.FactContext ctx);
}