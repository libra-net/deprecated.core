package libra.registry.specs.interfaces.implem4j

import java.io.File
import libra.registry.specs.interfaces.InterfaceSpecs
import org.apache.commons.io.FileUtils
import org.junit.Assert
import org.junit.Assume

class InterfaceTests4Java extends InterfaceSpecs {
	
	public static val EXPECTED_SIMPLE_TOKEN = "11eeb3b6a66a804be976eb39cc40a03c"
	static val METHOD_PRINT = "printHello"
	static val METHOD_DO_SOMETHING = "doSomething"
	static val METHOD_PRINT_SINGLE_ARG = "printSingleArg"
	static val TYPE_STRING = "string"
	static val TYPE_VOID = "void"
	static val im = InterfacesManager.INSTANCE
	
	override s010_interfaceSyntax_validateJson() {
		// Verify simple sample
		im.validate(GenCodeInputs.getTestFile(GenCodeInputs.SIMPLE))
		
		try {
			// Verify invalid syntax
			im.validate(GenCodeInputs.getTestFile(GenCodeInputs.INVALID))
			Assert.fail("Validation was expected to fail")
		} catch (UnsupportedOperationException e) {
			// OK, expected behavior
		}
	}
	
	override s011_interfaceSyntax_validateType() {
		// Verify known types
		im.validateType(GenCodeInputs.getTestFile(GenCodeInputs.SIMPLE), TYPE_STRING)
		im.validateType(GenCodeInputs.getTestFile(GenCodeInputs.SIMPLE), TYPE_VOID)
		
		try {
			// Verify unknown type
			im.validateType(GenCodeInputs.getTestFile(GenCodeInputs.INVALID), "unknown")
			Assert.fail("Validation was expected to fail")
		} catch (UnsupportedOperationException e) {
			// OK, expected behavior
		}
	}
	
	override s015_interfaceMain_doc() {
		// Check doc
		var doc = im.getDoc(GenCodeInputs.getTestFile(GenCodeInputs.SIMPLE))
		Assert.assertEquals("This is a sample interface", doc)
	}
	
	override s016_interfaceMain_name() {
		// Check name
		var name = im.getName(GenCodeInputs.getTestFile(GenCodeInputs.SIMPLE))
		Assert.assertEquals("SimpleSample", name)
	}
	
	override s020_interfaceToken() {
		// Get token
		var token = im.token(GenCodeInputs.getTestFile(GenCodeInputs.SIMPLE))
		Assert.assertEquals(EXPECTED_SIMPLE_TOKEN, token)
	}
	
	override s021_interfaceToken_docUpdate() {
		// Modify documentation
		var initialContent = FileUtils.readFileToString(GenCodeInputs.getTestFile(GenCodeInputs.SIMPLE))
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
		var initialContent = FileUtils.readFileToString(GenCodeInputs.getTestFile(GenCodeInputs.SIMPLE))
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
		var initialContent = FileUtils.readFileToString(GenCodeInputs.getTestFile(GenCodeInputs.SIMPLE))
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
		var methods = im.methods(GenCodeInputs.getTestFile(GenCodeInputs.SIMPLE))
		Assert.assertEquals(3, methods.size)
		Assert.assertEquals(METHOD_PRINT, methods.get(0))
		Assert.assertEquals(METHOD_DO_SOMETHING, methods.get(1))
		Assert.assertEquals(METHOD_PRINT_SINGLE_ARG, methods.get(2))
	}
	
	override s031_interfaceMethods_returnType() {
		// Check return type
		var type = im.methodGetType(GenCodeInputs.getTestFile(GenCodeInputs.SIMPLE), METHOD_PRINT)
		Assert.assertEquals(TYPE_STRING, type)
		
		// Unknown method shall cause an exception
		try {
			im.methodGetType(GenCodeInputs.getTestFile(GenCodeInputs.SIMPLE), "unknown")
			Assert.fail("Working with unknown method was expected to fail")
		} catch (UnsupportedOperationException e) {
			// OK, expected behavior
		}
		
		// Use unknown return type
		var initialContent = FileUtils.readFileToString(GenCodeInputs.getTestFile(GenCodeInputs.SIMPLE))
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
		var type = im.methodGetType(GenCodeInputs.getTestFile(GenCodeInputs.SIMPLE), METHOD_DO_SOMETHING)
		Assert.assertEquals(TYPE_VOID, type)
	}
	
	override s033_interfaceMethods_doc() {
		// Check doc
		var doc = im.methodGetDoc(GenCodeInputs.getTestFile(GenCodeInputs.SIMPLE), METHOD_DO_SOMETHING)
		Assert.assertEquals("Another function which doesn't return anything", doc)
	}
	
	override s040_interfaceMethodArgs() {
		// Check method with one arg
		var args = im.methodGetArgs(GenCodeInputs.getTestFile(GenCodeInputs.SIMPLE), METHOD_PRINT_SINGLE_ARG)
		Assert.assertEquals(1, args.size)
		Assert.assertEquals("first", args.get(0))
	}
	
	override s041_interfaceMethodArgs_None() {
		// Check method without args
		var args = im.methodGetArgs(GenCodeInputs.getTestFile(GenCodeInputs.SIMPLE), METHOD_DO_SOMETHING)
		Assert.assertTrue(args.empty)
	}
	
	override s042_interfaceMethodArgs_Type() {
		// Check method arg type
		var args = im.methodGetArgs(GenCodeInputs.getTestFile(GenCodeInputs.SIMPLE), METHOD_PRINT_SINGLE_ARG)
		var type = im.methodGetArgType(GenCodeInputs.getTestFile(GenCodeInputs.SIMPLE), METHOD_PRINT_SINGLE_ARG, args.get(0))
		Assert.assertEquals(TYPE_STRING, type)
	}
}