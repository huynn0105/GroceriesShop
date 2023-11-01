//
//  MyOrderRow.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 27/10/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct MyOrderRow: View {
    @State var mObj: MyOrderModel
    var body: some View {
        VStack{
            HStack {
                Text("Order No: #\(mObj.orderId)")
                    .font(.customfont(.semibold, fontSize: 18))
                    .foregroundColor(.primaryText)
                Spacer()
                Text(getOrderStatus(mObj: mObj))
                    .font(.customfont(.semibold, fontSize: 18))
                    .foregroundColor(getOrderStatusColor(mObj: mObj))
            }
            Text(mObj.createdDate.displayDate(format: "yyyy-MM-dd HH:mm:ss"))
                .font(.customfont(.semibold, fontSize: 14))
                .foregroundColor(.secondary)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            HStack{
                WebImage(url: URL(string: mObj.images.components(separatedBy: ",").first ?? ""))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                
                VStack{
                    HStack {
                        Text("Items")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        Text(mObj.names).font(.customfont(.semibold, fontSize: 14))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                        
                    } .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    HStack {
                        Text("Delivery Type")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        Text(getDeliveryType(mObj: mObj)).font(.customfont(.semibold, fontSize: 14))
                            .foregroundColor(.secondary)
                        
                    }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    HStack {
                        Text("Payment Type")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        Text(getPaymentType(mObj: mObj)).font(.customfont(.semibold, fontSize: 14))
                            .foregroundColor(.secondary)
                        
                    }  .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    HStack {
                        Text("Payment Status")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        Text(getPaymentStatus(mObj: mObj)).font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(getPaymentStatusColor(mObj: mObj))
                        
                    } .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
            }
            
        }
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
    
    func  getPaymentType(mObj: MyOrderModel) -> String {
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
    MyOrderRow(mObj: MyOrderModel(dict: [
        "order_id": 1,
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
        "postal_code": "131323"]))
}
