package libra.misc.pluginManager.implem;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

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
		List<XPContrib> out = new ArrayList<>();

		try (FileInputStream fis = new FileInputStream(pXml)) {
			Document doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(fis);
			NodeList children = doc.getChildNodes().item(0).getChildNodes();
			for (int i = 0; i < children.getLength(); i++) {
				Node n = children.item(i);
				if ("extension".equals(n.getNodeName())) {
					Node pointName = n.getAttributes().getNamedItem("point");
					if ((pointName != null) && pointName.getNodeValue().equals(xpID)) {
						// Match
						out.add(new XPContribElement(pXml, n));
					}
				}
			}
		} catch (IOException | SAXException | ParserConfigurationException e) {
			throw new UnsupportedOperationException(e);
		}

		return out;
	}

	@Override
	public String getStringAttribute(XPContrib contrib, String path) {
		// TODO Auto-generated method stub
		return null;
	}

}
