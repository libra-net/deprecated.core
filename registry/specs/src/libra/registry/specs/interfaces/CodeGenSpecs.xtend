package libra.registry.specs.interfaces

import org.junit.Test
import org.junit.FixMethodOrder
import org.junit.runners.MethodSorters

/**
 * Code generators are provided in order to generate code for various implementation languages, from an input interface file.
 */
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
abstract class CodeGenSpecs {
	
	/**
	 * When invoked, code generator needs to be told for which language it has to generate code.
	 * Not specifying the language is an error.
	 */
	@Test
	def abstract void s010_codeGen_mainLanguage();
	
	/**
	 * When invoked, code generator needs to be told for which input interface JSON file it has to generate code.
	 * Not specifying the input is an error.
	 * Moreover, it has to be a valid existing interface file.
	 */
	@Test
	def abstract void s011_codeGen_mainInput();
	
	/**
	 * When invoked, code generator needs to be told which kind of code it has to generate.
	 * Not specifying the type is an error.
	 */
	@Test
	def abstract void s012_codeGen_mainType();
	
	/**
	 * Some languages need an Interface file to specify the service to be implemented/used.
	 * The code generator shall be able to generate this interface file from an input interface JSON file.
	 * 
	 * Applicable to:
	 * - Java
	 */
	@Test
	def abstract void s020_codeGen_interface();
}