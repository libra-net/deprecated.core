package libra.misc.specs.sanity

import org.junit.Test

/**
 * These sanity specifications help to ensure that the project source code respects the defined rules.
 */
abstract class SanitySpecs {
	
	/**
	 * Before all, this test verifies the bundles count (to check we're indeed verifying all the known bundles)
	 */
	@Test
	def abstract void spec_AllBundles();

	/**
	 * For all bundles, the bundle ID (symbolic name) must be the same than the Eclipse project name
	 */
	@Test
	def abstract void spec_BundleProjectConsistency();

	/**
	 * For all bundles, the bundle ID (except the first segment) must match with the bundle directory (WRT the program root dir)
	 */
	@Test
	def abstract void spec_BundleDirNameConsistency();

	/**
	 * For all bundles, required tools shall be installed on the development/build/test system
	 */
	@Test
	def abstract void spec_RequiredTools();

	/**
	 * For all bundles, vendor must be set to "Libra"
	 */
	@Test
	def abstract void spec_Vendor();

	/**
	 * For all bundles, versions must be consistent
	 */
	@Test
	def abstract void spec_Version();

	/**
	 * For sh bundles, Eclipse dir shape must be used
	 */
	@Test
	def abstract void spec_DirBundleShape();

	/**
	 * For non-test bundles, required bundles shall not include:
	 * - Eclipse bundles
	 * - JUnit bundles
	 */
	@Test
	def abstract void spec_RequiredBundles_NoEclipse();

	/**
	 * For sh bundles, required bundles shall not include non-sh bundles
	 */
	@Test
	def abstract void spec_RequiredBundles_sh();

}