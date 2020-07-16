//
//  String+Date.swift
//  news
//
//  Created by Admin on 7/6/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

extension String {
    func toHM() -> String {
        let isoDate = self

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:isoDate)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)
        let finalDate = calendar.date(from:components)

        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: finalDate!)
    }
    
    func toFullDate() -> String {
        let isoDate = self

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:isoDate)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let finalDate = calendar.date(from:components)

        dateFormatter.dateFormat = "MMMM dd, YYYY - HH:mm"
        
        return dateFormatter.string(from: finalDate!)
    }
}
