package libra.registry.specs.provider

import org.junit.Test
import org.junit.FixMethodOrder
import org.junit.runners.MethodSorters

@FixMethodOrder(MethodSorters.NAME_ASCENDING)
abstract class SrvProviderSpecs {
	
	/**
	 * Registry api shall provide a method to register a service
	 */
	@Test
	def abstract void s010_registration();
	
}