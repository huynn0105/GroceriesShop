//
//  NotificationView.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 27/10/2023.
//

import SwiftUI

struct NotificationView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @StateObject var notifVM = NotificationViewModel.shared
    @State var isPicker: Bool = false
    var didSelect: ( (_ aObj: AddressModel) -> () )?
    
    var body: some View {
        ZStack{
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(notifVM.listArr, id: \.id) { nObj in
                        VStack(spacing: 10){
                            HStack {
                                Text(nObj.title)
                                    .font(.customfont(.semibold, fontSize: 18))
                                .foregroundColor(.primaryText)
                                Spacer()
                                Text(nObj.createdDate.displayDate(format: "yyyy-MM-dd HH:mm:ss"))
                                    .font(.customfont(.semibold, fontSize: 14))
                                    .foregroundColor(.secondary)
                                   
                            }
                            Text(nObj.message)
                                .font(.customfont(.regular, fontSize: 15))
                                .foregroundColor(.primaryText)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(15)
                        .background(nObj.isRead == 1 ? Color.placeholder.opacity(0.3) : Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.15), radius: 2)
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
                    Text("Notifications")
                        .font(.customfont(.semibold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()
                    NavigationLink{
                       
                    } label: {
                       Text("Read All")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.primaryApp)
                    }
                    
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                .background(.white)
                .shadow( color: .black.opacity(0.2), radius: 2)
                Spacer()
                
            }
            
            
        }
        .alert(isPresented: $notifVM.showError) {
            Alert(title: Text(Globs.AppName), message: Text(notifVM.errorMessage), dismissButton: .default(Text("OK")))
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
    
    
}

#Preview {
    NotificationView()
}
