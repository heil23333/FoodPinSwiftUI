//
//  NewRestaurantView.swift
//  FoodPin
//
//  Created by  He on 2025/12/25.
//

import SwiftUI
import SwiftData

struct NewRestaurantView: View {
    @State private var showPhotoOptions = false
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Bindable private var restaurantFormViewModel: RestaurantFormViewModel
    
    init() {
        let viewModel = RestaurantFormViewModel()
        viewModel.image = UIImage(named: "newphoto") ?? UIImage()
        restaurantFormViewModel = viewModel
    }
    
    enum PhotoSource: Identifiable {
        case photoLibrary
        case camera
        
        var id: Int {
            hashValue
        }
    }
    
    @State private var photoSource: PhotoSource? = nil
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Image(uiImage: restaurantFormViewModel.image)
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 200)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.bottom)
                        .onTapGesture {
                            self.showPhotoOptions.toggle()
                        }
                    
                    FormTextField(label: "NAME", placeholder: "Fill in the resaurant name", value: $restaurantFormViewModel.name)
                    
                    FormTextField(label: "Type", placeholder: "Fill in the resaurant type", value: $restaurantFormViewModel.type)
                    
                    FormTextField(label: "Address", placeholder: "Fill in the resaurant address", value: $restaurantFormViewModel.location)
                    
                    FormTextField(label: "phone", placeholder: "Fill in the resaurant phone", value: $restaurantFormViewModel.phone)
                    
                    FormTextView(label: "Description", value: $restaurantFormViewModel.summary)
                }
                .padding()
            }
            .navigationTitle("New Restaurant")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .tint(.primary)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        save()
                        dismiss()
                    } label: {
                        Text("Save")
                            .font(.headline)
                            .foregroundStyle(Color("NavigationBarTitle"))
                    }

                    
                }
            }
        }
        .confirmationDialog("Choose your photo source", isPresented: $showPhotoOptions, titleVisibility: .visible) {
            Button("Camera") {
                self.photoSource = .camera
            }
            
            Button("Photo Library") {
                self.photoSource = .photoLibrary
            }
        }
        .fullScreenCover(item: $photoSource) { source in
            switch source {
            case .photoLibrary: ImagePicker(sourceType: .photoLibrary, selectedImage: $restaurantFormViewModel.image)
                    .ignoresSafeArea()
            case .camera: ImagePicker(sourceType: .camera, selectedImage: $restaurantFormViewModel.image).ignoresSafeArea()
            }
        }
    }
    
    private func save() {
        let restaurant = Restaurant(name: restaurantFormViewModel.name, type: restaurantFormViewModel.type, location: restaurantFormViewModel.location, phone: restaurantFormViewModel.phone, description: restaurantFormViewModel.summary, image: restaurantFormViewModel.image)
        
        modelContext.insert(restaurant)
    }
}

#Preview {
    NewRestaurantView()
}
