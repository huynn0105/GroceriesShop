//
//  AddDeliveryAddressView.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 25/10/2023.
//

import SwiftUI

struct AddDeliveryAddressView: View {
    
    @StateObject var addressVM = DeliveryAddressViewModel.shared
    @State var isEdit: Bool = false
    @State var editObj: AddressModel?
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        ZStack{
            ScrollView {
                VStack(spacing: 15){
                    HStack{
                        Button{
                            addressVM.txtTypeName = "Home"
                        } label: {
                            Image(systemName: addressVM.txtTypeName == "Home" ? "record.circle" : "circle")
                            
                            Text("Home")
                                .font(.customfont(.medium, fontSize: 16))
                                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,maxWidth: .infinity, alignment: .leading)
                        }
                        .foregroundColor(.primaryText)
                        
                        Button{
                            addressVM.txtTypeName = "Office"
                        } label: {
                            Image(systemName: addressVM.txtTypeName == "Office" ? "record.circle" : "circle")
                            
                            Text("Office")
                                .font(.customfont(.medium, fontSize: 16))
                                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,maxWidth: .infinity, alignment: .leading)
                        }
                        .foregroundColor(.primaryText)
                        
                      
                    }
                    .padding(.bottom,15)
                    
                    LineTextField(txt: $addressVM.txtName, title: "Name", placholder: "Enter your name")
                    LineTextField(txt: $addressVM.txtMobile, title: "Mobile Number", placholder: "Enter your mobile number", keyboardType: .numberPad)
                    LineTextField(txt: $addressVM.txtAddress, title: "Address Line", placholder: "Enter your address line")
                    HStack {
                        LineTextField(txt: $addressVM.txtCity, title: "City", placholder: "Enter your city")
                        LineTextField(txt: $addressVM.txtState, title: "State", placholder: "Enter your state")
                    }
                   
                    LineTextField(txt: $addressVM.txtPostalCode, title: "Postal Code", placholder: "Enter your postal code")
                    
                    RoundButton(title: (isEdit ? "Update": "Add") + " Address"){
                        if isEdit {
                            addressVM.serviceCallUpdateAddresss(eObj: editObj) {
                                self.mode.wrappedValue.dismiss()
                            }
                        } else {
                            addressVM.serviceCallAddToAddress {
                                self.mode.wrappedValue.dismiss()
                            }
                        }
                    }
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
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
                    Text((isEdit ? "Edit" : "Add") + " Delivery Address")
                        .font(.customfont(.semibold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()
                    Button(action: {
                        mode.wrappedValue.dismiss()
                    }, label: {
                        Image("add_green")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.black)
                            .frame(width: 20, height: 20)
                    })
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                .background(.white)
                .shadow( color: .black.opacity(0.2), radius: 2)
                Spacer()
                
            }
            
        }
        .onAppear{
            if let aObj = editObj {
                addressVM.setData(aObj: aObj)
            }
        }
        .alert(isPresented: $addressVM.showError) {
            Alert(title: Text(Globs.AppName), message: Text(addressVM.errorMessage), dismissButton: .default(Text("OK")))
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    AddDeliveryAddressView()
}
