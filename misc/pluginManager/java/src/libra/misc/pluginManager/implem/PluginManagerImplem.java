package libra.misc.pluginManager.implem;

import java.io.File;
import java.net.URL;

import libra.misc.pluginManager.PluginManager;
import libra.misc.pluginManager.wrapper.ExternalProcessWrapper;

public class PluginManagerImplem extends ExternalProcessWrapper implements PluginManager {

	private static final String C = "-c";
	private static final String BASH = "bash";

	@Override
	public File getBundleDir(String bundleID) {
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
			File root = new File(absPath.substring(0, sourceTreeIndex));
			File bundleDir = root;

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

		throw new UnsupportedOperationException("Unsupported URL format");
	}

	private static String pmShLib = null;

	private String loadPmShLib() {
		if (pmShLib == null) {
			final File bundleDir = getBundleDir("libra.misc.pluginManager.sh");
			final String classPath = "lib"; // Hard-coded classpath here... Chicken and egg situation otherwise.
			pmShLib = new File(new File(bundleDir, classPath), "libPluginManager.sh").getAbsolutePath();
		}
		return "source " + pmShLib + "; ";
	}

	@Override
	public String getEclipseProjectName(File bundleDir) {
		return execProcess(BASH, C, loadPmShLib() + "pmGetEclipseProjectName " + bundleDir.getAbsolutePath());
	}

	@Override
	public String getManifestSymbolicName(File bundleDir) {
		return execProcess(BASH, C, loadPmShLib() + "pmGetManifestSymbolicName " + bundleDir.getAbsolutePath());
	}

}
