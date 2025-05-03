//
//  String+Extension.swift
//  UHive
//
//  Created by Lin Thit on 5/2/25.
//

import Foundation
import UIKit

extension String {
    func capitalizedFirstLetter() -> String {
        guard let first = self.first else { return self }
        return String(first).uppercased() + self.dropFirst().lowercased()
    }
    
    func toDisplayDate() -> String? {
        let inputFormatter = ISO8601DateFormatter()
        inputFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = inputFormatter.date(from: self) else { return nil }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MM/dd/yyyy"
        return outputFormatter.string(from: date)
    }
    
    func statusColor() -> UIColor {
        switch self.uppercased() {
        case "PENDING":
            return .orange
        case "UNPAID":
            return .red
        case "PAID":
            return .systemGreen
        default:
            return .gray
        }
    }
    
    func toFormattedDateAndTimeString() -> String? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = isoFormatter.date(from: self) else {
            return nil
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy, HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter.string(from: date)
    }
    
    func toHourMinute() -> String? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = isoFormatter.date(from: self) else {
            return nil
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = .current // Use device's local time zone
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter.string(from: date)
    }
    
    func toTimeString() -> String? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = isoFormatter.date(from: self) else {
            return nil
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a" // e.g., "11:00 PM"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        
        return formatter.string(from: date)
    }

}
