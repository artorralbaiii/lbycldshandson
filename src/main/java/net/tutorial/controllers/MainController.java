package net.tutorial.controllers;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import net.tutorial.utilities.SpeechToTextService;
import net.tutorial.utilities.TranslatorService;
import okhttp3.Request;

@WebServlet({ "/home", "" })
@MultipartConfig
public class MainController extends HttpServlet {

	RequestDispatcher dispatcher;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/home.jsp");
		dispatcher.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		if(req.getParameter("mode").equals("translate")){
			String text = req.getParameter("tr-from");
			String modelId = req.getParameter("tr-model-id");
			
			TranslatorService lt = new TranslatorService();
			req.setAttribute("translation", lt.getTranslation(text,modelId));
			req.setAttribute("text", text);
			req.setAttribute("modelId", modelId);
			dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/home.jsp?mode=translate#step3");
		}

		else if (req.getParameter("mode").equals("speechtotext")){
			final Part filePart = req.getPart("file");
			String filePath = saveFile(filePart);
			
			SpeechToTextService s2t = new SpeechToTextService();
			String uri = req.getRequestURL()+"?"+req.getQueryString();
			System.out.println(uri);
			req.setAttribute("transcription", s2t.getTranscription(new File(filePath)));
			dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/views/home.jsp?mode=speechtotext#step1");
			resp.getWriter().append("Served at: ").append(req.getContextPath());
		}
			
			dispatcher.forward(req, resp);
	}

	// File Management	
	
	private String saveFile(Part filePart) throws IOException {
		final String fileName = getFileName(filePart);
		OutputStream out = null;
		InputStream filecontent = null;
		String filePath = setDir("fileResource") + File.separator + fileName;

		try {

			out = new FileOutputStream(new File(filePath));

			filecontent = filePart.getInputStream();
			int read = 0;
			final byte[] bytes = new byte[1024];

			while ((read = filecontent.read(bytes)) != -1) {
				out.write(bytes, 0, read);
			}
			
			return filePath;
			
		} catch (FileNotFoundException fne) {
			fne.printStackTrace();
			return "";
		} finally {
			if (out != null) {
				out.close();
			}
			if (filecontent != null) {
				filecontent.close();
			}
		}

	}

	private String getFileName(final Part part) {
		for (String content : part.getHeader("content-disposition").split(";")) {
			if (content.trim().startsWith("filename")) {
				return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
			}
		}
		return null;
	}

	private String setDir(String name) {
		File dir = new File(name);
		if (!dir.exists()) {
			try {
				dir.mkdir();
			} catch (SecurityException se) {
				se.printStackTrace();
			}
		}
		return name;
	}

}
