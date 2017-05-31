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

import excercise5.beans.User;
import excercise5.beans.UserBranch;
import excercise5.beans.UserDepartment;
import excercise5.service.BranchService;
import excercise5.service.DepartmentService;
import excercise5.service.UserService;

@WebServlet(urlPatterns = { "/userRegistration" })
public class userRegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {

		HttpSession session = request.getSession();
		List<UserBranch> branchName = new BranchService().getBranchName();
		session.setAttribute("branchNames", branchName);

		List<UserDepartment> departmentName = new DepartmentService().getDepartmentName();
		session.setAttribute("departmentNames", departmentName);

		request.getRequestDispatcher("userRegistration.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {

		List<String> messages = new ArrayList<String>();

		//セッションを取得する、セッションを開始する
		HttpSession session = request.getSession();

		User user = new User();
		user.setLoginId(request.getParameter("loginId"));
		user.setPassword(request.getParameter("password"));
		user.setName(request.getParameter("name"));
		user.setBranchId(request.getParameter("branchId"));
		user.setDepartmentId(request.getParameter("departmentId"));

		//isValidメソッドの引数がtrueかどうか
		if (isValid(request, messages) == true) {

			//User型のuserの箱の中にそれぞれの値を格納していく。

			new UserService().register(user);

			session.removeAttribute("departmentNames");
			session.removeAttribute("branchNames");
			response.sendRedirect("userManagement");
		} else {


			request.setAttribute("user", user);
			session.setAttribute("errorMessages", messages);
			request.getRequestDispatcher("/userRegistration.jsp").forward(request,response);
		}
	}

	private boolean isValid(HttpServletRequest request, List<String> messages) {
		String loginId = request.getParameter("loginId");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String checkPassword = request.getParameter("checkPassword");
		int branchId = Integer.parseInt(request.getParameter("branchId"));
		int departmentId = Integer.parseInt(request.getParameter("departmentId"));

		if (StringUtils.isEmpty(loginId) == true) {
			messages.add("ログインIDを入力してください");
		}
		if (!loginId.matches("^[0-9a-zA-Z]+$") || loginId.length() < 6 || loginId.length() > 20) {
			messages.add("ログインIDは半角英数字6文字以上20文字以下で入力してください");
		}
		User settingsUser = new UserService().getCheckUser(loginId);

		if (settingsUser != null) {
			messages.add("ログインIDが重複しています。他のユーザーIDを入力してください");
		}

		if (!password.matches("^[-_@+*;:#$%&A-Za-z0-9]+$") || password.length() < 6 || password.length() > 255) {
			messages.add("パスワードは記号を含む全ての半角英数字6文字以上255文字以下で入力してください");
		}
		if (StringUtils.isEmpty(password) == true) {
			messages.add("パスワードを入力してください");
		}
		if (!password.equals(checkPassword)) {
			messages.add("パスワードが一致しません");
		}
		if (name.length() > 10) {
			messages.add("名前は10文字以下で入力してください");
		}
		if (StringUtils.isEmpty(name) == true) {
			messages.add("名前を入力してください");
		}
		if (branchId == 1 && departmentId >= 3 && departmentId <= 4) {
			messages.add("支店長・支店社員を本社所属にはできません");
		}

		if (branchId >= 2 && departmentId <= 2) {
			messages.add("本社社員を支店所属にはできません");
		}
		// TODO アカウントが既に利用されていないか、メールアドレスが既に登録されていないかなどの確認も必要
		if (messages.size() == 0) {
			return true;
		} else {
			return false;
		}
	}

}