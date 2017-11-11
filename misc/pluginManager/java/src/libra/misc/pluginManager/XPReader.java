package libra.misc.pluginManager;

import java.util.List;
import java.util.Optional;

import libra.misc.pluginManager.implem.XPReaderImplem;

/**
 * Extension Point reader interface
 * 
 * @author david
 *
 */
public interface XPReader {

	static final XPReader INSTANCE = new XPReaderImplem();

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
	 *            Extension point ID from which to get the contributions
	 * @return List of contributions, to be used by other methods of this interface
	 */
	List<XPContrib> getContributions(String xpID);

	/**
	 * Gets the required contribution sub-elements from the required contribution
	 * 
	 * @param contrib
	 *            Contribution instance
	 * @param name
	 *            Name of the contribution sub-element(s) to be found
	 * @return Found parameter value
	 */
	List<XPContrib> getElements(XPContrib contrib, String name);

	/**
	 * Gets the required String attribute from the required contribution
	 * 
	 * @param contrib
	 *            Contribution instance
	 * @param name
	 *            Name of the attribute from which to get the value
	 * @return Found parameter value
	 */
	Optional<String> getStringAttribute(XPContrib contrib, String name);

	/**
	 * Gets the required Class attribute from the required contribution
	 * 
	 * @param contrib
	 *            Contribution instance
	 * @param name
	 *            Name of the attribute from which to get a Class instance
	 * @return Found parameter value
	 */
	Optional<Class<?>> getClassAttribute(XPContrib contrib, String name);
}
