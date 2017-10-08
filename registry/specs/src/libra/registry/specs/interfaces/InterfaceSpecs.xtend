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
	def abstract void s010_interfaceSyntax_validateJson();
	
	/**
	 * Interface files shall allow to manipulate basic built-in data types.
	 * 
	 * The allowed types are the following ones:
	 * - void:		only for methods without return type
	 * - string:	a character string
	 * 
	 * The interface lib shall provide a method to validate if a data type is known
	 */
	@Test
	def abstract void s011_interfaceSyntax_validateType();

	/**
	 * Interface files shall provide a main documentation text
	 * 
	 * The interface lib shall provide a method to get this text
	 */
	@Test
	def abstract void s015_interfaceMain_doc();

	/**
	 * A given interface name shall be deduced from the interface JSON file name.
	 * 
	 * The interface lib shall provide a method to get this name
	 */
	@Test
	def abstract void s016_interfaceMain_name();

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
	 * Each method is at least identified by a "name" field.
	 * 
	 * Example:
	 "methods": [ {
			"name":"printHello"
		},{
			"name":"printHello2"
		} ]
	 */
	@Test
	def abstract void s030_interfaceMethods();
	
	/**
	 * A method should have a returned type, specified in a "ret" field.
	 * The interface lib shall verify that used returned types are valid.
	 * 
	 * Example:
	 "methods": [ {
			"name":"printHello",
			"ret":"string"
		} ]
	 */
	@Test
	def abstract void s031_interfaceMethods_returnType();
		
	/**
	 * A method should have no return type. This is equivalent to have a "void" type. In this case the "ret" field should not be present.
	 * 
	 * Example:
	 "methods": [ {
			"name":"doSomething"
		} ]
	 */
	@Test
	def abstract void s032_interfaceMethods_returnVoid();
		
	/**
	 * A method shall have some documentation text, provided in the "doc" field.
	 * 
	 * Example:
	 "methods": [ {
			"name":"doSomething",
			"doc":"Some documentation..."
		} ]
	 */
	@Test
	def abstract void s033_interfaceMethods_doc();
}