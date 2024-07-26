//
//  CallResponse.swift
//  Youtube_CallsUI
//
//  Created by Sopheamen VAN on 17/7/24.
//
import Foundation

struct CallResponse: Hashable, Identifiable {
    var id: UUID
    var user: UserResponse
    var type: Int // assuming 1 missed, 2 incoming, 3 outgoing
    var callType: Int // assuimg 1 voice call, 2 video call
    var time: String
}
