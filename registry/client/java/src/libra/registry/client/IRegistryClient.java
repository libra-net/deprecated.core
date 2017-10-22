package libra.registry.client;

import libra.registry.client.implem.RegistryClient;

/**
 * This interface allows service clients to get a service interface from the registry.
 * 
 * @author david
 *
 */
public interface IRegistryClient {

	/**
	 * Registry client singleton instance
	 */
	final static IRegistryClient INSTANCE = new RegistryClient();

	/**
	 * Generic service access method
	 * 
	 * @param itfClass
	 *            Interface to be used for this service
	 * @param servicePath
	 *            Path to the service to be used
	 * 
	 * @return Service instance, ready to be used
	 */
	<ITF> ITF getService(Class<ITF> itfClass, String servicePath);
}
