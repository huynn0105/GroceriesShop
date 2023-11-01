//
//  SignInView.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 21/09/2023.
//

import SwiftUI
import CountryPicker

struct SignInView: View {
    
    @State var txtMobile : String = ""
    @State var isShowPicker: Bool = false
    @State var countryObj: Country?
    var body: some View {
        ZStack{
            Image("bottom_bg")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            
            VStack{
                Image("sign_in_top")
                    .resizable()
                    .scaledToFill()
                    .frame(width: .screenWidth, height: .screenWidth)
                Spacer()
            }
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Get your groceries\nwith nectar")
                        .font(.customfont(.semibold, fontSize: 26))
                        .foregroundColor(.primaryText)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom,25)
                    
                    HStack {
                        Button {
                            isShowPicker = true
                        } label: {
                            if let countryObj = countryObj {
                                Text("\(countryObj.isoCode.getFlag())")
                                    .font(.customfont(.semibold, fontSize: 18))
                                    .foregroundColor(.primaryText)
                                
                                Text("+\(countryObj.phoneCode)")
                                    .font(.customfont(.semibold, fontSize: 18))
                                    .foregroundColor(.primaryText)
                            }
                        }.padding(.trailing, 5)
                        
                        TextField("Enter Mobile", text: $txtMobile)
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    
//                    NavigationLink {
//                        LoginView()
//                    } label: {
//                        Text("Continute with Email Sign In")
//                            .font(.customfont(.semibold, fontSize: 18))
//                            .foregroundColor(.white)
//                            .multilineTextAlignment(.center)
//                    }
//                    .frame(minWidth: 0,maxWidth: .infinity, minHeight: 60, maxHeight: 60 )
//                    .background(Color(hex: "5383EC"))
//                    .cornerRadius(20)
//                    .padding(.bottom, 8)
//                    
//                    
//                    NavigationLink {
//                        SignUpView()
//                    } label: {
//                        Text("Continute with Email Sign In")
//                            .font(.customfont(.semibold, fontSize: 18))
//                            .foregroundColor(.white)
//                            .multilineTextAlignment(.center)
//                    }
//                    .frame(minWidth: 0,maxWidth: .infinity, minHeight: 60, maxHeight: 60 )
//                    .background(Color.primaryApp)
//                    .cornerRadius(20)
//                    .padding(.bottom, 8)

                    
                    Divider()
                        .padding(.bottom,25)
                    
                    Text("Or connect with social media")
                        .font(.customfont(.semibold, fontSize: 14))
                        .foregroundColor(.textTitle)
                        .multilineTextAlignment(.center)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        .padding(.bottom,25)
                    
                    Button {
                        
                    } label: {
                        Image("google_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        Text("Continute with Google")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    .frame(minWidth: 0,maxWidth: .infinity, minHeight: 60, maxHeight: 60 )
                    .background(Color(hex: "5383EC"))
                    .cornerRadius(20)
                    .padding(.bottom, 8)
                    Button {
                        
                    } label: {
                        Image("fb_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        Text("Continute with Facebook")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    .frame(minWidth: 0,maxWidth: .infinity, minHeight: 60, maxHeight: 60 )
                    .background(Color(hex: "4A66AC"))
                    .cornerRadius(20)
                    .padding(.bottom, 8)
                }
                .padding(.horizontal, 20)
                .frame(width: .infinity, alignment: .leading)
                .padding(.top, .topInsets + .screenWidth * 0.7)
                
                
           
            }
            
        }
        .onAppear{
            self.countryObj = Country(phoneCode: "84", isoCode: "VN")
        }
        .sheet(isPresented: $isShowPicker, content: {
            CountryPickerUI(country: $countryObj)
        })
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
