//
//  ContentView.swift
//  EnvirontmentView
//
//  Created by Ipung Dev Center on 06/07/20.
//  Copyright © 2020 Banyu Center. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var userAuth: AuthUser
    
    var body: some View {
        if !userAuth.isLoggedin {
            return AnyView(Login())
        } else {
            return AnyView(Home())
        }
    }
}

struct Login : View {
    @EnvironmentObject var userAuth: AuthUser
    
    @State private var showModal = false
    @State var username: String = ""
    @State var password: String = ""
    
    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    
    func cekLogin(){
        if(username == "Admin" && password == "123" ){
            userAuth.isLoggedin = true
        }else {
            userAuth.isLoggedin = false
            userAuth.isCorrect = false
        }
    }
    
    var body: some View {
        //Background View
        ZStack{
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack{
                //1. Purple Welcome
                HStack{
                    HStack{
                        VStack(alignment:.leading){
                            Text("Hi!").bold().font(.largeTitle).foregroundColor(.white)
                            Text("Welcome Back").font(.title).foregroundColor(.white)
                        }
                        Spacer()
                        
                        Image("bitmap")
                            .resizable()
                            .frame(width: 120, height: 80)
                            .padding()
                    }
                    Spacer()
                }
                .frame(height: 180)
                .padding(30)
                .background(Color.purple)
                .clipShape(CustomShape(corner: .bottomRight, radii: 50))
                .edgesIgnoringSafeArea(.top)
                
                
                //Form Field
                VStack(alignment:.leading){
                    //Username
                    Text("Username/email Address")
                    TextField("Username...", text: $username)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(5.0)
                    
                    //Password
                    Text("Password")
                    SecureField("Password...", text: $password)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(5.0)
                    
                    //Peringatan jika salah login
                    if(!userAuth.isCorrect){
                        Text("Username dan Password Salah!").foregroundColor(.red)
                    }
                    
                    //Forgot Password
                    HStack{
                        
                        Button(action:{}){
                            Text("Forgot Password?")
                        }
                        Spacer()
                    }.padding([.top,.bottom], 10)
                    
                    //Sign In Button
                    HStack{
                        Spacer()
                        Button(action: {self.cekLogin()}){
                            Text("Sign In").bold().font(.callout).foregroundColor(.white)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(15)
                    
                    //Privacy Policy
                    HStack{
                        Spacer()
                        Button(action: {}){
                            Text("Our Privacy Policy").bold().font(.callout).foregroundColor(.purple)
                        }
                        Spacer()
                    }
                    .padding()
                    
                    //Register Button
                    HStack{
                        Text("Don't have an account?").bold().font(.callout).foregroundColor(.black)
                        Spacer()
                        Button(action: {}){
                            Text("Sign Up?").bold().font(.callout).foregroundColor(.purple)
                        }
                    }
                    .padding()
                }.padding(30)
                
                Spacer()
            }
        }
    }
}

//Home View
struct Home : View {
    @EnvironmentObject var userAuth: AuthUser
    
    var body : some View {
        NavigationView{
            ZStack{
                Color.purple
                Text("Home").foregroundColor(.white)
                
                    .navigationBarTitle("Home", displayMode: .inline)
                .navigationBarItems(trailing:
                    
                    Button(action: {self.userAuth.isLoggedin = false}){
                            Image(systemName: "arrowshape.turn.up.right.circle")
                    }
                
                )
                
            }
        }
        
    }
}

//Custom Shape
struct CustomShape : Shape {
    var corner : UIRectCorner
    var radii : CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: radii, height: radii))
        
        return Path(path.cgPath)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}