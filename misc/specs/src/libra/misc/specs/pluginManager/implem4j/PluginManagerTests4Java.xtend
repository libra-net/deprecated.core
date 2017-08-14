package libra.misc.specs.pluginManager.implem4j

import java.io.File
import libra.misc.pluginManager.PluginManager
import libra.misc.specs.pluginManager.PluginManagerSpecs
import org.apache.commons.io.FileUtils
import org.junit.Assert

class PluginManagerTests4Java extends PluginManagerSpecs {
	
	static val pm = PluginManager.INSTANCE
	static val bundleID = "libra.misc.specs"
	
	override spec_getBundleDir() {
		// Normal case
		var d = pm.getBundleDir(bundleID)
		Assert.assertTrue("Dir not found: "+d.absolutePath,d.directory)
		
		// Verify identifier in Manifest
		var m = new File (d, "META-INF/MANIFEST.MF")
		Assert.assertTrue("Manifest not found: "+m.absolutePath,d.isDirectory)
		Assert.assertTrue("Bundle ID not found in Manifest: "+m.absolutePath,
			FileUtils.readLines(m).stream.filter[equals("Bundle-SymbolicName: "+bundleID)].findAny.present)
		
		// Try with an unknown bundle
		try {
			pm.getBundleDir("foo.bar")
			Assert.fail("Get there while an exception was expected")
		} catch (UnsupportedOperationException e) {
			// OK, expected behavior
		}
		
		// Try with an empty string
		try {
			pm.getBundleDir("")
			Assert.fail("Get there while an exception was expected")
		} catch (UnsupportedOperationException e) {
			// OK, expected behavior
		}
		
		// Try with an ID with only one segment
		try {
			pm.getBundleDir("foo")
			Assert.fail("Get there while an exception was expected")
		} catch (UnsupportedOperationException e) {
			// OK, expected behavior
		}
	}
	
	override spec_getEclipseProjectName() {
		// Normal case
		var projName = pm.getEclipseProjectName(pm.getBundleDir(bundleID))
		Assert.assertEquals(bundleID, projName)
		
		// Try with a non-bundle directory
		try {
			pm.getEclipseProjectName(new File("/tmp"))
			Assert.fail("Get there while an exception was expected")
		} catch (UnsupportedOperationException e) {
			// OK, expected behavior
		}
	}
	
	override spec_getManifestSymbolicName() {
		// Normal case
		var manifestID = pm.getManifestSymbolicName(pm.getBundleDir(bundleID))
		Assert.assertEquals(bundleID, manifestID)
		
		// Try with a non-bundle directory
		try {
			pm.getManifestSymbolicName(new File("/tmp"))
			Assert.fail("Get there while an exception was expected")
		} catch (UnsupportedOperationException e) {
			// OK, expected behavior
		}
	}
	
	override spec_getManifestRequiredTools() {
		// Normal case
		var requiredTools = pm.getManifestRequiredTools(pm.getBundleDir("libra.misc.pluginManager.sh"))
		Assert.assertEquals(1,requiredTools.size)
		Assert.assertEquals("xmlstarlet",requiredTools.get(0))

		// Try with a non-bundle directory
		try {
			pm.getManifestRequiredTools(new File("/tmp"))
			Assert.fail("Get there while an exception was expected")
		} catch (UnsupportedOperationException e) {
			// OK, expected behavior
		}
		
		// Try with an empty dependency list
		requiredTools = pm.getManifestRequiredTools(pm.getBundleDir(bundleID))
		Assert.assertEquals(0,requiredTools.size)
	}
	
}