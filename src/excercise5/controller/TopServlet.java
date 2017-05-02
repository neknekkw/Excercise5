package excercise5.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.corba.se.impl.protocol.giopmsgheaders.Message;

import excercise5.service.MessageService;


@WebServlet(urlPatterns = { "/index.jsp" })
public class TopServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//セッションからログインユーザーを取得し、ログインユーザーのオブジェクトが取得できた場合に表示する。
	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {

		List<Message> messages = new MessageService().getMessage();

		request.setAttribute("messages", messages);


		request.getRequestDispatcher("/top.jsp").forward(request, response);
	}

}