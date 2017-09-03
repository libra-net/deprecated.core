package libra.registry.specs.interfaces.implem4j;

import java.io.File;
import java.util.Arrays;
import java.util.List;

import libra.misc.extProc.ShLibProcessWrapper;
import libra.misc.pluginManager.PluginManager;

public class InterfacesManager extends ShLibProcessWrapper {

	public static final InterfacesManager INSTANCE = new InterfacesManager();

	private static File itfShLib = null;

	private File loadItfShLib() {
		if (itfShLib == null) {
			final File bundleDir = PluginManager.INSTANCE.getBundleDir("libra.registry.interfaces.sh");
			final String classPath = "lib"; // TODO should use an API here...
			itfShLib = new File(new File(bundleDir, classPath), "libInterfaces.sh");
		}
		return itfShLib;
	}

	public void validate(File itfFile) {
		execShLibFunction(loadItfShLib(), "itfValidate", itfFile.getAbsolutePath());
	}

	public void validateType(File itfFile, String typeName) {
		execShLibFunction(loadItfShLib(), "itfValidateType", itfFile.getAbsolutePath(), typeName);
	}

	public String token(File itfFile) {
		return execShLibFunction(loadItfShLib(), "itfToken", itfFile.getAbsolutePath());
	}

	public List<String> methods(File itfFile) {
		List<String> out = Arrays.asList(execShLibFunction(loadItfShLib(), "itfMethods", itfFile.getAbsolutePath()).split(SHELL_LIST_SEPARATOR));
		sanitizeList(out);
		return out;
	}

	public String methodGetType(File itfFile, String name) {
		return execShLibFunction(loadItfShLib(), "itfMethodGetType", itfFile.getAbsolutePath(), name);
	}
}
