package libra.registry.specs.interfaces.implem4j

import java.io.File
import libra.misc.pluginManager.PluginManager
import libra.registry.specs.interfaces.InterfaceSpecs
import org.junit.Assume
import org.junit.Assert

class InterfaceTests4Java extends InterfaceSpecs {
	
	val SIMPLE = "simpleSample"
	val INVALID = "invalid"
	val im = InterfacesManager.INSTANCE
	
	def getTestFile(String name) {
		return new File(PluginManager.INSTANCE.getBundleDir("libra.registry.specs") + "/testInterfaces/" + name + ".json");
	}
	
	override s010_interfaceSyntax_validate() {
		// Verify simple sample
		im.validate(getTestFile(SIMPLE))
		
		try {
			// Verify invalid syntax
			im.validate(getTestFile(INVALID))
			Assert.fail("Validation was expected to fail")
		} catch (UnsupportedOperationException e) {
			// OK, expected behavior
		}
	}
	
	override s020_interfaceToken() {
		// Get token
		var token = im.token(getTestFile(SIMPLE))
		Assert.assertEquals("9cce19afe575188b48e84787e3445b2f", token)
	}
	
	override s021_interfaceToken_docUpdate() {
		Assume.assumeTrue("TODO: auto-generated method stub", false)
	}
	
	override s022_interfaceToken_formatUpdate() {
		Assume.assumeTrue("TODO: auto-generated method stub", false)
	}
	
	override s023_interfaceToken_methodArgsUpdate() {
		Assume.assumeTrue("TODO: auto-generated method stub", false)
	}
	
	override s024_interfaceToken_methodsUpdate() {
		Assume.assumeTrue("TODO: auto-generated method stub", false)
	}
	
	override s030_interfaceMethods() {
		var methods = im.methods(getTestFile(SIMPLE))
		Assert.assertEquals(2, methods.size)
		Assert.assertEquals("printHello", methods.get(0))
		Assert.assertEquals("printHello2", methods.get(1))
	}
	
}