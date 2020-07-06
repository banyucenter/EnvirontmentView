//
//  AuthUser.swift
//  EnvirontmentView
//
//  Created by Ipung Dev Center on 06/07/20.
//  Copyright © 2020 Banyu Center. All rights reserved.
//

import Foundation

class AuthUser: ObservableObject {
    @Published var isLoggedin : Bool = false
    @Published var isCorrect : Bool = true
}
