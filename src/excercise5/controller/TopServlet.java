package excercise5.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;

import excercise5.beans.UserComment;
import excercise5.beans.UserMessage;
import excercise5.service.CommentService;
import excercise5.service.MessageService;


@WebServlet(urlPatterns = { "/index.jsp" })
public class TopServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//セッションからログインユーザーを取得し、ログインユーザーのオブジェクトが取得できた場合に表示する。
	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletException {

		HttpSession session = request.getSession();
		List<String> errorMessages = new ArrayList<String>();
		String category = request.getParameter("category");
		request.setAttribute("selectedCategory", category);
		Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String strDate = sdf.format(cal.getTime());
        String oldestDate = new MessageService().getOldestDate();
        String end;
        String start;
        String startDate = null;
        String endDate = null;

        if (StringUtils.isEmpty(request.getParameter("start"))) {
			start = oldestDate;

		} else {
			start = request.getParameter("start") + " 00:00:00";
			startDate = request.getParameter("start");
			request.setAttribute("startDate", startDate);
		}
		if (StringUtils.isEmpty(request.getParameter("end"))) {
			end = strDate + " 23:59:59";
		} else {
			end = request.getParameter("end") + " 23:59:59";
			endDate = request.getParameter("end");
			request.setAttribute("endDate", endDate);
		}


		List<UserMessage> messages = new MessageService().getMessage(category, start, end);
		List<UserMessage> categories = new MessageService().getCategories();
		List<UserComment> comments = new CommentService().getComment();

		if (isValid(request, errorMessages, category, start, end) == true){
			request.setAttribute("messages", messages);

		} else {
			request.setAttribute("messages", messages);
			session.setAttribute("errorMessages", errorMessages);
			request.getRequestDispatcher("top.jsp").forward(request, response);
		}

		request.setAttribute("categories", categories);
		request.setAttribute("comments", comments);



		request.getRequestDispatcher("/top.jsp").forward(request, response);
	}

	private boolean isValid(HttpServletRequest request, List<String> errorMessages, String category, String start, String end) {

		List<UserMessage> messages = new MessageService().getMessage(category, start, end);

		if (messages.size() == 0){
			errorMessages.add("投稿が存在しません");
		}

		if (errorMessages.size() == 0) {
			return true;
		} else {
			return false;
		}
	}
}