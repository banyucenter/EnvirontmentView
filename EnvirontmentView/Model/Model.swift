//
//  Model.swift
//  EnvirontmentView
//
//  Created by Ipung Dev Center on 23/08/20.
//  Copyright © 2020 Banyu Center. All rights reserved.
//

import Foundation
import SwiftUI

//4 Membuat model User Login
struct UserLogin : Codable, Identifiable {
    let id = UUID()
    let success : Bool
    let token : String
    let expires: Int
    let currUser: Int
    let user: String
    let role: Int
    let isVerified: Int
}

