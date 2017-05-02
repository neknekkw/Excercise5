//Connectionの取得はフレームワークなどを使うことでURLやパスワードなどを設定ファイルに記述できる。

package excercise5.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import excercise5.exception.SQLRuntimeException;

//import chapter6.exception.SQLRuntimeException;

/**
 * DB(コネクション関係)のユーティリティー
 */
public class DBUtil {
	private static final String DRIVER = "com.mysql.jdbc.Driver";
	private static final String URL = "jdbc:mysql://localhost/board";
	private static final String USER = "root";
	private static final String PASSWORD = "151658kK3.";

	static {

		//これ実行することで次のDriverManager.getConnection～でDBと接続できるようになる。
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * コネクションを取得します。
	 *
	 * @return
	 */
	
	public static Connection getConnection() {

		try {
			//ここでコネクションの取得をしてる(DBと接続）
			Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
			//ここでオートコッミトモードの変更（SQLを実行するたびトランザクションをコミットしてしまう。
			connection.setAutoCommit(false);

			return connection;
		} catch (SQLException e) {
			throw new SQLRuntimeException(e);
		}
	}

	/**
	 * コミットします。
	 *
	 * @param connection
	 */
	public static void commit(Connection connection) {

		try {
			connection.commit();
		} catch (SQLException e) {
			throw new SQLRuntimeException(e);
		}
	}

	/**
	 * ロールバックします。
	 *
	 * @param connection
	 */
	public static void rollback(Connection connection) {

		if (connection == null) {
			return;
		}

		try {
			connection.rollback();
		} catch (SQLException e) {
			throw new SQLRuntimeException(e);
		}
	}

}
