package libra.misc.pluginManager.implem;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import libra.misc.pluginManager.PluginManager;
import libra.misc.pluginManager.XPReader;

public class XPReaderImplem implements XPReader {

	@Override
	public List<XPContrib> getContributions(String xpID) {
		// Get all installed bundles
		PluginManager pm = PluginManager.INSTANCE;
		List<File> bundles = pm.getAllBundleDirs(pm.getRootDir());

		// Look for contributions
		// @formatter:off
		return bundles.stream()
			.map(f -> new File(f, "plugin.xml"))
			.filter(File::isFile)
			.flatMap(f -> lookForContrib(f, xpID).stream())
			.filter(c -> c != null)
			.collect(Collectors.toList());
		// @formatter:on
	}

	private List<XPContrib> lookForContrib(File pXml, String xpID) {
		try (FileInputStream fis = new FileInputStream(pXml)) {
			// @formatter:off
			return getNodes(getNodesFromPath(fis, "//plugin/extension"))
				.filter(n -> getAttribute(n, "point").get().equals(xpID))
				.map(n -> new XPContribElement(pXml, n))
				.collect(Collectors.toList());
			// @formatter:on
		} catch (IOException | XPathExpressionException e) {
			throw new UnsupportedOperationException(e);
		}
	}

	private NodeList getNodesFromPath(InputStream input, String path) throws XPathExpressionException {
		InputSource artifactsSource = new InputSource(input);
		return (NodeList) XPathFactory.newInstance().newXPath().compile(path).evaluate(artifactsSource, XPathConstants.NODESET);
	}

	private Stream<Node> getNodes(NodeList propNodes) {
		// @formatter:off
		return IntStream.range(0, propNodes.getLength())
			.boxed()
			.map(i -> propNodes.item(i));
		// @formatter:on
	}

	private Stream<Node> getNodesByName(NodeList propNodes, String name) {
		return getNodes(propNodes).filter(n -> n.getNodeName().equals(name));
	}

	private Optional<String> getAttribute(Node n, String name) {
		return Optional.ofNullable(n.getAttributes().getNamedItem(name)).map(nd -> nd.getNodeValue());
	}

	@Override
	public List<XPContrib> getElements(XPContrib contrib, String name) {
		XPContribElement root = (XPContribElement) contrib;
		return getNodesByName(root.getContribNode().getChildNodes(), name).map(n -> new XPContribElement(root.getpXml(), n)).collect(Collectors.toList());
	}

	@Override
	public Optional<String> getStringAttribute(XPContrib contrib, String name) {
		XPContribElement root = (XPContribElement) contrib;
		return getAttribute(root.getContribNode(), name);
	}

}
