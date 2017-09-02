package libra.misc.pluginManager.implem;

import java.io.File;
import java.net.URL;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import libra.misc.extProc.ShLibProcessWrapper;
import libra.misc.pluginManager.PluginManager;

public class PluginManagerImplem extends ShLibProcessWrapper implements PluginManager {

	@Override
	public File getRootDir() {
		// Get current code URL
		URL c = PluginManagerImplem.class.getProtectionDomain().getCodeSource().getLocation();
		System.err.println(c);
		if (!c.getProtocol().equals("file")) {
			throw new UnsupportedOperationException("Can't process non-file based URL: " + c);
		}
		File orig = new File(c.getPath());

		// Process won't be the same whatever if we're in a debug launch configuration, Maven build, or in a built software.
		String absPath = orig.getAbsolutePath();
		int sourceTreeIndex = absPath.lastIndexOf("/misc/pluginManager/java");
		if (sourceTreeIndex > 0) {
			// Eclipse launch conf mode or Maven build (we have the complete source tree)
			// Go up from some levels
			return new File(absPath.substring(0, sourceTreeIndex));
		}

		// TODO Manage built software structure
		throw new UnsupportedOperationException("Unsupported directory structure: " + absPath);
	}

	@Override
	public File getBundleDir(String bundleID) {
		// Get root directory
		File root = getRootDir();
		File bundleDir = root;

		// TODO Detect/Manage built software structure

		// Use bundle ID to find directory (ignore fist segment)
		String[] bundleIDsegments = bundleID.split("\\.");
		for (int i = 1; i < bundleIDsegments.length; i++) {
			bundleDir = new File(bundleDir, bundleIDsegments[i]);
		}

		// Verify we have found the bundle
		if (!bundleDir.isDirectory() || !new File(bundleDir, "META-INF").isDirectory()) {
			throw new UnsupportedOperationException("Can't find expected bundle path (" + bundleID + "); path not found: " + bundleDir);
		}
		return bundleDir;
	}

	private static File pmShLib = null;

	private File loadPmShLib() {
		if (pmShLib == null) {
			final File bundleDir = getBundleDir("libra.misc.pluginManager.sh");
			final String classPath = "lib"; // Hard-coded classpath here... Chicken and egg situation otherwise.
			pmShLib = new File(new File(bundleDir, classPath), "libPluginManager.sh");
		}
		return pmShLib;
	}

	@Override
	public List<File> getAllBundleDirs(File rootDir) {
		List<String> out = Arrays.asList(execShLibFunction(loadPmShLib(), "pmGetAllBundleDirs", rootDir.getAbsolutePath()).split(SHELL_LIST_SEPARATOR));
	
		// Map to files
		return out.stream().map(File::new).collect(Collectors.toList());
	}

	@Override
	public String getEclipseProjectName(File bundleDir) {
		return execShLibFunction(loadPmShLib(), "pmGetEclipseProjectName", bundleDir.getAbsolutePath());
	}

	@Override
	public String getManifestSymbolicName(File bundleDir) {
		return execShLibFunction(loadPmShLib(), "pmGetManifestSymbolicName", bundleDir.getAbsolutePath());
	}

	@Override
	public String getManifestVendor(File bundleDir) {
		return execShLibFunction(loadPmShLib(), "pmGetManifestVendor", bundleDir.getAbsolutePath());
	}

	@Override
	public String getManifestVersion(File bundleDir) {
		return execShLibFunction(loadPmShLib(), "pmGetManifestVersion", bundleDir.getAbsolutePath());
	}

	@Override
	public boolean isManifestDirShape(File bundleDir) {
		return execShLibFunction(loadPmShLib(), "pmGetManifestShape", bundleDir.getAbsolutePath()).equals("dir");
	}

	@Override
	public List<String> getManifestRequiredTools(File bundleDir) {
		List<String> out = Arrays
				.asList(execShLibFunction(loadPmShLib(), "pmGetManifestRequiredTools", bundleDir.getAbsolutePath()).split(SHELL_LIST_SEPARATOR));
		return sanitizeList(out);
	}

	@Override
	public List<String> getManifestRequiredBundles(File bundleDir) {
		List<String> out = Arrays
				.asList(execShLibFunction(loadPmShLib(), "pmGetManifestRequiredBundles", bundleDir.getAbsolutePath()).split(SHELL_LIST_SEPARATOR));
		return sanitizeList(out);
	}

	@Override
	public void checkTool(String tool) {
		execShLibFunction(loadPmShLib(), "pmCheckTool", tool);
	}

}
