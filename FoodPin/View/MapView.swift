//
//  MapView.swift
//  FoodPin
//
//  Created by  He on 2025/12/25.
//

import MapKit
import SwiftUI

struct MapView: View {
    var location: String
    
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.510357, longitude: -0.116773), span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))
    
    @State private var position: MapCameraPosition = .automatic
    @State private var markerLocation = CLLocation()
    
    var body: some View {
        //interactionModes表示所有的交互都不允许
        Map(position: $position, interactionModes: []) {
            Marker("Here", coordinate: markerLocation.coordinate)
                .tint(.red)
        }
        .task {//在载入MapView时进行下面的操作
            convertAddress(laction: location)
        }
    }
    
    private func convertAddress(laction: String) {
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let placemarks = placemarks, let location = placemarks[0].location else {
                return
            }
            
            let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.0015, longitudeDelta: 0.0015))
            
            self.position = .region(region)
            self.markerLocation = location
        }
    }
}

#Preview {
    MapView(location: "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong")
}
