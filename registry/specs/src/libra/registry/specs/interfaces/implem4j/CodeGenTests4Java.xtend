package libra.registry.specs.interfaces.implem4j

import libra.registry.specs.interfaces.CodeGenSpecs
import org.junit.Assume

class CodeGenTests4Java extends CodeGenSpecs {

	val gc = GenCodeManager.INSTANCE
	val testInput = GenCodeInputs.getTestFile(GenCodeInputs.SIMPLE).absolutePath
	val testInvalid = GenCodeInputs.getTestFile(GenCodeInputs.INVALID).absolutePath
	
	override s010_codeGen_mainLanguage() {
		gc.exec(1, "-i", testInput)							// Try without language
		gc.exec(2, "-i", testInput, "-l", "foo")			// Try with unknown language
		gc.exec(2, "-i", testInput, "--language", "bar")	// Try with unknown language
		gc.exec(0, "-i", testInput, "--language", "java")	// Try with known language
	}

	override s011_codeGen_mainInput() {
		gc.exec(3, "-l", "java")						// Try without input
		gc.exec(4, "-l", "java", "-i", "/foo/bar")		// Try with unknown path
		gc.exec(4, "-l", "java", "--input", "/foo/bar")	// Try with unknown path
		gc.exec(4, "-l", "java", "-i", testInvalid)		// Try with invalid file
		gc.exec(0, "-l", "java", "-i", testInput)		// Try with valid file
	}
	
	override s020_codeGen_interface() {
		Assume.assumeTrue(false);
	}
	
}