package libra.registry.provider.implem;

import libra.registry.provider.IService;
import libra.registry.provider.ServiceImplem;

public class ServiceDescriptor {

	private String id;
	private String interfaceToken;
	private IService entryPoint;
	private ServiceImplem implem;

	public ServiceDescriptor(String id, String interfaceToken, IService entryPoint, ServiceImplem implem) {
		this.id = id;
		this.interfaceToken = interfaceToken;
		this.entryPoint = entryPoint;
		this.implem = implem;
	}

	public String getId() {
		return id;
	}

	public String getInterfaceToken() {
		return interfaceToken;
	}

	public IService getEntryPoint() {
		return entryPoint;
	}

	public ServiceImplem getImplem() {
		return implem;
	}
}
