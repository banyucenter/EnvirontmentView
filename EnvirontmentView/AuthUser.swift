//
//  AuthUser.swift
//  EnvirontmentView
//
//  Created by Ipung Dev Center on 06/07/20.
//  Copyright © 2020 Banyu Center. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class AuthUser: ObservableObject {
    
    @Published var isCorrect : Bool = true
    
    //1 membuat didChane
    var didChange = PassthroughSubject<AuthUser, Never>()
    
    //2 rubah isLoggin
    @Published var isLoggedin : Bool = false {
        didSet {
            didChange.send(self)
        }
    }
    
    //3 buat fungsi cek login
    func cekLogin(password: String, email: String) {
        guard let url = URL(string: "http://localhost:3001/auth/api/v1/login") else {
            return
        }
        
        let body : [String : String] = ["password": password,"email": email]
        
        guard let finalBody = try? JSONEncoder().encode(body) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = finalBody
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else { return }
            
            //5 Tampilkan data response JSON
            let result = try? JSONDecoder().decode(UserLogin.self, from: data)
            
            if let result = result {
                DispatchQueue.main.async {
                    print(result.success)
                    if(result.success){
                        self.isLoggedin = true
                    }
                }
            }else {
                DispatchQueue.main.async {
                    self.isCorrect = false
                }
            }
        }.resume()
    }
}

