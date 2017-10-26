package libra.registry.provider.implem;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;

import libra.misc.pluginManager.XPReader;
import libra.misc.pluginManager.XPReader.XPContrib;
import libra.registry.provider.IRegistryProvider;

public class RegistryProvider implements IRegistryProvider {

	private static final Pattern ID_PATTERN = Pattern.compile("[a-zA-Z][a-zA-Z0-9_\\-]*");
	private static final XPReader XPR = XPReader.INSTANCE;

	private List<ServiceDescriptor> registeredServices = new ArrayList<>();

	public RegistryProvider() {
		// Register extension point contributions
		XPR.getContributions("libra.registry.provider.common.xp").stream().flatMap(c -> XPR.getElements(c, "service").stream()).forEach(c -> manageContrib(c));
	}

	private void manageContrib(XPContrib c) {
		try {
			// Extract contrib attributes and register service
			// @formatter:off
			registerService(
				Class.forName(XPR.getStringAttribute(c, "interface").get()),
				XPR.getStringAttribute(c, "id").get(),
				instantiate(XPR.getStringAttribute(c, "entryPoint").get()));
			// @formatter:on
		} catch (Exception e) {
			// TODO Something went wrong, log it here
			e.printStackTrace();
		}
	}

	private Object instantiate(final String className) {
		try {
			return Class.forName(className).newInstance();
		} catch (InstantiationException | IllegalAccessException | ClassNotFoundException e) {
			throw new IllegalStateException(e);
		}
	}

	@Override
	public synchronized <ITF> void registerService(Class<ITF> interfaceClass, String ID, Object implem) {
		// Verify inputs
		if (!verifyID(ID)) {
			throw new UnsupportedOperationException("Malformed service ID: " + ID);
		}
		String interfaceToken = getToken(interfaceClass);
		if (!verifyToken(interfaceToken)) {
			throw new UnsupportedOperationException("Malformed interface token: " + interfaceToken);
		}
		if (implem == null) {
			throw new UnsupportedOperationException("Entry point can't be null");
		}

		// Reckon identifier, and check for local singleton
		if (getService(interfaceClass, ID).isPresent()) {
			throw new UnsupportedOperationException("Service already registered: " + ID + "/" + interfaceToken);
		}

		// Register
		registeredServices.add(new ServiceDescriptor(ID, interfaceToken, implem));
	}

	private String getToken(Class<?> interfaceClass) {
		try {
			return (String) interfaceClass.getDeclaredField("_TOKEN").get(null);
		} catch (Exception e) {
			throw new IllegalArgumentException("Token not found in " + interfaceClass.getName(), e);
		}
	}

	@Override
	public <ITF> Optional<ITF> getService(Class<ITF> interfaceClass, String ID) {
		return registeredServices.stream().filter(s -> s.getId().equals(ID) && s.getInterfaceToken().equals(getToken(interfaceClass))).findFirst()
				.map(s -> s.getImplem(interfaceClass));
	}

	private boolean verifyToken(String interfaceToken) {
		return StringUtils.isNotBlank(interfaceToken);
	}

	private boolean verifyID(String ID) {
		return ID_PATTERN.matcher(ID).matches();
	}

}
