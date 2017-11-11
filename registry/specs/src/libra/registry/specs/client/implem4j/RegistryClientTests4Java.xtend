package libra.registry.specs.client.implem4j

import libra.itf.SimpleSample
import libra.registry.client.IRegistryClient
import libra.registry.provider.IRegistryProvider
import libra.registry.specs.client.RegistryClientSpecs
import libra.registry.specs.provider.implem4j.SimpleService
import libra.registry.specs.provider.implem4j.SrvProviderTests4Java
import org.junit.Assert
import org.junit.Assume

class RegistryClientTests4Java extends RegistryClientSpecs {
	
	static val rc = IRegistryClient.INSTANCE
	static val rp = IRegistryProvider.INSTANCE
	
	override s010_access() {
		var srv = rc.getService(typeof(SimpleSample), SrvProviderTests4Java.contribSrvID)
		Assert.assertTrue(srv instanceof SimpleService)
	}
	
	override s011_access_path() {
		Assume.assumeTrue("TODO: auto-generated method stub", false)
	}
	
	override s012_access_unknown() {
		try {
			rc.getService(typeof(SimpleSample), "foo")
			Assert.fail("Was expecting to fail...")
		} catch (IllegalStateException a) {
			// We're good!
		}
	}
	
	override s020_direct_dynamic() {
		// Register if needed
		if (!rp.getService(typeof(SimpleSample), SrvProviderTests4Java.mainSrvID).isPresent) {
			rp.registerService(typeof(SimpleSample), SrvProviderTests4Java.mainSrvID, new SimpleService)
		}

		var srv = rc.getService(typeof(SimpleSample), SrvProviderTests4Java.mainSrvID)
		Assert.assertTrue(srv instanceof SimpleService)
	}
	
	override s021_direct_contrib() {
		var srv = rc.getService(typeof(SimpleSample), SrvProviderTests4Java.contribSrvID)
		Assert.assertTrue(srv instanceof SimpleService)
	}
	
}