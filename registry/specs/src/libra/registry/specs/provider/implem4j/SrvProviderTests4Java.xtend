package libra.registry.specs.provider.implem4j

import libra.itf.SimpleSample
import libra.registry.provider.IRegistryProvider
import libra.registry.specs.provider.SrvProviderSpecs
import org.junit.Assert

class SrvProviderTests4Java extends SrvProviderSpecs {
	
	static val rp = IRegistryProvider.INSTANCE
	public static val mainSrvID = "mainSimpleService"
	public static val otherSrvID = "otherSimpleService"
	public static val contribSrvID = "contribSimpleSample"
	static val expectedHello = "Hello World"
	
	override s010_registration() {
		// Register if needed
		if (!rp.getService(typeof(SimpleSample), mainSrvID).isPresent) {
			rp.registerService(typeof(SimpleSample), mainSrvID, new SimpleService)
		}

		// Check registration is OK
		var srvOpt = rp.getService(typeof(SimpleSample), mainSrvID)
		Assert.assertTrue(srvOpt.present)
		Assert.assertEquals(expectedHello,srvOpt.get.printHello)
		srvOpt.get.doSomething
	}
	
	override s011_registration_ID() {
		// Correct generation has been done above
		// Give a try with an invalid service identifier
		try {
			rp.registerService(typeof(SimpleSample), "a.b.c#", new SimpleService)
			Assert.fail("An exception was expected")
		} catch (IllegalArgumentException e) {
			// OK!
		}
	}
	
	override s012_registration_interface() {
		// Correct generation has been done above
		// Give a try with an invalid token
		try {
			rp.registerService(typeof(DummyInterface), mainSrvID, new DummyInterface{})
			Assert.fail("An exception was expected")
		} catch (IllegalArgumentException e) {
			// OK!
		}
	}
	
	override s013_registration_entry() {
		// Correct generation has been done above
		// Give a try with an invalid implementation
		try {
			rp.registerService(typeof(SimpleSample), mainSrvID, null)
			Assert.fail("An exception was expected")
		} catch (IllegalArgumentException e) {
			// OK!
		}
	}
	
	override s014_registration_once() {
		// Register one time
		rp.registerService(typeof(SimpleSample), otherSrvID, new SimpleService)
		
		// Register a second time
		try {
			rp.registerService(typeof(SimpleSample), otherSrvID, new SimpleService)
			Assert.fail("An exception was expected")
		} catch (IllegalStateException e) {
			// OK!
		}
	}
	
	override s015_registration_contrib() {
		// Check registration is OK
		var srvOpt = rp.getService(typeof(SimpleSample), contribSrvID)
		Assert.assertTrue(srvOpt.present)
		Assert.assertEquals(expectedHello,srvOpt.get.printHello)
		srvOpt.get.doSomething
	}
}