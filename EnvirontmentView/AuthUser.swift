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
import SystemConfiguration

class AuthUser: ObservableObject {
    
    // membuat didchange
    var didChange = PassthroughSubject<AuthUser, Never>()
    
    @Published var isCorrect : Bool = true
    @Published var userName : String = ""
    @Published var isConnected : Bool = true
    
    //1 state published api reachable
    @Published var isApiReachable: Bool = true {
        didSet {
            didChange.send(self)
        }
    }
    
    // rubah state
    @Published var isLoggedin : Bool = false {
        didSet {
            didChange.send(self)
        }
    }
    
    // fungsi cek login
    func cekLogin(password: String, email: String){
        // 2 set url
        let apiaddress = "http://localhost:3001/auth/api/v1/login"
        
        //3 pasang url
        guard let url = URL(string: apiaddress) else {
            return
        }
        
        let body : [String : String] = ["password": password, "email": email]
        
        guard let finalBody = try? JSONEncoder().encode(body) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = finalBody
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            //4 set isApiReachable
            guard let data = data, error == nil else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                DispatchQueue.main.async {
                    self.isApiReachable = false
                }
                return
                
            }
            
            // decode data
            let result = try? JSONDecoder().decode(UserLogin.self, from: data)
            
            if let result = result {
                DispatchQueue.main.async {
                    if(result.success){
                        self.isLoggedin = true
                        //ubah status isCorrect
                        self.isCorrect = true
                        self.userName = result.user
                    //6 is Correct
                    }else {
                        self.isCorrect = false
                    }
                }
                //7 set Invalid
            } else {
                DispatchQueue.main.async {
                    print("Invalid response from server")
                }
            }
            
        }.resume()
    }
    
}
