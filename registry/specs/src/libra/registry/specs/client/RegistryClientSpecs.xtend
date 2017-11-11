package libra.registry.specs.client

import org.junit.Test
import org.junit.FixMethodOrder
import org.junit.runners.MethodSorters

@FixMethodOrder(MethodSorters.NAME_ASCENDING)
abstract class RegistryClientSpecs {
	
	/**
	 * Registry shall provide a client interface, in order to allow accessing to registered services.
	 * 
	 * Input parameters for a service client access are:
	 * - the service path
	 * - the service interface
	 */
	@Test
	def abstract void s010_access();
	
	/**
	 * The service path is a string allowing to specify - more or less specifically - the required service to be accessed.
	 * 
	 * A full service path is composed of the following segments:
	 * - a network name
	 * - a domain name
	 * - an host name
	 * - a process name
	 * - a service name
	 * - an instance name
	 * 
	 * Each segment must respect the following regular expression:
	 *     [a-zA-Z][a-zA-Z0-9_\-]*
	 * 
	 * Segments are separated by a dot (".") character
	 * 
	 * Most of the segments are optional. When not all of the segments are specified, the resolution order is the following:
	 * - service
	 * - service.instance
	 * - process.service.instance
	 * - host.process.service.instance
	 * - domain.host.process.service.instance
	 * - network.domain.host.process.service.instance
	 */
	@Test
	def abstract void s011_access_path();

	/**
	 * Trying to accessing to an unknown service will lead to an exception
	 */
	@Test
	def abstract void s012_access_unknown();

	/**
	 * Service resolution can be handled by a direct provider (allowing to resolve implementation coming from the current process)
	 * It allows to resolve implementations registered dynamically to the provider
	 */
	@Test
	def abstract void s020_direct_dynamic();

	/**
	 * It allows as well to resolve implementations contributed by extension point
	 */
	@Test
	def abstract void s021_direct_contrib();
}
