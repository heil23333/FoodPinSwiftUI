//
//  ReviewView.swift
//  FoodPin
//
//  Created by  He on 2025/12/25.
//

import SwiftUI

struct ReviewView: View {
    var restaurant: Restaurant
    @Binding var isDisplay: Bool
    
    @State var showRatings = false
    
    var body: some View {
        ZStack {
            Image(uiImage: restaurant.image)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .ignoresSafeArea()
            
            Color.black
                .opacity(0.1)
                .background(.ultraThinMaterial)
                .ignoresSafeArea()
            
            HStack {
                Spacer()
                
                VStack {
                    Button {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            self.isDisplay = false
                            print("close")
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .padding()
                    }
                    Spacer()
                }
            }
            
            VStack(alignment: .leading) {
                ForEach(Restaurant.Rating.allCases, id: \.self) { rating in
                    HStack {
                        Image(rating.image)
                        
                        Text(rating.rawValue)
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                    .animation(.easeOut.delay(Double(Restaurant.Rating.allCases.firstIndex(of: rating)!) * 0.05), value: showRatings)
                    .onTapGesture {
                        self.restaurant.rating = rating
                        self.isDisplay = false
                    }
                }
            }
            .opacity(showRatings ? 1.0: 0.0)
            .offset(x: showRatings ? 0 : 1000)
        }
        
        .onAppear {
            showRatings.toggle()
        }
    }
}

#Preview {
    ReviewView(restaurant: Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: UIImage(named: "cafedeadend")!, isFavorite: false), isDisplay: .constant(true))
}
