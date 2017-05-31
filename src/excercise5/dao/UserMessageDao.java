//表結合したテーブルからユーザーとメッセージが結びついてる投稿データを取り出す
package excercise5.dao;

import static excercise5.utils.CloseableUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import excercise5.beans.UserMessage;
import excercise5.exception.SQLRuntimeException;

public class UserMessageDao {

	public List<UserMessage> getUserMessages(Connection connection, int num, String category, String start, String end) {

		PreparedStatement ps = null;
		try {
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT * FROM users_posts ");
			sql.append("WHERE ? <= insert_date ");
			sql.append("AND ? >= insert_date ");

				if (StringUtils.isEmpty(category)) {
					sql.append("ORDER BY insert_date DESC limit " + num);
				} else {
					sql.append("AND ");
					sql.append("category = ? ");
					sql.append("ORDER BY insert_date DESC limit " + num);
				}

			ps = connection.prepareStatement(sql.toString());
			ps.setString(1, start);
			ps.setString(2, end);
				if (StringUtils.isEmpty(category)) {
				} else {
					ps.setString(3, category);
				}
			ResultSet rs = ps.executeQuery();
			List<UserMessage> ret = toUserMessageList(rs);
			return ret;
		} catch (SQLException e) {
			throw new SQLRuntimeException(e);
		} finally {
			close(ps);
		}
	}

	private List<UserMessage> toUserMessageList(ResultSet rs)
			throws SQLException {

		List<UserMessage> ret = new ArrayList<UserMessage>();
		try {
			while (rs.next()) {
				String name = rs.getString("name");
				int id = rs.getInt("id");
				int userId = rs.getInt("user_id");
				int branchId = rs.getInt("branch_id");
				int departmentId = rs.getInt("department_id");
				String subject = rs.getString("subject");
				String body = rs.getString("body");
				String category = rs.getString("category");
				Timestamp insertDate = rs.getTimestamp("insert_date");

				UserMessage message = new UserMessage();
				message.setName(name);
				message.setId(id);
				message.setUserId(userId);
				message.setBranchId(branchId);
				message.setDepartmentId(departmentId);
				message.setSubject(subject);
				message.setBody(body);
				message.setCategory(category);
				message.setInsertDate(insertDate);

				ret.add(message);
			}
			return ret;
		} finally {
			close(rs);
		}
	}
	public List<UserMessage> getCategories(Connection connection) {

		PreparedStatement ps = null;
		try {
			StringBuilder sql = new StringBuilder();
				sql.append("SELECT category FROM users_posts ");
				sql.append("GROUP BY category");
			ps = connection.prepareStatement(sql.toString());

			ResultSet rs = ps.executeQuery();
			List<UserMessage> ret = toCategoryList(rs);
			return ret;
		} catch (SQLException e) {
			throw new SQLRuntimeException(e);
		} finally {
			close(ps);
		}
	}
	private List<UserMessage> toCategoryList(ResultSet rs)
			throws SQLException {

		List<UserMessage> ret = new ArrayList<UserMessage>();
		try {
			while (rs.next()) {
				String categories = rs.getString("category");

				UserMessage category = new UserMessage();

				category.setCategory(categories);


				ret.add(category);
			}
			return ret;
		} finally {
			close(rs);
		}
	}
	public String getOldestDate(Connection connection) {

		PreparedStatement ps = null;
		try {
			StringBuilder sql = new StringBuilder();
				sql.append("SELECT MIN(insert_date) FROM users_posts HAVING MIN(insert_date)");
			ps = connection.prepareStatement(sql.toString());

			ResultSet rs = ps.executeQuery();
			String ret = toGetOldestDate(rs);
			return ret;
		} catch (SQLException e) {
			throw new SQLRuntimeException(e);
		} finally {
			close(ps);
		}
	}
	private String toGetOldestDate(ResultSet rs)
			throws SQLException {

		try {
			String getOldestDate = null;
			while (rs.next()) {
				Date oldestDate = rs.getDate("MIN(insert_date)");
				getOldestDate = oldestDate.toString();

			}
			return getOldestDate;
		} finally {
			close(rs);
		}
	}
}
