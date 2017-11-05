package libra.misc.classloader.osgi.java;

public interface IClassLoader {

	Class<?> loadClass(String bundleID, String className);

}
