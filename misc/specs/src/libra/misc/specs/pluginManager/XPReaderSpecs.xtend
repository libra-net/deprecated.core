package libra.misc.specs.pluginManager

import org.junit.Test

/**
 * XP Reader library provides a set a methods to read extension points contributions from bundles
 * 
 * Note: most of these methods will throw a runtime exception in case of error.
 * Indeed, software configuration is assumed to be static (dynamic plug-in addition/removal is not supported), 
 * so error cases shall not be managed by the caller.
 */
abstract class XPReaderSpecs {
	
	/**
	 * XP Reader lib shall provide a method to get all contributions to a given extension point.
	 * 
	 * If the extension point doesn't exist, or if there are no contributions, the returned list shall be empty.
	 */
	@Test
	def abstract void spec_getContributions();
	
	/**
	 * XP Reader lib shall provide a method to get contribution sub-elements with a given name from a given contribution element.
	 * 
	 * If there are no elements with this name, the returned list shall be empty.
	 */
	@Test
	def abstract void spec_getElements();
	
	/**
	 * XP Reader lib shall provide a method to get value from an attribute with a given name from a given contribution element.
	 * 
	 * If there are no attribute with this name, the returned value shall be empty.
	 */
	@Test
	def abstract void spec_getStringAttribute();
}