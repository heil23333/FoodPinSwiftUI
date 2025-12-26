//
//  SwiftUIView.swift
//  FoodPin
//
//  Created by  He on 2025/12/22.
//

import SwiftUI

struct RestaurantDetailView: View {
    var restaurant: Restaurant
    
    @State private var showReview = false
    
    @Environment(\.dismiss) var dismiss//关闭目前视图的环境值
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(restaurant.image)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 445)
                    .overlay {
                        VStack {
                            if restaurant.isFavorite {
                                Image(systemName: "heart.fill")
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topTrailing)
                                    .padding()
                                    .font(.system(size: 30))
                                    .foregroundColor(.yellow)
                                    .padding(.top, 40)
                            } else {
                                Image(systemName: "heart")
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topTrailing)
                                    .padding()
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                                    .padding(.top, 40)
                            }
                            
                            HStack(alignment: .bottom) {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(restaurant.name)
                                        .font(.custom("Nunito-Regular", size: 35, relativeTo: .largeTitle))
                                        .bold()
                                    
                                    Text(restaurant.type)
                                        .font(.system(.headline, design: .rounded))
                                        .padding(.all, 5)
                                        .background(.black)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottomLeading)
                                .foregroundStyle(.white)
                                .padding()
                                
                                //如果有rating就显示
                                if let rating = restaurant.rating, !showReview {
                                    Image(rating.image)
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .padding([.bottom, .trailing])
                                        .transition(.scale)
                                }
                            }
                        }
                    }
                
                Text(restaurant.description)
                    .padding()
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("Address")
                            .font(.system(.headline, design: .rounded))
                        
                        Text(restaurant.location)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading) {
                        Text("Phone")
                            .font(.system(.headline, design: .rounded))
                        
                        Text(restaurant.phone)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal)
                
                NavigationLink {//要导航去的View
                    MapView(location: restaurant.location)
                        .toolbarBackground(.hidden, for: .navigationBar)
                        .edgesIgnoringSafeArea(.all)
                } label: {//被点击的View
                    MapView(location: restaurant.location)
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(20)
                }
                
                Button {
                    self.showReview.toggle()
                } label: {
                    Text("Rate it")
                        .font(.system(.headline, design: .rounded))
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .tint(Color("NavigationBarTitle"))
                .buttonStyle(.borderedProminent)//显示纯色背景
                .buttonBorderShape(.roundedRectangle(radius: 25))
                .controlSize(.large)
                .padding(.horizontal)
                .padding(.bottom, 20)

            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)//隐藏自带的返回按钮
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Text("\(Image(systemName: "chevron.left"))\(restaurant.name)").tint(.white)
                }
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .overlay {
            self.showReview ?
            ZStack {
                ReviewView(restaurant: self.restaurant, isDisplay: $showReview)
            } : nil
        }
    }
}

#Preview {
    NavigationStack {
        RestaurantDetailView(restaurant: Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", phone: "10086", description:"test", image: "cafedeadend", isFavorite: false, rating: .awesome))
    }
}
