//
//  MyDetailView.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 27/10/2023.
//

import SwiftUI
import CountryPicker

struct MyDetailView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var detailVM = MyDetailViewModel.shared
    @State var isShowPicker: Bool = false
    
    var body: some View {
        ZStack{
            ScrollView {
                VStack(spacing: 15) {
                    LineTextField(txt: $detailVM.txtName, title: "Name", placholder: "Enter your name")
                    VStack {
                        Text("Mobile phone")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.textTitle)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        HStack {
                            Button {
                                isShowPicker = true
                            } label: {
                                if let countryObj = detailVM.countryObj {
                                    Text("\(countryObj.isoCode.getFlag())")
                                        .font(.customfont(.semibold, fontSize: 18))
                                        .foregroundColor(.primaryText)
                                    
                                    Text("+\(countryObj.phoneCode)")
                                        .font(.customfont(.semibold, fontSize: 18))
                                        .foregroundColor(.primaryText)
                                }
                            }
                            
                            TextField("Enter Mobile", text: $detailVM.txtMobile)
                                .frame(minWidth: 0, maxWidth: .infinity)
                        }
                        Divider()
                    }
                    
                    LineTextField(txt: $detailVM.txtUserName, title: "Username", placholder: "Enter your username")
                    
                    RoundButton(title: "Update"){
                        detailVM.serviceCallUpdate()
                    }
                    .padding(.bottom, 45)
                    
                    NavigationLink {
                        ChangePasswordView()
                    } label: {
                        Text("Change password")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.primaryApp)
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
                    Text("My Detail")
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
    MyDetailView()
}
