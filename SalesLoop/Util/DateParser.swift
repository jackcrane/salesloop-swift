//
//  DateParser.swift
//  SalesLoop
//
//  Created by Jack Crane on 3/13/24.
//

import Foundation

func dateToString(date: Date) -> String {
    // Create a DateFormatter
    let formatter = DateFormatter()
    // Set the date format according to your needs
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    
    // Convert Date to String
    return formatter.string(from: date)
}
