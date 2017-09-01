package libra.registry.provider;

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
	 * @param ID
	 *            Service ID: an alphanumeric string, which must respect the following regular expression: [a-zA-Z][a-zA-Z0-9_\-]*
	 * @param interfaceToken
	 *            Interface token, got from the generated interface code
	 * @param entryPoint
	 *            Entry point interface, to be called when a new service instance is requested
	 * @param implem
	 *            Implementation language
	 */
	void registerService(String ID, String interfaceToken, IService entryPoint, ServiceImplem implem);
}
