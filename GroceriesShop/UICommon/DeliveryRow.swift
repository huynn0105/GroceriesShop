//
//  DeliveryRow.swift
//  GroceriesShop
//
//  Created by Klabs Mobile on 27/10/2023.
//

import SwiftUI

struct DeliveryRow: View {
    @State var aObj: AddressModel
    
    var body: some View {
        HStack(spacing: 15){
            VStack{
                HStack{
                    Text(aObj.name)
                        .font(.customfont(.semibold, fontSize: 18))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Text(aObj.typeName)
                        .font(.customfont(.semibold, fontSize: 12))
                        .foregroundColor(.primaryText)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(Color.secondaryText.opacity(0.3))
                        .cornerRadius(5)
                    
                }
                Text("\(aObj.address),\(aObj.city), \(aObj.state), \(aObj.postalCode)")
                    .font(.customfont(.medium, fontSize: 14))
                    .foregroundColor(.primaryText)
                    .multilineTextAlignment(.leading)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Text(aObj.phone)
                    .font(.customfont(.semibold, fontSize: 12))
                    .foregroundColor(.secondary)
                    .padding(.vertical, 8)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
            }
            VStack{
                Spacer()
                NavigationLink{
                    AddDeliveryAddressView(isEdit: true,editObj: aObj)
                } label: {
                    Image(systemName: "pencil")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.primaryApp)
                }  .padding(.bottom, 8)
                
                Button {
                    
                } label: {
                    Image("close")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                Spacer()
            }
            
        }
    }
}

#Preview {
    DeliveryRow(aObj: AddressModel(dict: [
        "address_id": 1,
        "name": "Huy1",
        "phone": "512131331",
        "address": "home, hcm",
        "city": "hcm",
        "state": "hcm",
        "type_name": "Home1",
        "postal_code": "131323",
        "is_default": 1]))
}
