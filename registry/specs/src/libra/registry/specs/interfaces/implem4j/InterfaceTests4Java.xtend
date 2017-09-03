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
	val EXPECTED_SIMPLE_TOKEN = "678f534f2f8c90543cda0735c85fd2c4"
	val METHOD_PRINT = "printHello"
	val METHOD_DO_SOMETHING = "doSomething"
	val TYPE_STRING = "string"
	val TYPE_VOID = "void"
	val im = InterfacesManager.INSTANCE
	
	def getTestFile(String name) {
		return new File(PluginManager.INSTANCE.getBundleDir("libra.registry.specs") + "/testInterfaces/" + name + ".json");
	}
	
	override s010_interfaceSyntax_validateJson() {
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
	
	override s011_interfaceSyntax_validateType() {
		// Verify known types
		im.validateType(getTestFile(SIMPLE), TYPE_STRING)
		im.validateType(getTestFile(SIMPLE), TYPE_VOID)
		
		try {
			// Verify unknown type
			im.validateType(getTestFile(INVALID), "unknown")
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
		var modifiedContent = initialContent.replaceAll(METHOD_PRINT,"sayHello")
		Assert.assertNotEquals(initialContent, modifiedContent)
		var updatedFile = File.createTempFile("methodRenamed", ".json");
		FileUtils.writeStringToFile(updatedFile, modifiedContent)
		
		// Get token
		var token = im.token(updatedFile)
		Assert.assertNotEquals(EXPECTED_SIMPLE_TOKEN, token)
	}
	
	override s030_interfaceMethods() {
		// Check methods
		var methods = im.methods(getTestFile(SIMPLE))
		Assert.assertEquals(2, methods.size)
		Assert.assertEquals(METHOD_PRINT, methods.get(0))
		Assert.assertEquals(METHOD_DO_SOMETHING, methods.get(1))
	}
	
	override s031_interfaceMethods_returnType() {
		// Check return type
		var type = im.methodGetType(getTestFile(SIMPLE), METHOD_PRINT)
		Assert.assertEquals(TYPE_STRING, type)
		
		// Unknown method shall cause an exception
		try {
			im.methodGetType(getTestFile(SIMPLE), "unknown")
			Assert.fail("Working with unknown method was expected to fail")
		} catch (UnsupportedOperationException e) {
			// OK, expected behavior
		}
		
		// Use unknown return type
		var initialContent = FileUtils.readFileToString(getTestFile(SIMPLE))
		var modifiedContent = initialContent.replaceAll(TYPE_STRING,"unknown")
		Assert.assertNotEquals(initialContent, modifiedContent)
		var updatedFile = File.createTempFile("unknownType", ".json");
		FileUtils.writeStringToFile(updatedFile, modifiedContent)
		
		// Unknown type shall cause an exception
		try {
			im.methodGetType(updatedFile, METHOD_PRINT)
			Assert.fail("Working with unknown return type was expected to fail")
		} catch (UnsupportedOperationException e) {
			// OK, expected behavior
		}
	}
	
	override s032_interfaceMethods_returnVoid() {
		// Check return type
		var type = im.methodGetType(getTestFile(SIMPLE), METHOD_DO_SOMETHING)
		Assert.assertEquals(TYPE_VOID, type)
	}
}