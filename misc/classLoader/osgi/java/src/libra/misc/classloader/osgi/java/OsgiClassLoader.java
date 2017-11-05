package libra.misc.classloader.osgi.java;

import java.util.Arrays;
import java.util.Optional;

import org.osgi.framework.Bundle;

public class OsgiClassLoader implements IClassLoader {

	@Override
	public Class<?> loadClass(String bundleID, String className) {
		Optional<Bundle> b = Arrays.asList(Activator.getContext().getBundles()).stream().filter(bd -> bd.getSymbolicName().equals(bundleID)).findFirst();
		if (!b.isPresent()) {
			throw new IllegalStateException("Bundle not found: " + bundleID);
		}

		try {
			return b.get().loadClass(className);
		} catch (ClassNotFoundException e) {
			throw new IllegalStateException("Class not found: " + className, e);
		}
	}

}
