package libra.misc.specs.sanity

import libra.misc.specs.sanity.SanitySpecs
import libra.misc.pluginManager.PluginManager
import org.junit.Assert
import org.apache.commons.lang3.StringUtils

class SanityTests4Java extends SanitySpecs {

	static val pm = PluginManager.INSTANCE

	override spec_AllBundles() {
		var b = pm.getAllBundleDirs(pm.rootDir)
		Assert.assertEquals(12, b.size)
	}

	override spec_BundleProjectConsistency() {
		var b = pm.getAllBundleDirs(pm.rootDir)
		b.forEach[Assert.assertEquals(pm.getEclipseProjectName(it), pm.getManifestSymbolicName(it))]
	}

	override spec_BundleDirNameConsistency() {
		var b = pm.getAllBundleDirs(pm.rootDir)
		for (dir : b) {
			var bundleID = pm.getManifestSymbolicName(dir)
			var segments = newArrayList(bundleID.split("\\."))
			segments.remove(0)
			var expectedPath = pm.rootDir.absolutePath + "/" + StringUtils.join(segments, "/")
			Assert.assertEquals(expectedPath, dir.absolutePath)
		}
	}

	override spec_RequiredTools() {
		var b = pm.getAllBundleDirs(pm.rootDir)
		val tools = newHashSet
		b.stream.flatMap[pm.getManifestRequiredTools(it).stream].forEach[tools.add(it)]
		for (tool : tools) {
			try {
				pm.checkTool(tool)
			} catch (UnsupportedOperationException e) {
				Assert.fail("Required tool is not installed: " + tool)
			}
		}
	}

	override spec_Vendor() {
		var b = pm.getAllBundleDirs(pm.rootDir)
		b.forEach [
			Assert.assertEquals("Unexpected vendor for bundle " + it.absolutePath, "Libra", pm.getManifestVendor(it))
		]
	}
	
	override spec_Version() {
		var b = pm.getAllBundleDirs(pm.rootDir)
		b.forEach [
			Assert.assertEquals("Unexpected version for bundle " + it.absolutePath, "1.0.0.qualifier", pm.getManifestVersion(it))
		]
	}
	
	override spec_DirBundleShape() {
		var b = pm.getAllBundleDirs(pm.rootDir)
		for (dir : b) {
			val bID = pm.getManifestSymbolicName(dir)
			if (bID.endsWith(".sh")) {
				Assert.assertTrue("Unexpected bundle shape for " + bID, pm.isManifestDirShape(dir))
			}
		}
	}

	override spec_RequiredBundles_NoEclipse() {
		var b = pm.getAllBundleDirs(pm.rootDir)
		for (dir : b) {
			val bID = pm.getManifestSymbolicName(dir)
			if (!bID.endsWith(".specs") && !bID.contains(".osgi.")) {
				var bundles = pm.getManifestRequiredBundles(dir)
				var reqs = newArrayList("org.eclipse", "org.junit")
				for (req : reqs) {
					bundles.forEach [
						Assert.assertFalse("Unexpected bundle dependency for " + bID + ": " + it, it.startsWith(req))
					]
				}
			}
		}
	}

	override spec_RequiredBundles_sh() {
		var b = pm.getAllBundleDirs(pm.rootDir)
		for (dir : b) {
			val bID = pm.getManifestSymbolicName(dir)
			if (bID.endsWith(".sh")) {
				var bundles = pm.getManifestRequiredBundles(dir)
				bundles.forEach [
					Assert.assertTrue("Unexpected bundle dependency for " + bID + ": " + it, it.endsWith(".sh"))
				]
			}
		}
	}

}
