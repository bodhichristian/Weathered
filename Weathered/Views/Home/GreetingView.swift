//
//  GreetingView.swift
//  Weathered
//
//  Created by christian on 9/15/23.
//

import SwiftUI

struct GreetingView: View {
    let fontDesign: Font.Design
    // Computed property to calculate the greeting based on the current time
    var greeting: String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: Date())
        
        if 6..<12 ~= hour {
            return """
            Good
            morning
            """
        } else if 12..<18 ~= hour {
            return """
            Good
            afternoon
            """
        } else {
            return """
            Good
            evening
            """
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 0) {
                
                Text(greeting)
                    .font(.system(size: 48))
                    .fontWeight(.semibold)
                    .fontDesign(fontDesign)
                    .foregroundStyle(.white)
                    .padding()
                Spacer()
            }
            .frame(width: geo.size.width)
        }
        
    }
}

#Preview {
    GreetingView(fontDesign: .default)
}
