//投稿画面で投稿したものをDBに保存する
package excercise5.dao;

import static excercise5.utils.CloseableUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import excercise5.beans.Message;
import excercise5.exception.SQLRuntimeException;

public class MessageDao {

	public void insert(Connection connection, Message message) {

		PreparedStatement ps = null;
		try {
			StringBuilder sql = new StringBuilder();
			sql.append("INSERT INTO posts ( ");
			sql.append("id");
			sql.append(", user_id");
			sql.append(", subject");
			sql.append(", body");
			sql.append(", category");
			sql.append(", insert_date");
			sql.append(") VALUES (");
			sql.append("null"); // id
			sql.append(", ?"); // user_id
			sql.append(", ?"); //subject
			sql.append(", ?"); // body
			sql.append(", ?"); //category
			sql.append(", CURRENT_TIMESTAMP"); // insert_date
			sql.append(")");

			ps = connection.prepareStatement(sql.toString());

			ps.setInt(1, message.getUserId());
			ps.setString(2, message.getSubject());
			ps.setString(3, message.getBody());
			ps.setString(4, message.getCategory());
			System.out.println(ps.toString());
			ps.executeUpdate();
		} catch (SQLException e) {
			throw new SQLRuntimeException(e);
		} finally {
			close(ps);
		}
	}

}
