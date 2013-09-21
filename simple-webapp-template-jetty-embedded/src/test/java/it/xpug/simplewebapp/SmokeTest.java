
package it.xpug.simplewebapp;

import static org.junit.Assert.*;

import java.io.*;
import java.net.*;

import it.xpug.simplewebapp.jetty.*;
import it.xpug.simplewebapp.main.*;

import org.junit.*;

public class SmokeTest {

	private static final int PORT = 8123;
	private static ReusableJettyApp app;

	@Test
	public void helloWorldServletIsInvoked() throws Exception {
		assertEquals("<h1>Hello, <em>World!</em></h1>", get("/pippo"));
	}

	@Test
	public void staticResourcesAreReturned() throws Exception {
		assertEquals("GIF89", get("/images/spinner.gif", 5));
	}

	@BeforeClass
	public static void setUp() throws Exception {
		app = new ReusableJettyApp(SimpleWebappServlet.class);		
		app.start(PORT, "src/main/webapp");
	}

	@AfterClass
	public static void tearDown() throws Exception {
		app.shutdown();
	}

	private String get(String url, int length) throws IOException {
		InputStream stream = openUrl(url);
		byte [] buffer = new byte[length];
		stream.read(buffer);
		return new String(buffer);
	}

	private String get(String path) throws IOException {
		InputStream stream = openUrl(path);
		BufferedReader reader = new BufferedReader(new InputStreamReader(stream));
		return reader.readLine();
	}

	private InputStream openUrl(String path) throws IOException {
		return new URL("http://localhost:" + PORT + path).openStream();
	}
}
