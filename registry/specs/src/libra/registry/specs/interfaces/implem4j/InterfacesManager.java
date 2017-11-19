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

	public String getDoc(File itfFile) {
		return execShLibFunction(loadItfShLib(), "itfDoc", itfFile.getAbsolutePath());
	}

	public String getName(File itfFile) {
		return execShLibFunction(loadItfShLib(), "itfName", itfFile.getAbsolutePath());
	}

	public String token(File itfFile) {
		return execShLibFunction(loadItfShLib(), "itfToken", itfFile.getAbsolutePath());
	}

	public List<String> methods(File itfFile) {
		List<String> out = Arrays.asList(execShLibFunction(loadItfShLib(), "itfMethods", itfFile.getAbsolutePath()).split(SHELL_LIST_SEPARATOR));
		out = sanitizeList(out);
		return out;
	}

	public String methodGetType(File itfFile, String name) {
		return execShLibFunction(loadItfShLib(), "itfMethodGetType", itfFile.getAbsolutePath(), name);
	}

	public String methodGetDoc(File itfFile, String name) {
		return execShLibFunction(loadItfShLib(), "itfMethodGetDoc", itfFile.getAbsolutePath(), name);
	}

	public List<String> methodGetArgs(File itfFile, String name) {
		List<String> out = Arrays.asList(execShLibFunction(loadItfShLib(), "itfMethodGetArgs", itfFile.getAbsolutePath(), name).split(SHELL_LIST_SEPARATOR));
		out = sanitizeList(out);
		return out;
	}

	public String methodGetArgType(File itfFile, String methodName, String argName) {
		return execShLibFunction(loadItfShLib(), "itfMethodGetArgType", itfFile.getAbsolutePath(), methodName, argName);
	}
}
