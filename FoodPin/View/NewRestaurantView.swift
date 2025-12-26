//
//  NewRestaurantView.swift
//  FoodPin
//
//  Created by  He on 2025/12/25.
//

import SwiftUI

struct NewRestaurantView: View {
    @State var restuarantName = ""
    
    @State private var restaurantImage = UIImage(named: "newphoto")!
    
    @State private var showPhotoOptions = false
    
    @Environment(\.dismiss) var dismiss
    
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
                    Image(uiImage: restaurantImage)
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 200)
                        .background(Color(.systemGray6))
                        .padding(.bottom)
                        .onTapGesture {
                            self.showPhotoOptions.toggle()
                        }
                    
                    FormTextField(label: "NAME", placeholder: "Fill in the resaurant name", value: $restuarantName)
                    
                    FormTextField(label: "Type", placeholder: "Fill in the resaurant type", value: $restuarantName)
                    
                    FormTextField(label: "Address", placeholder: "Fill in the resaurant address", value: $restuarantName)
                    
                    FormTextField(label: "phone", placeholder: "Fill in the resaurant phone", value: $restuarantName)
                    
                    FormTextView(label: "Description", value: .constant(""))
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
                    Text("Save")
                        .foregroundStyle(Color("NavigationBarTitle"))
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
            case .photoLibrary: ImagePicker(sourceType: .photoLibrary, selectedImage: $restaurantImage)
                    .ignoresSafeArea()
            case .camera: ImagePicker(sourceType: .camera, selectedImage: $restaurantImage).ignoresSafeArea()
            }
        }
    }
}

#Preview {
    NewRestaurantView()
}
