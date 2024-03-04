//
//  NetworkError.swift
//  BCILift
//
//  Created by Ahmer Mughal on 26.02.24.
//

import Foundation

enum NetworkError: String, Error{
    
    case invalidEmail = "Email does not exist. Please check and try again."
    case invalidEmailOrPassword = "Email or Password is incorrect."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please Try Again."
    case invalidData = "The data received from the server was invalid. Please Try Again."
    case invalidDiscountCode = "The discount code is invalid. Please check and try again."
    case accountAlreadyExist = "Account already exist."
    case incorrectEmailOrPhone = "Incorrent email or phone. Please check and try again."
    case passswordUpdateFailed = "Password Update Failed. Please check the passwords and try again."
    
}
