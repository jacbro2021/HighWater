//
//  ContentView.swift
//  Highwaters
//
//  Created by jacob brown on 7/9/23.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View{
    @ObservedObject var _vm: ContentViewModel

       var body: some View {
           ZStack {
               Map(coordinateRegion: $_vm.region, showsUserLocation: true)
                   .ignoresSafeArea()
               
               Map(coordinateRegion: $_vm.region,
                   showsUserLocation: true,
                   annotationItems: $_vm.floodLocations,
                   annotationContent: { $location in
                   MapMarker(coordinate: location.Coordinates, tint: .cyan)
               })
               .ignoresSafeArea()
               
               VStack {
                   Spacer()
                   
                   Button {
                       _vm.addFloodLocation()
                   } label: {
                       Image(systemName: "plus")
                   }   .background(.gray)
                       .opacity(0.8)
                       .foregroundColor(.white)
                       .cornerRadius(5)
                       .font(.largeTitle)
               }
           }
       }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(_vm: ContentViewModel())
    }
}
