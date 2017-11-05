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
	 * - the service interface
	 * - an implementation
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
	 * The interface class is the interface which has to be implemented by this service.
	 * The interface provides a token, which is a string reckoned from the corresponding JSON description file.
	 * For more details, cf {@link libra.registry.specs.interfaces.InterfaceSpecs#s020_interfaceToken()}
	 */
	@Test
	def abstract void s012_registration_interface();

	/**
	 * The implementation is an instance that will be used to resolve method calls.
	 * This implementation must respect the required interface, and can't be null.
	 */
	@Test
	def abstract void s013_registration_entry();

	/**
	 * For a given ID + interface pair, only one service can be registered.
	 * Additional registrations will cause an exception.
	 */
	@Test
	def abstract void s014_registration_once();

	/**
	 * In addition to dynamic registration method, it is possible as well to register a service by contributing to 
	 * the service registry extension point.
	 * Except the registration method, dynamic and contributed services are managed the same way.
	 */
	@Test
	def abstract void s015_registration_contrib();
}
