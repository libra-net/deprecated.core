package libra.registry.client.implem;

import java.util.Comparator;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

import libra.misc.pluginManager.XPReader;
import libra.misc.pluginManager.XPReader.XPContrib;
import libra.registry.client.IRegistryClient;
import libra.registry.client.resolver.IRegistryResolver;

public class RegistryClient implements IRegistryClient {

	private static XPReader xpr = XPReader.INSTANCE;
	private static List<IRegistryResolver> resolvers = null;

	@Override
	public <ITF> ITF getService(Class<ITF> itfClass, String servicePath) {
		// Init resolvers if needed
		initResolvers();

		// Give a try with each resolver
		ITF service = null;
		for (IRegistryResolver r : resolvers) {
			Optional<ITF> s = r.getService(itfClass, servicePath);
			if (s.isPresent()) {
				// Service found, use it and stop looping
				service = s.get();
				break;
			}
		}

		// Can't decently return a null service
		if (service == null) {
			throw new IllegalStateException("Unable to resolve service: " + itfClass.getName() + " / " + servicePath);
		}

		return service;
	}

	private void initResolvers() {
		if (resolvers == null) {
			List<XPContrib> contribs = xpr.getContributions("libra.registry.client.common.resolver");
			if (contribs.isEmpty()) {
				throw new IllegalStateException("Problem with registry client: no resolvers contribution found");
			}
			resolvers = contribs.stream().flatMap(c -> xpr.getElements(c, "resolver").stream()).sorted(comparator()).map(this::getResolver)
					.filter(Objects::nonNull).collect(Collectors.toList());
			if (resolvers.isEmpty()) {
				throw new IllegalStateException("Problem with registry client: no valid resolvers found");
			}
		}
	}

	private Comparator<XPContrib> comparator() {
		return new Comparator<XPReader.XPContrib>() {
			@Override
			public int compare(XPContrib o1, XPContrib o2) {
				return getPriority(o1) - getPriority(o2);
			}
		};
	}

	private int getPriority(XPContrib c) {
		return xpr.getStringAttribute(c, "priority").map(Integer::parseInt).orElse(100);
	}

	private IRegistryResolver getResolver(XPContrib c) {
		// Get class name
		Optional<String> className = xpr.getStringAttribute(c, "implem");
		if (!className.isPresent()) {
			// TODO: log contribution ignored
			return null;
		}

		// Get class
		Class<?> clazz = null;
		try {
			clazz = Class.forName(className.get());
		} catch (ClassNotFoundException e) {
			// TODO: log contribution ignored
			return null;
		}

		// Create instance
		try {
			return (IRegistryResolver) clazz.getConstructor().newInstance();
		} catch (Exception e) {
			// TODO: log contribution ignored
			return null;
		}
	}
}
