//
//  Model.swift
//  EnvirontmentView
//
//  Created by Ipung Dev Center on 23/08/20.
//  Copyright © 2020 Banyu Center. All rights reserved.
//

import Foundation
import SwiftUI

//4 buat model
struct UserLogin : Codable, Identifiable {
    let id = UUID()
    let success: Bool
    let user: String
   
}
