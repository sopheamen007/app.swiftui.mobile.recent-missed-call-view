//
//  UserResponse.swift
//  Youtube_CallsUI
//
//  Created by Sopheamen VAN on 17/7/24.
//
import Foundation

struct UserResponse: Hashable, Identifiable {
    var id: UUID
    var name: String
    var profileUrl: String
}
