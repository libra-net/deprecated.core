package libra.misc.specs.pluginManager

import org.junit.Test

/**
 * Plugin Manager library provides utility methods to locate and get metadata from plug-ins.
 * 
 * Note: most of these methods will throw a runtime exception in case of error.
 * Indeed, software configuration is assumed to be static (dynamic plug-in addition/removal is not supported), 
 * so error cases (bundle existence) shall not be managed by the caller.
 * 
 */
abstract class PluginManagerSpecs {
	
	/**
	 * Plugin Manager lib shall provide a method to get the current running program root directory.
	 */
	@Test
	def abstract void spec_getRootDir();
	
	/**
	 * Plugin Manager lib shall provide a method to get the file system directory of a given bundle.
	 * 
	 * The method shall throw a runtime exception if the bundle directory doesn't exist.
	 */
	@Test
	def abstract void spec_getBundleDir();
	
	/**
	 * Plugin Manager lib shall provide a method to get the list of all bundles for the required program root directory.
	 * 
	 * The method shall throw a runtime exception if no bundles are found.
	 */
	@Test
	def abstract void spec_getAllBundleDirs();

	/**
	 * Plugin Manager lib shall provide a method to get the Eclipse project name of a given bundle (from its directory).
	 * 
	 * The method shall throw a runtime exception if the directory is not a bundle directory.
	 */
	@Test
	def abstract void spec_getEclipseProjectName();
	
	/**
	 * Plugin Manager lib shall provide a method to get the symbolic name (ID) of a given bundle (from its directory).
	 * 
	 * The method shall throw a runtime exception if the directory is not a bundle directory.
	 */
	@Test
	def abstract void spec_getManifestSymbolicName();
	
	/**
	 * Plugin Manager lib shall provide a method to get the vendor of a given bundle (from its directory).
	 * 
	 * The method shall throw a runtime exception if the directory is not a bundle directory.
	 */
	@Test
	def abstract void spec_getManifestVendor();
	
	/**
	 * Plugin Manager lib shall provide a method to get the list of required tools of a given bundle (from its directory).
	 * "Tools" are external commands expected to be found on path (to be installed on the system as a prerequisite).
	 * 
	 * The method shall throw a runtime exception if the directory is not a bundle directory.
	 */
	@Test
	def abstract void spec_getManifestRequiredTools();
	
	/**
	 * Plugin Manager lib shall provide a method to get the list of required bundles of a given bundle (from its directory).
	 * 
	 * The method shall throw a runtime exception if the directory is not a bundle directory.
	 */
	@Test
	def abstract void spec_getManifestRequiredBundles();

	/**
	 * Plugin Manager lib shall provide a method to check if a required tool is installed.
	 * 
	 * The method shall throw a runtime exception if the required tool is not installed on the system.
	 */
	@Test
	def abstract void spec_checkTool();

}