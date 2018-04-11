package com.system.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import com.system.daoImpl.StudentDaoImpl;
import com.system.daoImpl.Student_TeacherDaoImpl;
import com.system.entity.Student;
import com.system.entity.Teacher;
import com.system.util.ConnectionFactory;

public class BindingService {
	/*
	 * 通过老师的ID查看所有绑定了得学生
	 * 
	 */
	public Vector<Student> getAllStudent(Teacher teacher) {
		Vector<Student> v = new Vector<Student>();
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		StudentDaoImpl impl = new StudentDaoImpl();
		ResultSet studentIDSet = null;
		ResultSet studentSet = null;
		try {
			conn.setAutoCommit(false);
			studentIDSet = new Student_TeacherDaoImpl().get(conn, teacher);
			while (studentIDSet.next()) {
				Student tempS = new Student();
				tempS.setId(studentIDSet.getLong("studentID"));
				studentSet = impl.getByID(conn, tempS);
				while (studentSet.next()) {
					Student trueS = new Student();
					trueS.setId(studentSet.getLong("studentID"));
					trueS.setName(studentSet.getString("studentName"));
					trueS.setEmail(studentSet.getString("studentEmail"));
					trueS.setGender(String.valueOf(studentSet.getInt("studentGender")));
					v.add(trueS);
				}
			}
			conn.commit();
			return v;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			return null;
		} finally {
		
				if(studentSet!=null){
					try {
						studentSet.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				if(studentIDSet!=null){
					try {
						studentIDSet.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			
		}
	}

	/*
	 * 添加绑定信息之前查重复,传入Email参数 如果能够绑定，表示检验通过（之前没有绑定过）则返回True，否则返回false；
	 */
	public boolean CheckWhetherBinding(Student student, Teacher teacher) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		ConsultService cService = new ConsultService();
		ResultSet set = null;
		try {
			conn.setAutoCommit(false);
			teacher = cService.getTeacherID(teacher);
			student = cService.getStudentID(student);
			if (teacher != null && student != null) {
				set = new Student_TeacherDaoImpl().get(conn, student, teacher);
				conn.commit();
				while (set.next()) {
					return false;
				}
				return true;// 表示检验通过
			} else {
				return false;
			}
		} catch (Exception e) {
			// TODO: handle exception
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
			return false;
		} finally {
			try {
				set.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			try {
				conn.close();
				set.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}

	/*
	 * 传入需要绑定的学生和老师，其中均必须有Email这个属性
	 */
	public boolean InsertBindStudentTeacherService(Student student, Teacher teacher) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();

		ConsultService service = new ConsultService();
		try {
			conn.setAutoCommit(false);
			student = service.getStudentID(student);
			teacher = service.getTeacherID(teacher);

			if (student == null || teacher == null || student.getId() == null || teacher.getId() == null
					|| teacher.getId().equals("") || student.getId().equals("")) {
				return false;
			} else {
				new Student_TeacherDaoImpl().insert(conn, student, teacher);
				conn.commit();
				// System.out.println("绑定申请提交");
				return true;
			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			try {
				conn.rollback();
				// System.out.println("回滚");
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			return false;
		} finally {

			try {
				conn.close();

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/*
	 * 获得所有绑定申请学生
	 */
	public List<Student> getApplyStudent(Teacher teacher) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		List<Student> studentList = new ArrayList<Student>();
		ConsultService service = new ConsultService();
		ResultSet applySet = null;
		ResultSet studentSet = null;
		try {
			conn.setAutoCommit(false);

			teacher = service.getTeacherID(teacher);
			if (teacher == null || teacher.getId() == null || teacher.getId().equals("")) {
				return null;
			}
			applySet = new Student_TeacherDaoImpl().getApplies(conn, teacher);
			while (applySet.next()) {
				Long sid = applySet.getLong("studentID");
				Student s = new Student();
				s.setId(sid);
				studentSet = new StudentDaoImpl().getByID(conn, s);
				while (studentSet.next()) {
					Student adds = new Student();
					adds.setName(studentSet.getString("studentName"));

					adds.setGender(String.valueOf(studentSet.getInt("studentGender")));
					adds.setEmail(studentSet.getString("studentEmail"));
					studentList.add(adds);
				}
				studentSet.close();
			}
			return studentList;
		} catch (Exception e) {
			// TODO: handle exception
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			return null;

		} finally {
			try {
				applySet.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/*
	 * 
	 * 更改绑定状态
	 * 
	 */
	public boolean acceptBindingService(Student student, Teacher teacher) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		ConsultService service = new ConsultService();
		try {
			conn.setAutoCommit(false);
			student = service.getStudentID(student);
			teacher = service.getTeacherID(teacher);

			if (student == null || teacher == null || student.getId() == null || teacher.getId() == null
					|| teacher.getId().equals("") || student.getId().equals("")) {
				return false;
			} else {
				new Student_TeacherDaoImpl().changeState(conn, student, teacher, true);
				conn.commit();
				return true;
			}
		} catch (Exception e) {
			// TODO: handle exception
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
			return false;
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}

	/*
	 * 拒绝申请的时候调用
	 */
	public boolean cancelBindingService(Student student, Teacher teacher) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		ConsultService service = new ConsultService();
		try {
			
			conn.setAutoCommit(false);
			student = service.getStudentID(student);
			teacher = service.getTeacherID(teacher);
			if (student == null || teacher == null || student.getId() == null || teacher.getId() == null
					|| student.getId().equals("") || teacher.getId().equals("")) {
				return false;
			} else {
				Student_TeacherDaoImpl std = new Student_TeacherDaoImpl();
				std.changeState(conn, student, teacher, false);
				std.delete(conn, student, teacher);
				conn.commit();
				return true;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			return false;
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/*
	 * 直接创建一个成功绑定的行
	 */
	public boolean createBinding(Student student, Teacher teacher) {
		Connection conn = ConnectionFactory.getInstace().makeConnection();
		ConsultService service=new ConsultService();
		try {
			student = service.getStudentID(student);
			teacher = service.getTeacherID(teacher);
			conn.setAutoCommit(false);
			new Student_TeacherDaoImpl().teacherPush(conn, student, teacher);
			conn.commit();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			return false;
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
