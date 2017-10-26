package libra.registry.client.resolver;

import java.util.Optional;

public interface IRegistryResolver {

	/**
	 * Generic service access method
	 * 
	 * @param itfClass
	 *            Interface to be used for this service
	 * @param servicePath
	 *            Path to the service to be used
	 * 
	 * @return Service instance, ready to be used, if it has been successfully resolved by this implementation
	 */
	<ITF> Optional<ITF> getService(Class<ITF> itfClass, String servicePath);

}
