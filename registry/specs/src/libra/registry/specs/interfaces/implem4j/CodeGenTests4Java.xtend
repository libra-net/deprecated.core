package libra.registry.specs.interfaces.implem4j

import libra.registry.specs.interfaces.CodeGenSpecs
import org.junit.Assert
import java.io.File
import org.apache.commons.io.FileUtils

class CodeGenTests4Java extends CodeGenSpecs {

	static val gc = GenCodeManager.INSTANCE
	static val testInput = GenCodeInputs.getTestFile(GenCodeInputs.SIMPLE).absolutePath
	static val testInvalid = GenCodeInputs.getTestFile(GenCodeInputs.INVALID).absolutePath
	static val expectedPath = "/tmp/libra/itf/SimpleSample.java"
	
	override s010_codeGen_mainLanguage() {
		gc.exec(1, "-i", testInput)										// Try without language
		gc.exec(2, "-i", testInput, "-l", "foo")						// Try with unknown language
		gc.exec(2, "-i", testInput, "--language", "bar")				// Try with unknown language
		gc.exec(0, "-i", testInput, "--language", "java", "-t", "itf")	// Try with known language
	}

	override s011_codeGen_mainInput() {
		gc.exec(3, "-l", "java")								// Try without input
		gc.exec(4, "-l", "java", "-i", "/foo/bar")				// Try with unknown path
		gc.exec(4, "-l", "java", "--input", "/foo/bar")			// Try with unknown path
		gc.exec(4, "-l", "java", "-i", testInvalid)				// Try with invalid file
		gc.exec(0, "-l", "java", "-i", testInput, "-t", "itf")	// Try with valid file
	}
	
	override s012_codeGen_mainType() {
		gc.exec(5, "-l", "java", "-i", testInput)					// Try without type
		gc.exec(6, "-l", "java", "-i", testInput, "--type", "foo")	// Try with unknown type
		gc.exec(0, "-l", "java", "-i", testInput, "-t", "itf")		// Try with valid type
	}
	
	override s020_codeGen_interface() {
		cleanOutput
		gc.exec(0, "-l", "java", "-i", testInput, "-t", "itf")					// Generate Interface code to stdout
		gc.exec(0, "-l", "java", "-i", testInput, "-t", "itf", "-o", "/tmp" )	// Generate Interface code to temporary directory
		
		// Verify generated output
		Assert.assertTrue(new File(expectedPath).isFile)
		val generatedFile = FileUtils.readFileToString(new File(expectedPath))
		val expectedFile = FileUtils.readFileToString(GenCodeInputs.getTestFile(GenCodeInputs.SIMPLE_JAVA))
		Assert.assertEquals(expectedFile, generatedFile)
	}
	
	override s021_codeGen_interfaceToken() {
		cleanOutput
		gc.exec(0, "-l", "java", "-i", testInput, "-t", "itf", "-o", "/tmp" )	// Generate Interface code to temporary directory

		// Verify generated output
		Assert.assertTrue(new File(expectedPath).isFile)
		val generatedFile = FileUtils.readFileToString(new File(expectedPath))
		Assert.assertTrue(generatedFile.contains("_TOKEN"))
		Assert.assertTrue(generatedFile.contains(InterfaceTests4Java.EXPECTED_SIMPLE_TOKEN))
	}
	
	def cleanOutput() {
		// Initial clean
		new File(expectedPath).delete
		Assert.assertFalse(new File(expectedPath).isFile)
	}
}