//
//  ContentView.swift
//  Weathered
//
//  Created by christian on 3/25/23.
//

import SwiftUI

struct ContentView: View {
    @State private var cloudThickness = Cloud.Thickness.regular
    
    var body: some View {
        ZStack {
            CloudsView(thickness: cloudThickness)
        }
        .preferredColorScheme(.dark)
        .background(.blue)
        .safeAreaInset(edge: .bottom) {
            VStack {
                Picker("Thickness", selection: $cloudThickness) {
                    ForEach(Cloud.Thickness.allCases, id: \.self) { thickness in
                        Text(String(describing: thickness).capitalized)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding(5)
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
