//
//  ContentView.swift
//  07
//
//  Created by Turma01-14 on 17/03/26.
//

import SwiftUI
import MapKit


struct ContentView: View {
    @State private var selectedLocation: Location = Locations[0]
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: -22.8494037,
                longitude: -43.356112
            ),
            span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
        )
    )
    @State private var isSheetShowing = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("📍")
                    Picker("Localização", selection: $selectedLocation) {
                        ForEach(Locations, id: \.self) { loc in
                            Text(loc.name).tag(loc)
                        }
                    }
                    .tint(.primary)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(.ultraThinMaterial)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(.white.opacity(0.5), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
                .padding(.top, 10)
                
                Spacer()
                }
                .zIndex(1)
            
            Map(position: $position) {
                ForEach(Locations, id: \.self) { location in
                    Annotation(location.name, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                        VStack {
                            Image(systemName: "mappin.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.red)
                                .background(.white)
                                .clipShape(Circle())
                            
                            Text(location.name)
                                .font(.caption)
                                .padding(4)
                                .background(.white.opacity(0.8))
                                .cornerRadius(5)
                        }
                        .onTapGesture {
                            selectedLocation = location
                            isSheetShowing = true
                        }
                    }
                }
            }
            .mapStyle(.standard)
            .zIndex(0)
        }
        .sheet(isPresented: $isSheetShowing) {
            SheetView(location: selectedLocation)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
        .onChange(of: selectedLocation) { oldValue, newValue in
            withAnimation {
                position = .region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: newValue.latitude, longitude: newValue.longitude),
                        span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
                    )
                )
            }
        }
    }
}

#Preview {
    ContentView()
}
