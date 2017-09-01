package libra.misc.specs.pluginManager.implem4j

import libra.misc.pluginManager.XPReader
import libra.misc.specs.pluginManager.XPReaderSpecs
import org.junit.Assert

class XPReaderTests4Java extends XPReaderSpecs {
	
	static val xr = XPReader.INSTANCE
	static val XPID = "libra.misc.specs.foo"
	static val ELID = "testElement"
	static val ATID = "attr1"
	
	override spec_getContributions() {
		// Verify contribs to test extension point
		var contribs = xr.getContributions(XPID)
		Assert.assertEquals(1, contribs.size)
		
		// Verify contribs to unknown extension point (or no contribs to known entry point...)
		contribs = xr.getContributions("libra.misc.specs.unknown")
		Assert.assertEquals(0, contribs.size)
	}
	
	override spec_getElements() {
		// Get contrib
		var contrib = xr.getContributions(XPID).get(0)
		
		// Get elements
		var elements = xr.getElements(contrib, ELID)
		Assert.assertEquals(2, elements.size)
		
		// Get unknown elements
		elements = xr.getElements(contrib, "unknownElement")
		Assert.assertEquals(0, elements.size)
	}
	
	override spec_getStringAttribute() {
		// Get elements
		var elements = xr.getElements(xr.getContributions(XPID).get(0), ELID)
		
		// Get attributes
		var attr = xr.getStringAttribute(elements.get(0), ATID)
		Assert.assertTrue(attr.present)
		Assert.assertEquals("testValue1", attr.get)
		attr = xr.getStringAttribute(elements.get(1), ATID)
		Assert.assertTrue(attr.present)
		Assert.assertEquals("testValue2", attr.get)
		
		// Check unknown attribute
		attr = xr.getStringAttribute(elements.get(0), "unknownAttr")
		Assert.assertFalse(attr.present)
	}
	
}