package libra.registry.specs.provider

import org.junit.Test
import org.junit.FixMethodOrder
import org.junit.runners.MethodSorters

@FixMethodOrder(MethodSorters.NAME_ASCENDING)
abstract class SrvProviderSpecs {
	
	/**
	 * Registry shall provide a method to register a service.
	 * 
	 * Input parameters for a service registration are:
	 * - the service ID
	 * - the service interface token
	 * - an entry point
	 * - the implementation language ID
	 * - some options
	 */
	@Test
	def abstract void s010_registration();
	
	/**
	 * The service ID is an alphanumeric string, which must respect the following regular expression:
	 *     [a-zA-Z][a-zA-Z0-9_\-]*
	 */
	@Test
	def abstract void s011_registration_ID();

	/**
	 * The interface token is a string reckoned from the corresponding JSON description file.
	 * For more details, cf {@link libra.registry.specs.interfaces.InterfaceSpecs#s020_interfaceToken()}
	 */
	@Test
	def abstract void s012_registration_interface();

	/**
	 * The entry point is a function to be called when a new service instance needs to be created.
	 * This entry point must respect the required interface, and can't be null.
	 */
	@Test
	def abstract void s013_registration_entry();

	/**
	 * The registration options are boolean flags that can be enabled or disabled.
	 */
	@Test
	def abstract void s014_registration_options();
}