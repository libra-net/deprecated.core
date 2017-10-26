package libra.registry.resolver.direct;

import java.util.Optional;

import libra.registry.client.resolver.IRegistryResolver;
import libra.registry.provider.IRegistryProvider;

public class DirectRegistryResolver implements IRegistryResolver {

	@Override
	public <ITF> Optional<ITF> getService(Class<ITF> itfClass, String servicePath) {
		// TODO: filter service name

		// Get potentially registered service
		return IRegistryProvider.INSTANCE.getService(itfClass, servicePath);
	}

}
