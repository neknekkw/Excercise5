package excercise5.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

		String category = request.getParameter("category");
		Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String strDate = sdf.format(cal.getTime());
        String oldestDate = new MessageService().getOldestDate();
        String end;
        String start;
		if (StringUtils.isEmpty(request.getParameter("start"))) {
			start = oldestDate;
		} else {
			start = request.getParameter("start");
		}
		if (StringUtils.isEmpty(request.getParameter("end"))) {
			end = strDate;
		} else {
			end = request.getParameter("end");
		}
		System.out.println("a" + end);

		List<UserMessage> messages = new MessageService().getMessage(category, start, end);
		List<UserMessage> categories = new MessageService().getCategories();
		List<UserComment> comments = new CommentService().getComment();


		request.setAttribute("messages", messages);
		request.setAttribute("categories", categories);
		request.setAttribute("comments", comments);

		request.getRequestDispatcher("/top.jsp").forward(request, response);
	}
}