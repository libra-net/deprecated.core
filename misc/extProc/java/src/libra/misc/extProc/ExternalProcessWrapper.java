package libra.misc.extProc;

import java.io.IOException;
import java.util.List;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;

public class ExternalProcessWrapper {

	protected String execProcess(String... command) {

		// Build and launch process
		String cmd = StringUtils.join(command, " ");
		ProcessBuilder pb = new ProcessBuilder(command);
		Process p;
		int rc;
		try {
			p = pb.start();
			rc = p.waitFor();
		} catch (IOException | InterruptedException e) {
			throw new UnsupportedOperationException("Error while running underlying process (" + cmd + "): " + e.getMessage(), e);
		}

		List<String> stdout, stderr;
		try {
			stdout = IOUtils.readLines(p.getInputStream());
			stderr = IOUtils.readLines(p.getErrorStream());
		} catch (IOException e) {
			throw new UnsupportedOperationException("Error while reading underlying process output (" + cmd + "): " + e.getMessage(), e);
		}

		System.err.println("stdout:\n" + StringUtils.join(stdout, "\n"));
		System.err.println("stderr:\n" + StringUtils.join(stderr, "\n"));

		// Check return code
		if (rc != 0) {
			throw new UnsupportedOperationException("Unexpected RC while running underlying process (" + cmd + "): " + rc);
		}

		// Get output string
		String out = "";
		if (stdout.size() > 0) {
			out = stdout.get(0);
		}
		return out;
	}

}
