package com.example.Real_Estate.exception;

public class UserNotFoundException extends RuntimeException{

	public UserNotFoundException() {
		super();
	}

	public UserNotFoundException(String message) {
		super(message);
	}
	

}
