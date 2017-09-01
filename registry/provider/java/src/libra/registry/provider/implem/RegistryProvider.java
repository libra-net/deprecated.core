package libra.registry.provider.implem;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;

import libra.misc.pluginManager.XPReader;
import libra.misc.pluginManager.XPReader.XPContrib;
import libra.registry.provider.IRegistryProvider;
import libra.registry.provider.IService;
import libra.registry.provider.ServiceImplem;

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
				XPR.getStringAttribute(c, "id").get(),
				XPR.getStringAttribute(c, "interface").get(),
				instantiate(XPR.getStringAttribute(c, "entryPoint").get()),
				ServiceImplem.valueOf(XPR.getStringAttribute(c, "implem").get().toUpperCase()));
			// @formatter:on
		} catch (RuntimeException e) {
			// Something went wrong, log it here
			e.printStackTrace();
		}
	}

	private IService instantiate(final String className) {
		try {
			return IService.class.cast(Class.forName(className).newInstance());
		} catch (InstantiationException | IllegalAccessException | ClassNotFoundException e) {
			throw new IllegalStateException(e);
		}
	}

	@Override
	public synchronized void registerService(String ID, String interfaceToken, IService entryPoint, ServiceImplem implem) {
		// Verify inputs
		if (!verifyID(ID)) {
			throw new UnsupportedOperationException("Malformed service ID: " + ID);
		}
		if (!verifyToken(interfaceToken)) {
			throw new UnsupportedOperationException("Malformed interface token: " + interfaceToken);
		}
		if (entryPoint == null) {
			throw new UnsupportedOperationException("Entry point can't be null");
		}

		// Reckon identifier, and check for local singleton
		if (getService(ID, interfaceToken).isPresent()) {
			throw new UnsupportedOperationException("Service already registered: " + ID + "/" + interfaceToken);
		}

		// Register
		registeredServices.add(new ServiceDescriptor(ID, interfaceToken, entryPoint, implem));
	}

	private Optional<ServiceDescriptor> getService(String iD, String interfaceToken) {
		return registeredServices.stream().filter(s -> s.getId().equals(iD) && s.getInterfaceToken().equals(interfaceToken)).findFirst();
	}

	private boolean verifyToken(String interfaceToken) {
		return StringUtils.isNotBlank(interfaceToken);
	}

	private boolean verifyID(String ID) {
		return ID_PATTERN.matcher(ID).matches();
	}

}
