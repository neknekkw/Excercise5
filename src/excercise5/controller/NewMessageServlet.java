package excercise5.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;

import excercise5.beans.Message;
import excercise5.beans.User;
import excercise5.service.MessageService;

@WebServlet(urlPatterns = { "/newMessage" })
public class NewMessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		request.getRequestDispatcher("/newMessage.jsp").forward(request, response);
	}



	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {

		HttpSession session = request.getSession();

		List<String> messages = new ArrayList<String>();

		if (isValid(request, messages) == true) {

			User user = (User) session.getAttribute("loginUser");
			Message message = new Message();
			message.setSubject(request.getParameter("subject"));
			message.setBody(request.getParameter("message"));
			message.setCategory(request.getParameter("category"));
			message.setUserId(user.getId());
			new MessageService().register(message);
			response.sendRedirect("./");
		} else {
			session.setAttribute("errorMessages", messages);
			response.sendRedirect("newMessage");
		}
	}

	private boolean isValid(HttpServletRequest request, List<String> messages) {

		String body = request.getParameter("message");
		String category = request.getParameter("category");
		String subject = request.getParameter("subject");

		if (StringUtils.isBlank(body)) {
			messages.add("本文を入力してください");
		}
		if (StringUtils.isBlank(category)) {
			messages.add("カテゴリーを入力してください");
		}
		if (StringUtils.isBlank(subject)) {
			messages.add("件名を入力してください");
		}
		if (1000 <= body.length()) {
			messages.add("本文は1000文字以下で入力してください");
		}
		if (10 <= category.length()) {
			messages.add("カテゴリーは10文字以下で入力してください");
		}
		if (50 <= subject.length()) {
			messages.add("件名は1000文字以下で入力してください");
		}
		if (messages.size() == 0) {
			return true;
		} else {
			return false;
		}
	}

}