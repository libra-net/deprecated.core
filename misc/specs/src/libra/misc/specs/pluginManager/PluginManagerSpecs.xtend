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
	 * Plugin Manager lib shall provide a method to get the file system directory of a given bundle.
	 * 
	 * The method shall throw a runtime exception if the bundle directory doesn't exist.
	 */
	@Test
	def abstract void spec_getBundleDir();

	/**
	 * Plugin Manager lib shall provide a method to get the Eclipse project name of a given bundle (from its directory).
	 * 
	 * The method shall throw a runtime exception if the directory is not a bundle directory.
	 */
	@Test
	def abstract void spec_getEclipseProjectName();
	
	/**
	 * Plugin Manager lib shall provide a method to get the symbolic name (ID) name of a given bundle (from its directory).
	 * 
	 * The method shall throw a runtime exception if the directory is not a bundle directory.
	 */
	@Test
	def abstract void spec_getManifestSymbolicName();

}