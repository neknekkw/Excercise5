package excercise5.service;

import static excercise5.utils.CloseableUtil.*;
import static excercise5.utils.DBUtil.*;

import java.sql.Connection;
import java.util.List;

import com.sun.corba.se.impl.protocol.giopmsgheaders.Message;

import excercise5.beans.UserMessage;
import excercise5.dao.MessageDao;
import excercise5.dao.UserMessageDao;



public class MessageService {

	public void register(Message message) {

		Connection connection = null;
		try {
			connection = getConnection();

			MessageDao messageDao = new MessageDao();
			messageDao.insert(connection, message);

			commit(connection);
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
	private static final int LIMIT_NUM = 1000;

	public List<Message> getMessage() {

		Connection connection = null;
		try {
			connection = getConnection();

			MessageDao messageDao = new MessageDao();
			List<UserMessage> ret = UserMessageDao.getUserMessages(connection, LIMIT_NUM);

			commit(connection);

			return ret;
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
