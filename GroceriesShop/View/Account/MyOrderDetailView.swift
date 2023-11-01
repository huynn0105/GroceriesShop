//
//  MyOrderDetailView.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 27/10/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct MyOrderDetailView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @StateObject var detailVM = MyOrderDetailViewModel(mObj: MyOrderModel(dict: [:]) )
    
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack(spacing: 8){
                    HStack {
                        Text("Order No: #\(detailVM.mObj.orderId)")
                            .font(.customfont(.semibold, fontSize: 20))
                        Spacer()
                        Text(getPaymentStatus(mObj: detailVM.mObj))
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(getPaymentStatusColor(mObj: detailVM.mObj))
                    }
                    
                    HStack {
                        Text(detailVM.mObj.createdDate.displayDate(format: "yyyy-MM-dd HH:mm:ss"))
                            .font(.customfont(.semibold, fontSize: 14))
                            .foregroundColor(.secondary)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        Text(getOrderStatus(mObj: detailVM.mObj))
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(getOrderStatusColor(mObj: detailVM.mObj))
                    }
                    
                    Text("\(detailVM.mObj.address),\(detailVM.mObj.city), \(detailVM.mObj.state), \(detailVM.mObj.postalCode)")
                        .font(.customfont(.medium, fontSize: 18))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        Text("Delivery Type: ")
                            .font(.customfont(.semibold, fontSize: 18))
                        Spacer()
                        Text(getDeliveryType(mObj: detailVM.mObj)).font(.customfont(.regular, fontSize: 16))
                            .foregroundColor(.primaryText)
                    }
                    
                    HStack {
                        Text("Payment Type: ")
                            .font(.customfont(.semibold, fontSize: 18))
                        Spacer()
                        Text(getPaymentType(mObj: detailVM.mObj)).font(.customfont(.regular, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                    }
                    LazyVStack(spacing: 15) {
                        ForEach(detailVM.listArr, id: \.id) {
                            cObj in
                            OrderItemRow(cObj: cObj)
                        }
                    }
                    .padding(.top, 20)
                    Divider()
                    VStack(spacing: 8){
                        HStack {
                            Text("Amount")
                                .font(.customfont(.semibold, fontSize: 18))
                            
                            Spacer()
                            
                            Text("$\(detailVM.mObj.totalPrice, specifier: "%.2f")")
                                .font(.customfont(.semibold, fontSize: 18))
                                .foregroundColor(.secondary)
                        }
                        
                        HStack{
                            Text("Delivery Cost")
                                .font(.customfont(.semibold, fontSize: 18))
                            
                            
                            Spacer()
                            Text("+ $\(detailVM.mObj.deliverPrice, specifier: "%.2f")")
                                .font(.customfont(.semibold, fontSize: 18))
                                .foregroundColor(.secondary)
                        }
                        
                        HStack{
                            Text("Discount")
                                .font(.customfont(.semibold, fontSize: 18))
                            
                            
                            Spacer()
                            Text("- $\(detailVM.mObj.discountPrice, specifier: "%.2f")")
                                .font(.customfont(.semibold, fontSize: 18))
                                .foregroundColor(.red)
                        }
                        
                        Divider()
                        HStack {
                            Text("Final Total")
                                .font(.customfont(.semibold, fontSize: 20))
                            
                                .frame(height: 46)
                            
                            Spacer()
                            Text("$\(detailVM.mObj.userPayPrice, specifier: "%.2f")")
                                .font(.customfont(.semibold, fontSize: 20))
                                .foregroundColor(.primaryText)
                                .frame(height: 46)
                            
                        }
                        Divider()
                    }
                    
                    .padding(.top, 20)
                }
                .padding(.top, .topInsets + 60)
                .padding(.bottom, .bottomInsets + 60)
                .padding(.horizontal, 20)
                
                
                
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
                    Text("My Order Detail")
                        .font(.customfont(.semibold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                .background(.white)
                .shadow(color: .black.opacity(0.2), radius: 2)
                Spacer()
                
            }
            
            
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
    
    
    func getOrderStatus(mObj: MyOrderModel) -> String {
        switch mObj.orderStatus {
        case 1:
            return "Placed"
        case 2:
            return "Accepted"
        case 3:
            return "Delivered"
        case 4:
            return "Cancel"
        case 5:
            return "Declined"
        default:
            return ""
        }
    }
    
    func getDeliveryType(mObj: MyOrderModel) -> String {
        switch mObj.deliverType {
        case 1:
            return "Delivery"
        case 2:
            return "Collection"
            
        default:
            return ""
        }
    }
    
    func getPaymentType(mObj: MyOrderModel) -> String {
        switch mObj.paymentType {
        case 1:
            return "Cash On Delivery"
        case 2:
            return "Online Card Payment"
            
        default:
            return ""
        }
    }
    
    func getPaymentStatus(mObj: MyOrderModel) -> String {
        switch mObj.paymentStatus {
        case 1:
            return "Processing"
        case 2:
            return "Success"
        case 3:
            return "Fail"
        case 4:
            return "Refund"
        default:
            return ""
        }
    }
    
    func getPaymentStatusColor(mObj: MyOrderModel) -> Color {
        if mObj.paymentType == 1 {
            return Color.orange
        }
        switch mObj.paymentStatus {
        case 1:
            return Color.blue
        case 2:
            return Color.green
        case 3:
            return Color.red
        case 4:
            return Color.green
        default:
            return Color.white
        }
    }
    func getOrderStatusColor(mObj: MyOrderModel) -> Color {
        
        switch mObj.paymentStatus {
        case 1:
            return Color.blue
        case 2:
            return Color.green
        case 3:
            return Color.green
        case 4:
            return Color.red
        case 5:
            return Color.red
        default:
            return Color.primary
        }
    }
}



#Preview {
    MyOrderDetailView(detailVM: MyOrderDetailViewModel(mObj: MyOrderModel(dict: [
        "order_id": 4,
        "cart_id": "5,4,3,2",
        "total_price": 26.910000000000004,
        "user_pay_price": 26.219,
        "discount_price": 2.6910000000000007,
        "deliver_price": 2,
        "deliver_type": 1,
        "payment_type": 1,
        "payment_status": 1,
        "order_status": 3,
        "status": 1,
        "created_date": "2023-10-23T04:09:29.000Z",
        "names": "Organic Banana",
        "images": "http://localhost:3001/img/product/202310201251135113XBYXQLjdjL.png",
        "user_name": "Huy1",
        "phone": "512131331",
        "address": "home, hcm",
        "city": "hcm",
        "state": "hcm",
        "postal_code": "131323"
        
    ])))
}
