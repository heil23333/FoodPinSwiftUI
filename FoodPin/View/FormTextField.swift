//
//  FormTextField.swift
//  FoodPin
//
//  Created by  He on 2025/12/26.
//

import SwiftUI

struct FormTextField: View {
    let label: String
    var placeholder: String
    
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label.uppercased())
                .font(.system(.headline, design: .rounded))
                .foregroundColor(Color(.darkGray))
            
            TextField(placeholder, text: $value)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .padding(.horizontal)
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(.systemGray5), lineWidth: 1);
                }
                .padding(.vertical, 10)
        }
    }
}

#Preview {
    FormTextField(label: "name", placeholder: "Input your name", value: .constant(""))
}
