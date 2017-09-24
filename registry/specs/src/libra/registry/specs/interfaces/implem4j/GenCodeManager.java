package libra.registry.specs.interfaces.implem4j;

import java.io.File;

import libra.misc.extProc.ExternalProcessWrapper;
import libra.misc.pluginManager.PluginManager;

public class GenCodeManager extends ExternalProcessWrapper {

	public static final GenCodeManager INSTANCE = new GenCodeManager();

	private static File genCodeCmd = null;

	private File loadGenCodeCmd() {
		if (genCodeCmd == null) {
			final File bundleDir = PluginManager.INSTANCE.getBundleDir("libra.registry.interfaces.sh");
			final String classPath = "cmd"; // TODO should use an API here...
			genCodeCmd = new File(new File(bundleDir, classPath), "gencode.sh");
		}
		return genCodeCmd;
	}

	public String exec(int expectedRC, String... args) {
		return execProcess(expectedRC, loadGenCodeCmd(), args);
	}
}
