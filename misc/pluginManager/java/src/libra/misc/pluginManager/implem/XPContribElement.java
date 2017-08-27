package libra.misc.pluginManager.implem;

import java.io.File;

import org.w3c.dom.Node;

import libra.misc.pluginManager.XPReader.XPContrib;

public class XPContribElement implements XPContrib {

	private File pXml;

	private Node contribNode;

	public XPContribElement(File pXml, Node contribNode) {
		this.pXml = pXml;
		this.contribNode = contribNode;
	}

	public File getpXml() {
		return pXml;
	}

	public Node getContribNode() {
		return contribNode;
	}

}
