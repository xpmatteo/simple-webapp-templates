package it.xpug.simplewebapp.main;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

public class SimpleWebappServlet extends HttpServlet {	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter writer = response.getWriter();
		writer.write("<h1>Hello, <em>World!</em></h1>");
		writer.close();
	}
}
