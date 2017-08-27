package libra.registry.provider.implem;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.tuple.ImmutablePair;
import org.apache.commons.lang3.tuple.Pair;

import libra.registry.provider.IRegistryProvider;
import libra.registry.provider.IService;

public class RegistryProvider implements IRegistryProvider {

	private static final Pattern ID_PATTERN = Pattern.compile("[a-zA-Z][a-zA-Z0-9_\\-]*");

	private Map<Pair<String, String>, IService> registeredServices = new HashMap<>();

	public RegistryProvider() {
		// TODO Should trigger the registration from the extension point here
	}

	@Override
	public synchronized void registerService(String ID, String interfaceToken, IService entryPoint) {
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
		Pair<String, String> mapID = new ImmutablePair<>(ID, interfaceToken);
		if (registeredServices.containsKey(mapID)) {
			throw new UnsupportedOperationException("Service already registered: " + mapID);
		}

		// Register
		registeredServices.put(mapID, entryPoint);
	}

	private boolean verifyToken(String interfaceToken) {
		return StringUtils.isNotBlank(interfaceToken);
	}

	private boolean verifyID(String ID) {
		return ID_PATTERN.matcher(ID).matches();
	}

}
