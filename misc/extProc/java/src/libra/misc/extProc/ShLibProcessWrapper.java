package libra.misc.extProc;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

public class ShLibProcessWrapper extends ExternalProcessWrapper {

	private static final String C = "-c";
	private static final String BASH = "bash";
	protected static final String SHELL_LIST_SEPARATOR = " ";

	public String execShLibFunction(File libFile, String functionName, String... args) {
		return execProcess(BASH, C, loadShLib(libFile) + functionName + " " + StringUtils.join(args, " "));
	}

	private String loadShLib(File libFile) {
		return "source " + libFile.getAbsolutePath() + "; ";
	}

	protected List<String> sanitizeList(List<String> out) {
		List<String> newList = out;
		// If just an empty first element, prefer an empty list
		if ((out.size() == 1) && StringUtils.isBlank(out.get(0))) {
			newList = new ArrayList<>();
		}
		return newList;
	}

}
