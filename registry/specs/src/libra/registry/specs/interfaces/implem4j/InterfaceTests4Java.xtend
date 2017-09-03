package libra.registry.specs.interfaces.implem4j

import java.io.File
import libra.misc.pluginManager.PluginManager
import libra.registry.specs.interfaces.InterfaceSpecs
import org.junit.Assume
import org.junit.Assert
import org.apache.commons.io.FileUtils

class InterfaceTests4Java extends InterfaceSpecs {
	
	val SIMPLE = "simpleSample"
	val INVALID = "invalid"
	var EXPECTED_SIMPLE_TOKEN = "9cce19afe575188b48e84787e3445b2f"
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
		Assert.assertEquals(EXPECTED_SIMPLE_TOKEN, token)
	}
	
	override s021_interfaceToken_docUpdate() {
		// Modify documentation
		var initialContent = FileUtils.readFileToString(getTestFile(SIMPLE))
		var modifiedContent = initialContent.replace("This is a sample interface","Alternative doc intro").replace("to get an hello world string","to print an hello world string")
		Assert.assertNotEquals(initialContent, modifiedContent)
		var updatedFile = File.createTempFile("docUpdate", ".json");
		FileUtils.writeStringToFile(updatedFile, modifiedContent)
		
		// Get token
		var token = im.token(updatedFile)
		Assert.assertEquals(EXPECTED_SIMPLE_TOKEN, token)
	}
	
	override s022_interfaceToken_formatUpdate() {
		// Modify formatting
		var initialContent = FileUtils.readFileToString(getTestFile(SIMPLE))
		var modifiedContent = initialContent.replaceAll("\t","    ")
		Assert.assertNotEquals(initialContent, modifiedContent)
		var updatedFile = File.createTempFile("formatUpdate", ".json");
		FileUtils.writeStringToFile(updatedFile, modifiedContent)
		
		// Get token
		var token = im.token(updatedFile)
		Assert.assertEquals(EXPECTED_SIMPLE_TOKEN, token)
	}
	
	override s023_interfaceToken_methodArgsUpdate() {
		// TODO
		Assume.assumeTrue("TODO: auto-generated method stub", false)
	}
	
	override s024_interfaceToken_methodsUpdate() {
		// Rename method
		var initialContent = FileUtils.readFileToString(getTestFile(SIMPLE))
		var modifiedContent = initialContent.replaceAll("printHello2","sayHello")
		Assert.assertNotEquals(initialContent, modifiedContent)
		var updatedFile = File.createTempFile("methodRenamed", ".json");
		FileUtils.writeStringToFile(updatedFile, modifiedContent)
		
		// Get token
		var token = im.token(updatedFile)
		Assert.assertNotEquals(EXPECTED_SIMPLE_TOKEN, token)
	}
	
	override s030_interfaceMethods() {
		var methods = im.methods(getTestFile(SIMPLE))
		Assert.assertEquals(2, methods.size)
		Assert.assertEquals("printHello", methods.get(0))
		Assert.assertEquals("printHello2", methods.get(1))
	}
	
}