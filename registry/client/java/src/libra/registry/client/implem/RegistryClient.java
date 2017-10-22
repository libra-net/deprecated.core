package libra.registry.client.implem;

import libra.registry.client.IRegistryClient;

public class RegistryClient implements IRegistryClient {

	@Override
	public <ITF> ITF getService(Class<ITF> itfClass, String servicePath) {
		// TODO Implement service resolvers:
		// * Direct: Java client & Java implem, directly linked together
		// * External process: map to external CLI tool
		// * MQTT RPC: access to remote service via MQTT
		return null;
	}

}
