//
//  OTPView.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 27/10/2023.
//


import SwiftUI

struct OTPView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var forgotVM = ForgotPasswordViewModel.shared

    var body: some View {
        ZStack{
            Image("bottom_bg")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            
            VStack {
                
           
                Text("Enter your 4-digit code")
                    .font(.customfont(.semibold, fontSize: 26))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 8)
                
            
                LineTextField(txt: $forgotVM.txtEmail, title: "Code", placholder: "- - - -", keyboardType: .phonePad)
                    .padding(.bottom, .screenWidth * 0.07)
                
                Button {
                    forgotVM.serviceCallRequest()
                } label: {
                    Text("Resend Code")
                        .font(.customfont(.semibold, fontSize: 18))
                        .foregroundColor(.primaryApp)
                }
                .padding(.bottom, 15)
                
                RoundButton(title: "Submit"){
                    forgotVM.serviceCallRequest()
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
        .background(NavigationLink(destination: ForgotPasswordSetView(),isActive: $forgotVM.showSetPassword, label: {
            EmptyView()
        }))
        .background(.white)
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    OTPView()
}
