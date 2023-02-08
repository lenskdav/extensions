//
//  Date+Convenience.swift
//  Extensions
//
//  Created by David Lensky on 19/09/2018.
//

import Foundation

// MARK: - Formatting

extension Date {

    private static func from(string: String, format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        let date = dateFormatter.date(from: string)
        return date ?? Date()
    }

    public static func fromDay(string: String) -> Date {
        return self.from(string: string, format: "yyyy-MM-dd")
    }

    public static func from12HTime(string: String) -> Date {
        return self.from(string: string, format: "h:mm a")
    }

    /*static func fromIso8601(string: String) -> Date {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return dateFormatter.date(from: string) ?? Date()
    }*/

    public var day: String {
        return self.date(inFormat: "yyyy-MM-dd")
    }

    public var dayMonth: String {
        return self.date(inFormat: "dd. MMMM")
    }

    public var dayMonthShort: String {
        return self.date(inFormat: "dd. MMM")
    }

    public var dayMonthYear: String {
        return self.date(inFormat: "dd. MMMM yyyy")
    }

    public var dayMonthYearShort: String {
        return self.date(inFormat: "dd. MMM yyyy")
    }

    public var monthDayShort: String {
        return self.date(inFormat: "MMM dd")
    }

    public var fullDate: String {
        return self.date(inFormat: "EEEE, dd. MMMM, yyyy")
    }

    public var fullTimeDate: String {
        return self.date(inFormat: "HH:mm a - MMMM d, yyyy")
    }

    /*var iso8601: String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return dateFormatter.string(from: self)
    }*/

    public var time: String {
        return self.date(inFormat: "HH:mm")
    }

    public var time12: String {
        return self.date(inFormat: "h:mm a")
    }

    public func date(inFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    public func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }

    public var thirtyMinutesBefore: Date? {
        Calendar.current.date(byAdding: DateComponents(minute: -30), to: self)
    }

    public static func +(lhs: Date, rhs: Interval) -> Date? {
        Calendar.current.date(byAdding: rhs.dateComponents, to: lhs)
    }

    public static func +(lhs: Interval, rhs: Date) -> Date? {
        rhs + lhs
    }

    public static func -(lhs: Date, rhs: Interval) -> Date? {
        Calendar.current.date(byAdding: rhs.negativeDateComponents, to: lhs)
    }

    /**
     Returns the difference in seconds.
     */
    public static func -(lhs: Date, rhs: Date) -> Interval {
        Calendar.current.dateComponents([.second], from: rhs, to: lhs)
            .in(.seconds())
    }

}

public extension Interval {

    var readableDifference: String {
        readableDifference(compact: false)
    }

    var compactReadableDifference: String {
        readableDifference(compact: true)
    }

    private func readableDifference(compact: Bool) -> String {
        let minutes = self.to(.minutes()).value
        switch minutes {
        case Int.min...0: return compact ? "<1 min ago" : "less than 1 min ago"
        case 1..<60: return minutes.string + " min ago"
        case 60...Int.max: break
        default: fatalError("Should not happen")
        }

        let hours = self.to(.hours()).value
        switch hours {
        case Int.min..<24: return hours.string + " hours ago"
        case 24...Int.max: break
        default: fatalError("Should not happen")
        }

        let days = self.to(.days()).value
        switch days {
        case Int.min..<365: return days.string + " days ago"
        case 365...Int.max: return compact ? ">1 year ago" : "more than 1 year ago"
        default: fatalError("Should not happen")
        }
    }

}

// MARK: - Generating

extension Date {

    public var nextDay: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }

    public var midnight: Date {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(secondsFromGMT: 0)!
        return cal.startOfDay(for: self)
    }

    public static func between(start: Date, end: Date) -> [Date] {
        var results: [Date] = []
        var date = start

        while date <= end {
            results.append(date)
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        }

        return results
    }

}

// MARK: - Time

extension String {

    public var minutes: Int {
        let comp = self.components(separatedBy: ":")
        guard
            comp.count == 2,
            let first = Int(comp[0]),
            let second = Int(comp[1])
            else { return -1 }
        return first * 60 + second
    }

}

extension Int {

    public var minutesToString: String {
        if self <= 0 { return "" }

        return String(format: "%.2d", self / 60) + ":" + String(format: "%.2d", self % 60)
    }

    public var minutesTo12HString: String {
        if self <= 0 { return "" }

        var hours: Int = self / 60
        var isAM = true

        if (12...23).contains(hours) { isAM = false }
        if hours == 0 { hours = 12 }
        else { hours = hours % 12 }

        return String(format: "%.2d", self / 60) + ":" + String(format: "%.2d", self % 60) + (isAM ? " AM" : " PM")
    }

}
