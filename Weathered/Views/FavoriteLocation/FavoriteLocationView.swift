//
//  FavoriteLocation.swift
//  Weathered
//
//  Created by christian on 8/8/23.
//

import SwiftUI

struct FavoriteLocationView: View {
    let location: FavoriteLocation
    
    var body: some View {
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 150, height: 100)
                    .foregroundStyle(.thinMaterial)
                    .shadow(color: .primary.opacity(0.5), radius: 2)
                
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("79°F")
                        Image(systemName: "cloud.rain")
                    }
                    .font(.title2)

                    Text(location.name)
                        .font(.headline)
                }
                .padding()
            }
            .padding(.vertical)
    }
}

#Preview {
    FavoriteLocationView(location: SampleData.favoriteLocation)
}
