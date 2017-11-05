package libra.registry.provider;

import java.util.Optional;

import libra.registry.provider.implem.RegistryProvider;

/**
 * This interface allows service providers to register into the service registry, in order to make their service available to the registry clients.
 * 
 * @author david
 *
 */
public interface IRegistryProvider {

	/**
	 * Registry provider singleton instance
	 */
	final static IRegistryProvider INSTANCE = new RegistryProvider();

	/**
	 * Service registration method
	 * 
	 * @param interface
	 *            Interface class
	 * @param ID
	 *            Service ID: an alphanumeric string, which must respect the following regular expression: [a-zA-Z][a-zA-Z0-9_\-]*
	 * @param implem
	 *            Service implementation instance
	 */
	<ITF> void registerService(Class<ITF> interfaceClass, String ID, ITF implem);

	/**
	 * Service access method
	 * 
	 * @param interface
	 *            Interface class
	 * @param ID
	 *            Service ID: an alphanumeric string, which must respect the following regular expression: [a-zA-Z][a-zA-Z0-9_\-]*
	 * @return The service instance
	 */
	<ITF> Optional<ITF> getService(Class<ITF> interfaceClass, String ID);
}
