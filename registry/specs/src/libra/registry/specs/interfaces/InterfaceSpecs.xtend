package libra.registry.specs.interfaces

import org.junit.Test
import org.junit.FixMethodOrder
import org.junit.runners.MethodSorters

@FixMethodOrder(MethodSorters.NAME_ASCENDING)
abstract class InterfaceSpecs {
	
	/**
	 * Interfaces are definitions of how a service client triggers function calls and exchanges
	 * data with a service provider.
	 * 
	 * Interfaces are defined thanks to a JSON file, that is wholly describing and documenting it.
	 * 
	 * For a given interface, and for a given implementation language, glue code needs to be generated
	 * to let the service provider/client handling this interface.
	 * 
	 * Interfaces are uniquely identified by a token that is generated from the interface JSON file content.
	 */
	@Test
	def abstract void s010_interface();
	
}