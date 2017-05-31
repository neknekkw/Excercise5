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
import excercise5.beans.UserBranch;
import excercise5.beans.UserDepartment;
import excercise5.service.BranchService;
import excercise5.service.DepartmentService;
import excercise5.service.UserService;

@WebServlet(urlPatterns = { "/settings" })
@MultipartConfig(maxFileSize = 100000)
public class SettingsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		List<String> messages = new ArrayList<String>();
		HttpSession session = request.getSession();

			if (isUrlValid(request, messages) == true) {
				int settingsId = Integer.parseInt(request.getParameter("id"));
				UserService userService = new UserService();
				User user = userService.getSettingsUser(settingsId);
				request.setAttribute("settingsUser", user);
				List<UserBranch> branchName = new BranchService().getBranchName();
				session.setAttribute("branchNames", branchName);

				List<UserDepartment> departmentName = new DepartmentService().getDepartmentName();
				session.setAttribute("departmentNames", departmentName);

				request.getRequestDispatcher("settings.jsp").forward(request, response);
		} else {
			session.setAttribute("errorMessages", messages);
			response.sendRedirect("userManagement");
		}
	}

		@Override
		protected void doPost(HttpServletRequest request,
				HttpServletResponse response) throws IOException, ServletException {

			List<String> messages = new ArrayList<String>();

			//セッションを取得する、セッションを開始する
			HttpSession session = request.getSession();


			User user = new User();



			user.setId(Integer.parseInt(request.getParameter("settingsId")));
			user.setLoginId(request.getParameter("loginId"));
			user.setName(request.getParameter("name"));
			user.setBranchId(request.getParameter("branchId"));
			user.setDepartmentId(request.getParameter("departmentId"));
			user.setPassword(request.getParameter("password"));

			if (isValid(request, messages) == true) {
					new UserService().settingsUpdate(user);
					session.removeAttribute("departmentNames");
					session.removeAttribute("branchNames");
				response.sendRedirect("userManagement");
			} else {
				request.setAttribute("settingsUser", user);
				session.setAttribute("errorMessages", messages);
				request.getRequestDispatcher("settings.jsp").forward(request,response);
			}
		}

	private boolean isValid(HttpServletRequest request, List<String> messages) {
		String loginId = request.getParameter("loginId");
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String checkPassword = request.getParameter("checkPassword");
		int branchId = Integer.parseInt(request.getParameter("branchId"));
		int departmentId = Integer.parseInt(request.getParameter("departmentId"));
		int settingsId = Integer.parseInt(request.getParameter("settingsId"));


		if (StringUtils.isEmpty(loginId) == true) {
			messages.add("ログインIDを入力してください");
		}
		if (!loginId.matches("^[0-9a-zA-Z]+$") || loginId.length() < 6 || loginId.length() > 20) {
			messages.add("ログインIDは半角英数字6文字以上20文字以下で入力してください");
		}

			User settingsUser = new UserService().getCheckUser(loginId);
			int setId = settingsUser.getId();
			if(settingsId != setId){
				if (settingsUser != null) {
					messages.add("ログインIDが重複しています。他のユーザーIDを入力してください");
				}
			}
		if (StringUtils.isEmpty((request.getParameter("password"))) != true) {
			if (!password.matches("^[-_@+*;:#$%&A-Za-z0-9]+$") || password.length() < 6 || password.length() > 255) {
				messages.add("パスワードは記号を含む全ての半角英数字6文字以上255文字以下で入力してください");
			}
			if (!password.equals(checkPassword)) {
				messages.add("パスワードが一致しません");
			}
		}
		if (StringUtils.isEmpty(name) == true) {
			messages.add("名前を入力してください");
		}
		if (name.length() > 10) {
			messages.add("名前は10文字以下で入力してください");
		}
		if (branchId == 1 && departmentId >= 3 && departmentId <= 4) {
			messages.add("支店長・支店社員を本社所属にはできません");
		}
		if (branchId >= 2 && departmentId <= 2) {
			messages.add("本社社員を支店所属にはできません");
		}

		if (messages.size() == 0) {
			return true;
		} else {
			return false;
		}
	}

	private boolean isUrlValid(HttpServletRequest request, List<String> messages) {

		if(StringUtils.isEmpty(request.getParameter("id")) || !(request.getParameter("id")).matches("^\\d{0,9}+$")) {
			messages.add("編集対象のIDが不正です");
			return false;
		}
		int id = Integer.parseInt(request.getParameter("id"));
		User settingsUser = new UserService().getUser(id);

		if(settingsUser == null){
			messages.add("編集対象者のIDが不正です");
			return false;
		}
		return true;
	}
}