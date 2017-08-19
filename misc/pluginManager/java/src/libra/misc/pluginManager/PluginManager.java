package libra.misc.pluginManager;

import java.io.File;
import java.util.List;

import libra.misc.pluginManager.implem.PluginManagerImplem;

public interface PluginManager {

	public static final PluginManager INSTANCE = new PluginManagerImplem();

	/**
	 * Gets the root directory for the running program.
	 * 
	 * @return Root directory for the running program.
	 */
	File getRootDir();

	/**
	 * Gets the required bundle directory from its ID
	 * 
	 * @param bundleID
	 *            Required bundle identifier.
	 * @return Found bundle directory.
	 */
	File getBundleDir(String bundleID);

	/**
	 * Gets all the bundles for the current running program
	 * 
	 * @param rootDir
	 *            Root directory for the running program
	 * @return List of all bundle directories.
	 */
	List<File> getAllBundleDirs(File rootDir);

	/**
	 * Gets the Eclipse project name for the specified folder.
	 * 
	 * @param bundleDir
	 *            Folder containing the bundle.
	 * @return Project name.
	 */
	String getEclipseProjectName(File bundleDir);

	/**
	 * Gets the bundle symbolic name from the specified folder.
	 * 
	 * @param bundleDir
	 *            Folder containing the bundle.
	 * @return Bundle symbolic name (ID).
	 */
	String getManifestSymbolicName(File bundleDir);

	/**
	 * Gets the bundle vendor from the specified folder.
	 * 
	 * @param bundleDir
	 *            Folder containing the bundle.
	 * @return Bundle vendor.
	 */
	String getManifestVendor(File bundleDir);

	/**
	 * Gets the bundle required tools from the specified folder.
	 * 
	 * @param bundleDir
	 *            Folder containing the bundle.
	 * @return List of tools required by this bundle.
	 */
	List<String> getManifestRequiredTools(File bundleDir);

	/**
	 * Gets the bundle required bundles from the specified folder.
	 * 
	 * @param bundleDir
	 *            Folder containing the bundle.
	 * @return List of bundles required by this bundle.
	 */
	List<String> getManifestRequiredBundles(File bundleDir);

	/**
	 * Verifies if the required tool is installed on the system. A runtime exception will be launched if the tool is not installed.
	 * 
	 * @param bundleDir
	 *            Tool to be verified.
	 */
	void checkTool(String tool);

}
