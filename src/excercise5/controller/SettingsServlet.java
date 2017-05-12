package excercise5.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;

import excercise5.beans.User;
import excercise5.service.UserService;

@WebServlet(urlPatterns = { "/settings" })
@MultipartConfig(maxFileSize = 100000)
public class SettingsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		int settingsId = Integer.parseInt(request.getParameter("settings"));
		UserService userService = new UserService();
		User user = userService.getSettingsUser(settingsId);
		request.setAttribute("settingsUser", user);

		request.getRequestDispatcher("settings.jsp").forward(request, response);
	}

		@Override
		protected void doPost(HttpServletRequest request,
				HttpServletResponse response) throws IOException, ServletException {

			List<String> messages = new ArrayList<String>();

			//セッションを取得する、セッションを開始する
			HttpSession session = request.getSession();

			//isValidメソッドの引数がtrueかどうか
			if (isValid(request, messages) == true) {

				//User型のuserの箱の中にそれぞれの値を格納していく。

				User user = new User();
				user.setId(Integer.parseInt(request.getParameter("settingsId")));
				user.setLoginId(request.getParameter("loginId"));
				user.setName(request.getParameter("name"));
				user.setBranchId(request.getParameter("branchId"));
				user.setDepartmentId(request.getParameter("departmentId"));
				user.setPassword(request.getParameter("password"));
					new UserService().settingsUpdate(user);


				response.sendRedirect("userManagement");

			} else {
				session.setAttribute("errorMessages", messages);
				request.getRequestDispatcher("settings.jsp").forward(request,response);
			}
		}

	private boolean isValid(HttpServletRequest request, List<String> messages) {

		String loginId = request.getParameter("loginId");
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String checkPassword = request.getParameter("checkPassword");


		if (StringUtils.isEmpty(loginId) == true) {
			messages.add("ログインIDを入力してください");
		}
		if (StringUtils.isEmpty(name) == true) {
			messages.add("名前を入力してください");
		}
		if (name.length() >= 10) {
			messages.add("名前は10文字以下で入力してください");
		}
		if (!loginId.matches("^[0-9a-zA-Z]+$") || loginId.length() <= 6 || loginId.length() >= 20) {
			messages.add("ログインIDは半角英数字6文字以上20文字以内で入力してください");
		}
		if (StringUtils.isEmpty((request.getParameter("password"))) != true) {
			if (!password.matches("^[-_@+*;:#$%&A-Za-z0-9]+$") || password.length() <= 6 || password.length() >= 255) {
				messages.add("パスワードは記号を含む全ての半角文字6文字から255文字以下で入力してください");
			}
			if (!password.equals(checkPassword)) {
				messages.add("パスワードが一致しません");
			}
		}

		if (messages.size() == 0) {
			return true;
		} else {
			return false;
		}
	}

}