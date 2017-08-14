package libra.misc.pluginManager;

import java.io.File;
import java.util.List;

import libra.misc.pluginManager.implem.PluginManagerImplem;

public interface PluginManager {

	public static final PluginManager INSTANCE = new PluginManagerImplem();

	/**
	 * Gets the required bundle directory from its ID
	 * 
	 * @param bundleID
	 *            Required bundle identifier.
	 * @return Found bundle directory.
	 */
	File getBundleDir(String bundleID);

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
	 * Gets the bundle required tools from the specified folder.
	 * 
	 * @param bundleDir
	 *            Folder containing the bundle.
	 * @return List of tools required by this bundle.
	 */
	List<String> getManifestRequiredTools(File bundleDir);
}
