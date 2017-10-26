package libra.registry.provider.implem;

public class ServiceDescriptor {

	private String id;
	private String interfaceToken;
	private Object implem;

	public ServiceDescriptor(String id, String interfaceToken, Object implem) {
		this.id = id;
		this.interfaceToken = interfaceToken;
		this.implem = implem;
	}

	public String getId() {
		return id;
	}

	public String getInterfaceToken() {
		return interfaceToken;
	}

	public <ITF> ITF getImplem(Class<ITF> interfaceClass) {
		return interfaceClass.cast(implem);
	}
}
