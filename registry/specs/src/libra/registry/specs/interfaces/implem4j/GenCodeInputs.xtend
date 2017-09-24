package libra.registry.specs.interfaces.implem4j

import java.io.File
import libra.misc.pluginManager.PluginManager

class GenCodeInputs {
	public static val SIMPLE = "simpleSample"
	public static val INVALID = "invalid"
		
	static def getTestFile(String name) {
		return new File(PluginManager.INSTANCE.getBundleDir("libra.registry.specs") + "/testInterfaces/" + name + ".json");
	}
}