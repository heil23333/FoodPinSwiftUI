//
//  ContentView.swift
//  FoodPin
//
//  Created by  He on 2025/12/15.
//

import SwiftUI
import SwiftData

struct RestaurantListView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    @Query var restaurants: [Restaurant]
    
    @State private var restaurantIsFavorites = Array(repeating: false, count: 21)
    
    @State private var showNewRestaurant = false
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            List {
                if restaurants.count == 0 {//我在这里打的断点
                    Image("emptydata")
                        .resizable()
                        .scaledToFit()
                } else {
                    ForEach(restaurants) { restaurant in
                        if verticalSizeClass == .compact {
                            BasicTextImageRow(restaurant: restaurant)
                        } else {
                            ZStack(alignment: .leading) {
                                NavigationLink(destination: RestaurantDetailView(restaurant: restaurant)) {
                                    EmptyView()
                                }
                                .opacity(0)//隐藏指示器的写法
                                
                                FullImageRow(restaurant: restaurant)
                            }
                        }
                        
                    }
                    .onDelete(perform: deleteRecord)
                    .listRowSeparator(.hidden)//修饰的是每一行, 所以加在里面
                }
            }
            .listStyle(.plain)//修饰的是整个list, 所以在外面
            .navigationTitle("Food Pin")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        self.showNewRestaurant.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .tint(.primary)
                    }

                }
            }
        }
        .sheet(isPresented: $showNewRestaurant) {
            NewRestaurantView()
        }
        
    }
    
    private func deleteRecord(indexSet: IndexSet) {
        for index in indexSet {
            let itemToDelete = restaurants[index]
            modelContext.delete(itemToDelete)
        }
    }
}

struct FullImageRow: View {
//    @State private var isPresented = false
    @State private var showError = false
    @State private var showOptoins = false
    
    @Bindable var restaurant: Restaurant
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(uiImage: restaurant.image)
                .resizable()
                .scaledToFill()//放大至填充
                .frame(height: 200)//不输入宽度会自动填满
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(restaurant.name)
                        .font(.system(.title2, design: .rounded))
                    
                    Text(restaurant.type)
                        .font(.system(.body, design: .rounded))
                    
                    Text(restaurant.location)
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundStyle(.gray)
                }
                .padding(.leading)
                
                if restaurant.isFavorite {
                    Spacer()
                    
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.red)
                        
                }
            }
        }
        .contextMenu {
            Button {
                self.showError.toggle()
            } label: {
                Text("Reserve a table")
                Image(systemName: "phone")
            }
            
            Button {
                self.restaurant.isFavorite.toggle()
            } label: {
                if restaurant.isFavorite {
                    Text("Remove from favorites")
                } else {
                    Text("Mark as favorite")
                    
                    Image(systemName: "heart.fill")
                        .tint(.red)
                }
            }
            
            Button {
                self.showOptoins.toggle()
            } label: {
                HStack {
                    Text("Share")
                    Image(systemName: "square.and.arrow.up")
                }
            }


        }
        .alert("Not yet avaliable", isPresented: $showError, actions: {
            
        })
        .sheet(isPresented: $showOptoins) {
            let defaultText = "Just checking in at \(restaurant.name) in \(restaurant.location)"
            
            ActivityView(activityItems: [defaultText, restaurant.image])
        }
//        .confirmationDialog("What do you want to do?", isPresented: $isPresented, titleVisibility: .visible, actions: {
//            Button("Reserve a table") {
//                self.showError.toggle()
//            }
//            
//            if restaurant.isFavorite {
//                Button("Remove from favorites") {
//                    self.restaurant.isFavorite.toggle()
//                }
//            } else {
//                Button("Mark as favorite") {
//                    self.restaurant.isFavorite.toggle()
//                }
//            }
//        })
//        .onTapGesture {
//            self.isPresented.toggle()
//        }
    }
}

struct BasicTextImageRow: View {
    @State private var showOptions = false
    @State private var showError = false
    
    @Bindable var restaurant: Restaurant
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(uiImage: restaurant.image)
                .resizable()
                .frame(width: 120, height: 118)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            VStack(alignment: .leading) {
                Text(restaurant.name)
                    .font(.system(.title2, design: .rounded))
                
                Text(restaurant.type)
                    .font(.system(.body, design: .rounded))
                
                Text(restaurant.location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundStyle(.gray)
            }
            
            if restaurant.isFavorite {
                Spacer()
                
                Image(systemName: "heart.fill")
                    .foregroundStyle(.yellow)
            }
        }
        .onTapGesture {
            showOptions.toggle()
        }
        .confirmationDialog("What do you want to do?", isPresented: $showOptions, titleVisibility: .visible) {
            Button("Reserve a table") {
                self.showError.toggle()
            }
            Button("Mark as favorite") {
                self.restaurant.isFavorite.toggle()
            }
        }
        .alert("Not yet available", isPresented: $showError) {
            
        } message: {
            Text("Sorry, this feature is not available yet. Please retry later.")
        }

    }
}

#Preview {
    RestaurantListView()
        .preferredColorScheme(.light)
}
