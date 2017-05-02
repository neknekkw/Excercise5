package excercise5.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import excercise5.beans.User;
import excercise5.service.UserService;

@WebServlet(urlPatterns = { "/userManagement" })
public class UserManagement extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		//getUser()でユーザー情報取ってきてリストに入れる
		List<User> users = new UserService().getUser();
		request.setAttribute("users", users);
		request.getRequestDispatcher("/userManagement.jsp").forward(request, response);
	}
	protected void doPost (HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {
		
		String isStopped = request.getParameter("isStopped");
		String id = request.getParameter("id");
			new UserService().updates(isStopped, id);
		
		response.sendRedirect("userManagement");
	}
}

