//
//  LoginResponseStruct.swift
//  SalesLoop
//
//  Created by Jack Crane on 3/13/24.
//

import Foundation

struct LoginResponse: Codable {
    var token: String?
    var message: String?
}
