package libra.itf;

/**
 * This is a sample interface
 */
public interface SimpleSample {
	
	String _TOKEN = "11eeb3b6a66a804be976eb39cc40a03c";
	
	/**
 	 * Simple function to get an hello world string
 	 */
 	String printHello();
 
 	/**
 	 * Another function which doesn't return anything
 	 */
 	void doSomething();
 
 	/**
 	 * Function with single argument
 	 */
 	String printSingleArg();
 
}
