//
//  ChangePasswordView.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 27/10/2023.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var detailVM = MyDetailViewModel.shared
    @State var isShowPicker: Bool = false
    
    var body: some View {
        ZStack{
            ScrollView {
                VStack(spacing: 15) {
                    LineSecureTextField(txt: $detailVM.txtNewPassword, isShowPassword: $detailVM.isNewPassword, title: "New Password", placholder: "Enter new password")
                        .padding(.bottom, .screenWidth * 0.02)
                    LineSecureTextField(txt: $detailVM.txtCurrentPassword, isShowPassword: $detailVM.isCurrentPassword, title: "Current Password", placholder: "Enter current password")
                        .padding(.bottom, .screenWidth * 0.02)
                    LineSecureTextField(txt: $detailVM.txtConfirmPassword, isShowPassword: $detailVM.isConfirmPassword, title: "Confirm Password", placholder: "Enter confirm password")
                        .padding(.bottom, .screenWidth * 0.02)
                    RoundButton(title: "Update"){
                        detailVM.serviceCallChangePassword()
                    }
                  
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
                .padding(.bottom, .bottomInsets + 60)
            }
            VStack {
                HStack{
                    Button(action: {
                        mode.wrappedValue.dismiss()
                    }, label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    })
                    Spacer()
                    Text("Change Password")
                        .font(.customfont(.semibold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()
                  
                    
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                .background(.white)
                .shadow( color: .black.opacity(0.2), radius: 2)
                Spacer()
                
            }
        }
        .sheet(isPresented: $isShowPicker, content: {
            CountryPickerUI(country: $detailVM.countryObj)
        })
        .alert(isPresented: $detailVM.showError){
            Alert(title: Text(Globs.AppName), message: Text(detailVM.errorMessage), dismissButton: .default(Text("OK")))
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
    
    
}

#Preview {
    ChangePasswordView()
}
