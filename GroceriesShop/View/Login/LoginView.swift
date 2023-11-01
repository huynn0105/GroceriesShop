//
//  LoginView.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 22/09/2023.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var loginVM = MainViewModel.shared

    var body: some View {
        ZStack{
            Image("bottom_bg")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            
            VStack {
                
               
                Image("color_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                    .padding(.bottom, .screenWidth * 0.1)
                
                Text("Loging")
                    .font(.customfont(.semibold, fontSize: 26))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 4)
                
                Text("Enter your  email and password")
                    .font(.customfont(.semibold, fontSize: 16))
                    .foregroundColor(.secondaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, .screenWidth * 0.1)
                LineTextField(txt: $loginVM.txtEmail, title: "Email", placholder: "Enter your email address", keyboardType: .emailAddress)
                    .padding(.bottom, .screenWidth * 0.07)
                
                LineSecureTextField(txt: $loginVM.txtPassword, isShowPassword: $loginVM.isShowPassword, title: "Password", placholder: "Enter your password" )
                    .padding(.bottom, .screenWidth * 0.02)
             
                    NavigationLink{
                        ForgotPasswordView()
                    } label: {
                        Text("Forgot Password?")
                            .font(.customfont(.medium, fontSize: 14))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                            .padding(.bottom, .screenWidth * 0.03)
                    }
                RoundButton(title: "Log In"){
                    loginVM.serviceCallLogin()
                }.padding(.bottom, .screenWidth * 0.03)
                
                
                NavigationLink {
                    SignUpView()
                } label: {
                    HStack {
                        
                            Text("Don't have an account?")
                                .font(.customfont(.medium, fontSize: 14))
                                .foregroundColor(.primaryText)
                        
                        Text("Signup")
                            .font(.customfont(.medium, fontSize: 14))
                            .foregroundColor(.primaryApp)
                    }
                }

                
               
                
                Spacer()
                
            }
            .padding(.top, .topInsets + 64)
            .padding(.horizontal, 20)
            .padding(.bottom, .bottomInsets)
            
            
            VStack {
                HStack {
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20,height: 20)
                    }
                    Spacer()

                }
                
                Spacer()
            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
            
        }
        .alert(isPresented: $loginVM.showError) {
            Alert(title: Text(Globs.AppName), message: Text(loginVM.errorMessage), dismissButton: .default(Text("OK")))
        }
        .background(.white)
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}
