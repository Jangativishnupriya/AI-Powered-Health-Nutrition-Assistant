package com.model;

public class UserModel {
	
	private String Fullname;
	private String email;
	private String passwordKey;
	private String confirmPassword;
	private int age;
	private String gender;
	private String rol;
	private String status;
	

	public UserModel() {
		
	}
	public UserModel(String Fullname, String email, String passwordKey, String confirmPassword, int age, String gender) {
		super();
		this.Fullname = Fullname;
		this.email = email;
		this.passwordKey = passwordKey;
		this.confirmPassword = confirmPassword;
		this.age = age;
		this.gender = gender;
	}



	public String getName() {
		return Fullname;
	}

	public void setName(String Fullname) {
		this.Fullname = Fullname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return passwordKey;
	}

	public void setPassword(String passwordKey) {
		this.passwordKey = passwordKey;
	}

	public String getConfirmPassword() {
		return confirmPassword;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}
	
	

	public String getRol() {
		return rol;
	}
	public void setRol(String rol) {
		this.rol = rol;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "UserModel [name=" + Fullname + ", email=" + email + ", password=" + passwordKey + ", confirmPassword="
				+ confirmPassword + ", age=" + age + ", gender=" + gender + "]";
	}
	
	

}
