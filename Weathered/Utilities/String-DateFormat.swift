//
//  String-DateFormat.swift
//  Weathered
//
//  Created by christian on 7/25/23.
//

import Foundation

extension String {
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        if let date = dateFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMM d"
            return outputFormatter.string(from: date)
        }
        return ""
    }
    
    func getTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        if let date = dateFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "h:mm a"
            return outputFormatter.string(from: date)
        }
        return ""
    }
    
    func calculateTimeOfDay() -> Double? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd H:mm"
        
        if let date = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.hour, .minute], from: date)
            
            if let hour = components.hour, let minute = components.minute {
                let totalMinutes = Double(hour * 60 + minute)
                let totalTimeOfDay = totalMinutes / (24.0 * 60.0)
                return totalTimeOfDay
            }
        }
        
        // Return nil if the string is not in the correct format or if the conversion fails
        return nil
    }
}




