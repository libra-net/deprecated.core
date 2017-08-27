package libra.misc.pluginManager;

import java.util.List;

/**
 * Extension Point reader interface
 * 
 * @author david
 *
 */
public interface XPReader {

	/**
	 * Interface used to manipulate contributions
	 * 
	 * @author david
	 *
	 */
	interface XPContrib {

	}

	/**
	 * Gets the list of contributors for the required extension point ID
	 * 
	 * @param xpID
	 *            Extention point ID from which to get the contributions
	 * @return List of contributions, to be used by other methods of this interface
	 */
	List<XPContrib> getContributions(String xpID);

	/**
	 * Gets the required String attribute from the required contribution
	 * 
	 * @param contrib
	 *            Contribution instance
	 * @param path
	 *            Path to the parameter from which to get the value
	 * @return Found parameter value
	 */
	String getStringAttribute(XPContrib contrib, String path);

}
