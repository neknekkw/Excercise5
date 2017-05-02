package excercise5.service;

import static excercise5.utils.CloseableUtil.*;
import static excercise5.utils.DBUtil.*;

import java.sql.Connection;

import excercise5.beans.User;
import excercise5.dao.UserDao;
import excercise5.utils.CipherUtil;

public class LoginService {

	public User login(String loginId, String password) {

		Connection connection = null;
		try {
			connection = getConnection();

			UserDao userDao = new UserDao();
			String encPassword = CipherUtil.encrypt(password);
			User user = userDao
					.getUser(connection, loginId, encPassword);

			commit(connection);

			return user;
		} catch (RuntimeException e) {
			rollback(connection);
			throw e;
		} catch (Error e) {
			rollback(connection);
			throw e;
		} finally {
			close(connection);
		}
	}

}
