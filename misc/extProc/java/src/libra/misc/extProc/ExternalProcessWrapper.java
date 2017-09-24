package libra.misc.extProc;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;

public class ExternalProcessWrapper {

	protected String execProcess(int expectedRc, File executable, String... args) {
		return execProcess(expectedRc,
				Stream.concat(Stream.of(executable.getAbsolutePath()), Arrays.asList(args).stream()).collect(Collectors.toList()).toArray(new String[0]));
	}

	protected String execProcess(String... command) {
		return execProcess(0, command);
	}

	protected String execProcess(int expectedRc, String... command) {

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

		System.err.println("[" + cmd + "] rc: " + rc);
		if (!stdout.isEmpty()) {
			System.err.println("[" + cmd + "] stdout:\n" + StringUtils.join(stdout, "\n"));
		}
		if (!stderr.isEmpty()) {
			System.err.println("[" + cmd + "] stderr:\n" + StringUtils.join(stderr, "\n"));
		}

		// Check return code
		if ((expectedRc >= 0) && (rc != expectedRc)) {
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
