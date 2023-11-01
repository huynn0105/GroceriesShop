//
//  ForgotPasswordSetView.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 27/10/2023.
//


import SwiftUI

struct ForgotPasswordSetView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var forgotVM = ForgotPasswordViewModel.shared

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
                
                Text("Set New Password")
                    .font(.customfont(.semibold, fontSize: 26))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 50)
                
             
                LineSecureTextField(txt: $forgotVM.txtNewPassword, isShowPassword: $forgotVM.isNewPassword, title: "New Password", placholder: "Enter new password")
                    .padding(.bottom, .screenWidth * 0.07)
                
                LineSecureTextField(txt: $forgotVM.txtConfirmPassword, isShowPassword: $forgotVM.isConfirmPassword, title: "Confirm New Password", placholder: "Enter confirm password")
                    .padding(.bottom, .screenWidth * 0.07)
                
               
                
                RoundButton(title: "Submit"){
                    forgotVM.serviceCallSet()
                }.padding(.bottom, .screenWidth * 0.03)
                
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
        .alert(isPresented: $forgotVM.showError) {
            Alert(title: Text(Globs.AppName), message: Text(forgotVM.errorMessage), dismissButton: .default(Text("OK")))
        }
       
        .background(.white)
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}


#Preview {
    ForgotPasswordSetView()
}
