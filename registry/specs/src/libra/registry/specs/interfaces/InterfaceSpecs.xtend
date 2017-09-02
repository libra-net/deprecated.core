package libra.registry.specs.interfaces

import org.junit.Test
import org.junit.FixMethodOrder
import org.junit.runners.MethodSorters

/**
 * Interfaces are definitions of how a service client triggers function calls and exchanges
 * data with a service provider.
 * 
 * Interfaces are defined thanks to a JSON file, that is wholly describing and documenting it.
 * 
 * For a given interface, and for a given implementation language, glue code needs to be generated
 * to let the service provider/client handling this interface.
 */
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
abstract class InterfaceSpecs {
	
	/**
	 * Interface files need to be valid JSON file. The interface lib shall provide a method to validate JSON file syntax.
	 */
	@Test
	def abstract void s010_interfaceSyntax_validate();

	/**
	 * Interfaces are uniquely identified by a token that is generated from the interface JSON file content.
	 */
	@Test
	def abstract void s020_interfaceToken();
	
	/**
	 * The interface token is unchanged when only documentation is updated.
	 */
	@Test
	def abstract void s021_interfaceToken_docUpdate();
	
	/**
	 * The interface token is unchanged when only formatting (blank characters: space, tab, line end) is updated.
	 */
	@Test
	def abstract void s022_interfaceToken_formatUpdate();
	
	/**
	 * The interface token is changed when method arguments are modified (renamed, type change, added, removed).
	 */
	@Test
	def abstract void s023_interfaceToken_methodArgsUpdate();
	
	/**
	 * The interface token is changed when methods are modified (renamed, type change, added, removed).
	 */
	@Test
	def abstract void s024_interfaceToken_methodsUpdate();
	
	/**
	 * Interfaces shall provide a "methods" array, that lists all the methods provided by this interface.
	 * Each method is at least identified by a "name".
	 * 
	 * Example:
	 "methods": [ {
			"name":"printHello",
		},{
			"name":"printHello2",
		} ]
	 */
	@Test
	def abstract void s030_interfaceMethods();
}