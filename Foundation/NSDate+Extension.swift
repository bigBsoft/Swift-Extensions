//
//  NSDate+Extension.swift
//
//  Created by Bishal Ghimire on 6/6/16.
//  Copyright © 2016 Bishal Ghimire. All rights reserved.
//
// https://github.com/melvitax/AFDateHelper/blob/master/AFDateHelper/AFDateExtension.swift

import Foundation

public enum ISO8601Format: String {
  
  case Year = "yyyy" // 1997
  case YearMonth = "yyyy-MM" // 1997-07
  case Date = "yyyy-MM-dd" // 1997-07-16
  case DateMonthName = "MMM dd, yyyy" 
  case DateTime = "yyyy-MM-dd'T'HH:mmZ" // 1997-07-16T19:20+01:00
  case DateTimeSec = "yyyy-MM-dd'T'HH:mm:ssZ" // 1997-07-16T19:20:30+01:00
  case DateTimeMilliSec = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // 1997-07-16T19:20:30.45+01:00
  
  init(dateString:String) {
    switch dateString.characters.count {
    case 4:
      self = ISO8601Format(rawValue: ISO8601Format.Year.rawValue)!
    case 7:
      self = ISO8601Format(rawValue: ISO8601Format.YearMonth.rawValue)!
    case 10:
      self = ISO8601Format(rawValue: ISO8601Format.Date.rawValue)!
    case 22:
      self = ISO8601Format(rawValue: ISO8601Format.DateTime.rawValue)!
    case 25:
      self = ISO8601Format(rawValue: ISO8601Format.DateTimeSec.rawValue)!
    default:// 28:
      self = ISO8601Format(rawValue: ISO8601Format.DateTimeMilliSec.rawValue)!
    }
  }
  
}

// DotNet: "/Date(1268123281843)/"
let DefaultFormat = "EEE MMM dd HH:mm:ss Z yyyy"
let RSSFormat = "EEE, d MMM yyyy HH:mm:ss ZZZ" // "Fri, 09 Sep 2011 15:26:08 +0200"
let AltRSSFormat = "d MMM yyyy HH:mm:ss ZZZ" // "09 Sep 2011 15:26:08 +0200"
let LongDateFormat = "EEEE, MMMM d yyyy"

public enum DateFormat {
  case iso8601(ISO8601Format?)
  case dotNet
  case rss
  case altRSS
  case longDate
  case custom(String)
}

public enum TimeZone {
  case local
  case utc
}

/*
 TODO : Swift 3.0 issue 
// http://stackoverflow.com/a/29654806

//Tell the system that NSDates can be compared with ==, >, >=, <, and <= operators
extension Foundation.Date: Comparable { }

//-------------------------------------------------------------
//Define the global operators for the
//Equatable and Comparable protocols for comparing NSDates

public func ==(lhs: Foundation.Date, rhs: Foundation.Date) -> Bool {
  return lhs.timeIntervalSince1970 == rhs.timeIntervalSince1970
}

public func <(lhs: Foundation.Date, rhs: Foundation.Date) -> Bool {
  return lhs.timeIntervalSince1970 < rhs.timeIntervalSince1970
}

public func >(lhs: Foundation.Date, rhs: Foundation.Date) -> Bool {
  return lhs.timeIntervalSince1970 > rhs.timeIntervalSince1970
}

public func <=(lhs: Foundation.Date, rhs: Foundation.Date) -> Bool {
  return lhs.timeIntervalSince1970 <= rhs.timeIntervalSince1970
}

public func >=(lhs: Foundation.Date, rhs: Foundation.Date) -> Bool {
  return lhs.timeIntervalSince1970 >= rhs.timeIntervalSince1970
}
//-------------------------------------------------------------
 */

public extension Foundation.Date {
  /**
   This adds a new method dateAtTime to NSDate.
   
   It returns a new date at the specified hours and minutes of the receiver
   
   :param: hours: The hours value
   :param: minutes: The new minutes
   
   :returns: a new NSDate with the same year/month/day as the receiver, but with the specified hours/minutes values
   */
  func dateAtTime(_ hours: Int, minutes: Int) -> Foundation.Date {
    let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    
    //get the month/day/year componentsfor today's date.
    
    var date_components = (calendar as NSCalendar).components([NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day], from: self)
    //Create an NSDate for 8:00 AM today.
    date_components.hour = hours
    date_components.minute = minutes
    date_components.second = 0
    
    let newDate = calendar.date(from: date_components)!
    return newDate
  }
}

public extension Foundation.Date {
  
  /// Today's midnight date
  /// eg - For 16th Sep 
  /// @returns 2016-09-16 18:15:00 +0000
  static func lastMindNight(_ aDate: Foundation.Date = Foundation.Date()) -> Foundation.Date {
    let components = (Calendar.current as NSCalendar).components([NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day], from: aDate)
    let lastMidnight = Calendar.current.date(from: components)
    return lastMidnight!
  }
  
  /// Tomorrow's morning midnight date
  /// eg - For 16th Sep
  /// @returns 2016-09-17 18:15:00 +0000
  static func nextMidNight(_ aDate: Foundation.Date = Foundation.Date()) -> Foundation.Date {
    let components = (Calendar.current as NSCalendar).components([NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.day], from: aDate)
    var oneDay = DateComponents()
    oneDay.day = 1
    let lastMidnight = Calendar.current.date(from: components)
    let nextMidNight = (Calendar.current as NSCalendar).date(byAdding: oneDay, to: lastMidnight!, options: NSCalendar.Options.wrapComponents)
    return nextMidNight!
  }

}


public extension Foundation.Date {
  
  // MARK: Intervals In Seconds
  fileprivate static func minuteInSeconds() -> Double { return 60 }
  fileprivate static func hourInSeconds() -> Double { return 3600 }
  fileprivate static func dayInSeconds() -> Double { return 86400 }
  fileprivate static func weekInSeconds() -> Double { return 604800 }
  fileprivate static func yearInSeconds() -> Double { return 31556926 }
  
  // MARK: Components
  fileprivate static func componentFlags() -> NSCalendar.Unit {
    return [NSCalendar.Unit.year,
            NSCalendar.Unit.month,
            NSCalendar.Unit.day,
            NSCalendar.Unit.weekOfYear,
            NSCalendar.Unit.hour,
            NSCalendar.Unit.minute,
            NSCalendar.Unit.second,
            NSCalendar.Unit.weekday,
            NSCalendar.Unit.weekdayOrdinal,
            NSCalendar.Unit.weekOfYear]
  }
  
  fileprivate static func components(_ fromDate: Foundation.Date) -> DateComponents! {
    return (Calendar.current as NSCalendar).components(Foundation.Date.componentFlags(), from: fromDate)
  }
  
  fileprivate func components() -> DateComponents  {
    return Foundation.Date.components(self)!
  }
  
  // MARK: Date From String
  
  /**
   Creates a date based on a string and a formatter type. You can ise .ISO8601(nil) to for deducting an ISO8601Format automatically.
   
   - Parameter fromString Date string i.e. "16 July 1972 6:12:00".
   - Parameter format The Date Formatter type can be .ISO8601(ISO8601Format?), .DotNet, .RSS, .AltRSS or Custom(String).
   - Parameter timeZone: The time zone to interpret fromString can be .Local, .UTC applies to Custom format only
   
   - Returns A new date
   */
  
  init(fromString string: String, format:DateFormat, timeZone: TimeZone = .local) {
    if string.isEmpty {
      self.init()
      return
    }
    
    let string = string as NSString
    
    let zone: Foundation.TimeZone
    
    switch timeZone {
    case .local:
      zone = Foundation.TimeZone.autoupdatingCurrent
    case .utc:
      zone = Foundation.TimeZone(secondsFromGMT: 0)!
    }
    
    switch format {
      
    case .dotNet:
      let startIndex = string.range(of: "(").location + 1
      let endIndex = string.range(of: ")").location
      let range = NSRange(location: startIndex, length: endIndex-startIndex)
      let milliseconds = (string.substring(with: range) as NSString).longLongValue
      let interval = TimeInterval(milliseconds / 1000)
      self.init(timeIntervalSince1970: interval)
      
    case .iso8601(let isoFormat):
      let dateFormat = (isoFormat != nil) ? isoFormat! : ISO8601Format(dateString: string as String)
      let formatter = Foundation.Date.formatter(dateFormat.rawValue)
      formatter.locale = Locale(identifier: "en_US_POSIX")
      formatter.timeZone = Foundation.TimeZone.autoupdatingCurrent
      formatter.dateFormat = dateFormat.rawValue
      if let date = formatter.date(from: string as String) {
        self.init(timeInterval:0, since:date)
      } else {
        self.init()
      }
      
    case .rss:
      var s  = String()
      if string.hasSuffix("Z") {
        s = s.substring(to: s.characters.endIndex) + "GMT"
        // s = subS + "GMT"
      }
      let formatter = Foundation.Date.formatter(RSSFormat)
      if let date = formatter.date(from: string as String) {
        self.init(timeInterval:0, since:date)
      } else {
        self.init()
      }
      
    case .altRSS:
      var s  = String()
      if string.hasSuffix("Z") {
        s = s.substring(to: s.characters.endIndex) + "GMT"
      }
      let formatter = Foundation.Date.formatter(AltRSSFormat)
      if let date = formatter.date(from: string as String) {
        self.init(timeInterval:0, since:date)
      } else {
        self.init()
      }
      
    case .longDate:
      var s  = String()
      if string.hasSuffix("Z") {
        s = s.substring(to: s.characters.endIndex) + "GMT"
      }
      let formatter = Foundation.Date.formatter(LongDateFormat)
      if let date = formatter.date(from: string as String) {
        self.init(timeInterval:0, since:date)
      } else {
        self.init()
      }
      
    case .custom(let dateFormat):
      let formatter = Foundation.Date.formatter(dateFormat, timeZone: zone)
      if let date = formatter.date(from: string as String) {
        self.init(timeInterval:0, since:date)
      } else {
        self.init()
      }
    }
  }
  
  // MARK: Comparing Dates
  
  /**
   Returns true if dates are equal while ignoring time.
   - Parameter date: The Date to compare.
   */
  func isEqualToDateIgnoringTime(_ date: Foundation.Date) -> Bool {
    let comp1 = Foundation.Date.components(self)
    let comp2 = Foundation.Date.components(date)
    return ((comp1!.year == comp2!.year) && (comp1!.month == comp2!.month) && (comp1!.day == comp2!.day))
  }
  
  /**
   Returns Returns true if date is today.
   */
  func isToday() -> Bool {
    return self.isEqualToDateIgnoringTime(Foundation.Date())
  }
  
  /**
   Returns true if date is tomorrow.
   */
  func isTomorrow() -> Bool {
    return self.isEqualToDateIgnoringTime(Foundation.Date().dateByAddingDays(1))
  }
  
  /**
   Returns true if date is yesterday.
   */
  func isYesterday() -> Bool {
    return self.isEqualToDateIgnoringTime(Foundation.Date().dateBySubtractingDays(1))
  }
  
  /**
   Returns true if date are in the same week.
   
   - Parameter date: The date to compare.
   */
  func isSameWeekAsDate(_ date: Foundation.Date) -> Bool {
    let comp1 = Foundation.Date.components(self)
    let comp2 = Foundation.Date.components(date)
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if comp1?.weekOfYear != comp2?.weekOfYear {
      return false
    }
    // Must have a time interval under 1 week
    return abs(self.timeIntervalSince(date)) < Foundation.Date.weekInSeconds()
  }
  
  /**
   Returns true if date is this week.
   */
  func isThisWeek() -> Bool {
    return self.isSameWeekAsDate(Foundation.Date())
  }
  
  /**
   Returns true if date is next week.
   */
  func isNextWeek() -> Bool {
    let interval: TimeInterval = Foundation.Date().timeIntervalSinceReferenceDate + Foundation.Date.weekInSeconds()
    let date = Foundation.Date(timeIntervalSinceReferenceDate: interval)
    return self.isSameWeekAsDate(date)
  }
  
  /**
   Returns true if date is last week.
   */
  func isLastWeek() -> Bool {
    let interval: TimeInterval = Foundation.Date().timeIntervalSinceReferenceDate - Foundation.Date.weekInSeconds()
    let date = Foundation.Date(timeIntervalSinceReferenceDate: interval)
    return self.isSameWeekAsDate(date)
  }
  
  /**
   Returns true if date is within last 7 days
   */
  func isWithinLast7Days() -> Bool {
    let interval: TimeInterval = Foundation.Date().timeIntervalSinceReferenceDate - Foundation.Date.weekInSeconds()
    let date = Foundation.Date(timeIntervalSinceReferenceDate: interval)
    return abs(self.timeIntervalSince(date)) < Foundation.Date.weekInSeconds()
  }
  
  /**
   Returns true if dates are in the same year.
   - Parameter date: The date to compare.
   */
  func isSameYearAsDate(_ date: Foundation.Date) -> Bool {
    let comp1 = Foundation.Date.components(self)
    let comp2 = Foundation.Date.components(date)
    return comp1!.year == comp2!.year
  }
  
  /**
   Returns true if dates are in the same month
   - Parameter date: The date to compare
   */
  func isSameMonthAsDate(_ date: Foundation.Date) -> Bool {
    let comp1 = Foundation.Date.components(self)
    let comp2 = Foundation.Date.components(date)
    
    return comp1!.year == comp2!.year && comp1!.month == comp2!.month
  }
  
  /**
   Returns true if date is this year.
   */
  func isThisYear() -> Bool {
    return self.isSameYearAsDate(Foundation.Date())
  }
  
  /**
   Returns true if date is next year.
   */
  func isNextYear() -> Bool {
    let comp1 = Foundation.Date.components(self)
    let comp2 = Foundation.Date.components(Foundation.Date())
    return (comp1!.year! == comp2!.year! + 1)
  }
  
  /**
   Returns true if date is last year.
   */
  func isLastYear() -> Bool {
    let comp1 = Foundation.Date.components(self)
    let comp2 = Foundation.Date.components(Foundation.Date())
    return (comp1!.year! == comp2!.year! - 1)
  }
  
  /**
   Returns true if date is earlier than date.
   - Parameter date: The date to compare.
   */
  func isEarlierThanDate(_ date: Foundation.Date) -> Bool {
    return (self as NSDate).earlierDate(date) == self
  }
  
  /**
   Returns true if date is later than date.
   - Parameter date: The date to compare.
   */
  func isLaterThanDate(_ date: Foundation.Date) -> Bool {
    return (self as NSDate).laterDate(date) == self
  }
  
  /**
   Returns true if date is in future.
   */
  func isInFuture() -> Bool {
    return self.isLaterThanDate(Foundation.Date())
  }
  
  /**
   Returns true if date is in past.
   */
  func isInPast() -> Bool {
    return self.isEarlierThanDate(Foundation.Date())
  }
  
  // MARK: Adjusting Dates
  
  /**
   Creates a new date by a adding months.
   - Parameter days: The number of months to add.
   - Returns A new date object.
   */
  func dateByAddingMonths(_ months: Int) -> Foundation.Date
  {
    var dateComp = DateComponents()
    dateComp.month = months
    return (Calendar.current as NSCalendar).date(byAdding: dateComp, to: self, options: NSCalendar.Options(rawValue: 0))!
  }
  
  /**
   Creates a new date by a substracting months.
   - Parameter days: The number of months to substract.
   - Returns A new date object.
   */
  func dateBySubtractingMonths(_ months: Int) -> Foundation.Date {
    var dateComp = DateComponents()
    dateComp.month = (months * -1)
    return (Calendar.current as NSCalendar).date(byAdding: dateComp, to: self, options: NSCalendar.Options(rawValue: 0))!
  }
  
  /**
   Creates a new date by a adding weeks.
   - Parameter days: The number of weeks to add.
   - Returns A new date object.
   */
  func dateByAddingWeeks(_ weeks: Int) -> Foundation.Date {
    var dateComp = DateComponents()
    dateComp.day = 7 * weeks
    return (Calendar.current as NSCalendar).date(byAdding: dateComp, to: self, options: NSCalendar.Options(rawValue: 0))!
  }
  
  /**
   Creates a new date by a substracting weeks.
   - Parameter days: The number of weeks to substract.
   - Returns A new date object.
   */
  func dateBySubtractingWeeks(_ weeks: Int) -> Foundation.Date {
    var dateComp = DateComponents()
    dateComp.day = ((7 * weeks) * -1)
    return (Calendar.current as NSCalendar).date(byAdding: dateComp, to: self, options: NSCalendar.Options(rawValue: 0))!
  }
  
  /**
   Creates a new date by a adding days.
   - Parameter days: The number of days to add.
   - Returns A new date object.
   */
  func dateByAddingDays(_ days: Int) -> Foundation.Date {
    var dateComp = DateComponents()
    dateComp.day = days
    return (Calendar.current as NSCalendar).date(byAdding: dateComp, to: self, options: NSCalendar.Options(rawValue: 0))!
  }
  
  /**
   Creates a new date by a substracting days.
   - Parameter days: The number of days to substract.
   - Returns A new date object.
   */
  func dateBySubtractingDays(_ days: Int) -> Foundation.Date {
    var dateComp = DateComponents()
    dateComp.day = (days * -1)
    return (Calendar.current as NSCalendar).date(byAdding: dateComp, to: self, options: NSCalendar.Options(rawValue: 0))!
  }
  
  /**
   Creates a new date by a adding hours.
   - Parameter days: The number of hours to add.
   - Returns A new date object.
   */
  func dateByAddingHours(_ hours: Int) -> Foundation.Date {
    var dateComp = DateComponents()
    dateComp.hour = hours
    return (Calendar.current as NSCalendar).date(byAdding: dateComp, to: self, options: NSCalendar.Options(rawValue: 0))!
  }
  
  /**
   Creates a new date by substracting hours.
   - Parameter days: The number of hours to substract.
   - Returns A new date object.
   */
  func dateBySubtractingHours(_ hours: Int) -> Foundation.Date {
    var dateComp = DateComponents()
    dateComp.hour = (hours * -1)
    return (Calendar.current as NSCalendar).date(byAdding: dateComp, to: self, options: NSCalendar.Options(rawValue: 0))!
  }
  
  /**
   Creates a new date by adding minutes.
   - Parameter days: The number of minutes to add.
   - Returns A new date object.
   */
  func dateByAddingMinutes(_ minutes: Int) -> Foundation.Date {
    var dateComp = DateComponents()
    dateComp.minute = minutes
    return (Calendar.current as NSCalendar).date(byAdding: dateComp, to: self, options: NSCalendar.Options(rawValue: 0))!
  }
  
  /**
   Creates a new date by substracting minutes.
   - Parameter days: The number of minutes to add.
   - Returns A new date object.
   */
  func dateBySubtractingMinutes(_ minutes: Int) -> Foundation.Date {
    var dateComp = DateComponents()
    dateComp.minute = (minutes * -1)
    return (Calendar.current as NSCalendar).date(byAdding: dateComp, to: self, options: NSCalendar.Options(rawValue: 0))!
  }
  
  /**
   Creates a new date by adding seconds.
   - Parameter seconds: The number of seconds to add.
   - Returns A new date object.
   */
  func dateByAddingSeconds(_ seconds: Int) -> Foundation.Date {
    var dateComp = DateComponents()
    dateComp.second = seconds
    return (Calendar.current as NSCalendar).date(byAdding: dateComp, to: self, options: NSCalendar.Options(rawValue: 0))!
  }
  
  /**
   Creates a new date by substracting seconds.
   - Parameter days: The number of seconds to substract.
   - Returns A new date object.
   */
  func dateBySubtractingSeconds(_ seconds: Int) -> Foundation.Date {
    var dateComp = DateComponents()
    dateComp.second = (seconds * -1)
    return (Calendar.current as NSCalendar).date(byAdding: dateComp, to: self, options: NSCalendar.Options(rawValue: 0))!
  }
  
  /**
   Creates a new date from the start of the day.
   - Returns A new date object.
   */
  func dateAtStartOfDay() -> Foundation.Date {
    var components = self.components()
    components.hour = 0
    components.minute = 0
    components.second = 0
    return Calendar.current.date(from: components)!
  }
  
  /**
   Creates a new date from the end of the day.
   - Returns A new date object.
   */
  func dateAtEndOfDay() -> Foundation.Date {
    var components = self.components()
    components.hour = 23
    components.minute = 59
    components.second = 59
    return Calendar.current.date(from: components)!
  }
  
  /**
   Creates a new date from the start of the week.
   - Returns A new date object.
   */
  func dateAtStartOfWeek() -> Foundation.Date {
    let flags :NSCalendar.Unit = [NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.weekOfYear, NSCalendar.Unit.weekday]
    var components = (Calendar.current as NSCalendar).components(flags, from: self)
    components.weekday = Calendar.current.firstWeekday
    components.hour = 0
    components.minute = 0
    components.second = 0
    return Calendar.current.date(from: components)!
  }
  
  /**
   Creates a new date from the end of the week.
   - Returns A new date object.
   */
  func dateAtEndOfWeek() -> Foundation.Date {
    let flags :NSCalendar.Unit = [NSCalendar.Unit.year, NSCalendar.Unit.month, NSCalendar.Unit.weekOfYear, NSCalendar.Unit.weekday]
    var components = (Calendar.current as NSCalendar).components(flags, from: self)
    components.weekday = Calendar.current.firstWeekday + 6
    components.hour = 0
    components.minute = 0
    components.second = 0
    return Calendar.current.date(from: components)!
  }
  
  /**
   Creates a new date from the first day of the month
   - Returns A new date object.
   */
  func dateAtTheStartOfMonth() -> Foundation.Date {
    //Create the date components
    var components = self.components()
    components.day = 1
    //Builds the first day of the month
    let firstDayOfMonthDate :Foundation.Date = Calendar.current.date(from: components)!
    
    return firstDayOfMonthDate
    
  }
  
  /**
   Creates a new date from the last day of the month
   - Returns A new date object.
   */
  func dateAtTheEndOfMonth() -> Foundation.Date {
    //Create the date components
    var components = self.components()
    //Set the last day of this month
    components.month = components.month! + 1
    components.day = 0
    
    //Builds the first day of the month
    let lastDayOfMonth :Foundation.Date = Calendar.current.date(from: components)!
    
    return lastDayOfMonth
  }
  
  /**
   Creates a new date based on tomorrow.
   - Returns A new date object.
   */
  static func tomorrow() -> Foundation.Date {
    return Foundation.Date().dateByAddingDays(1).dateAtStartOfDay()
  }
  
  /**
   Creates a new date based on yesterdat.
   - Returns A new date object.
   */
  static func yesterday() -> Foundation.Date {
    return Foundation.Date().dateBySubtractingDays(1).dateAtStartOfDay()
  }
  
  /**
   Return a new NSDate object with the new hour, minute and seconds values
   
   :returns: NSDate
   */
  func setTimeOfDate(_ hour: Int, minute: Int, second: Int) -> Foundation.Date {
    var components = self.components()
    components.hour = hour
    components.minute = minute
    components.second = second
    return Calendar.current.date(from: components)!
  }
  
  
  // MARK: Retrieving Intervals
  
  /**
   Gets the number of seconds after a date.
   - Parameter date: the date to compare.
   - Returns The number of seconds
   */
  func secondsAfterDate(_ date: Foundation.Date) -> Int {
    return Int(self.timeIntervalSince(date))
  }
  
  /**
   Gets the number of seconds before a date.
   - Parameter date: The date to compare.
   - Returns The number of seconds
   */
  func secondsBeforeDate(_ date: Foundation.Date) -> Int {
    return Int(date.timeIntervalSince(self))
  }
  
  /**
   Gets the number of minutes after a date.
   - Parameter date: the date to compare.
   - Returns The number of minutes
   */
  func minutesAfterDate(_ date: Foundation.Date) -> Int {
    let interval = self.timeIntervalSince(date)
    return Int(interval / Foundation.Date.minuteInSeconds())
  }
  
  /**
   Gets the number of minutes before a date.
   - Parameter date: The date to compare.
   - Returns The number of minutes
   */
  func minutesBeforeDate(_ date: Foundation.Date) -> Int {
    let interval = date.timeIntervalSince(self)
    return Int(interval / Foundation.Date.minuteInSeconds())
  }
  
  /**
   Gets the number of hours after a date.
   - Parameter date: The date to compare.
   - Returns The number of hours
   */
  func hoursAfterDate(_ date: Foundation.Date) -> Int {
    let interval = self.timeIntervalSince(date)
    return Int(interval / Foundation.Date.hourInSeconds())
  }
  
  /**
   Gets the number of hours before a date.
   - Parameter date: The date to compare.
   - Returns The number of hours
   */
  func hoursBeforeDate(_ date: Foundation.Date) -> Int {
    let interval = date.timeIntervalSince(self)
    return Int(interval / Foundation.Date.hourInSeconds())
  }
  
  /**
   Gets the number of days after a date.
   - Parameter date: The date to compare.
   - Returns The number of days
   */
  func daysAfterDate(_ date: Foundation.Date) -> Int {
    let interval = self.timeIntervalSince(date)
    return Int(interval / Foundation.Date.dayInSeconds())
  }
  
  /**
   Gets the number of days before a date.
   - Parameter date: The date to compare.
   - Returns The number of days
   */
  func daysBeforeDate(_ date: Foundation.Date) -> Int {
    let interval = date.timeIntervalSince(self)
    return Int(interval / Foundation.Date.dayInSeconds())
  }
  
  
  // MARK: Decomposing Dates
  
  /**
   Returns the nearest hour.
   */
  func nearestHour () -> Int {
    let halfHour = Foundation.Date.minuteInSeconds() * 30
    var interval = self.timeIntervalSinceReferenceDate
    if  self.seconds() < 30 {
      interval -= halfHour
    } else {
      interval += halfHour
    }
    let date = Foundation.Date(timeIntervalSinceReferenceDate: interval)
    return date.hour()
  }
  /**
   Returns the year component.
   */
  func year () -> Int { return self.components().year!  }
  /**
   Returns the month component.
   */
  func month () -> Int { return self.components().month! }
  /**
   Returns the week of year component.
   */
  func week () -> Int { return self.components().weekOfYear! }
  /**
   Returns the day component.
   */
  func day () -> Int { return self.components().day! }
  /**
   Returns the hour component.
   */
  func hour () -> Int { return self.components().hour! }
  /**
   Returns the minute component.
   */
  func minute () -> Int { return self.components().minute! }
  /**
   Returns the seconds component.
   */
  func seconds () -> Int { return self.components().second! }
  /**
   Returns the weekday component.
   */
  func weekday () -> Int { return self.components().weekday! }
  /**
   Returns the nth days component. e.g. 2nd Tuesday of the month is 2.
   */
  func nthWeekday () -> Int { return self.components().weekdayOrdinal! }
  /**
   Returns the days of the month.
   */
  func monthDays () -> Int { return (Calendar.current as NSCalendar).range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: self).length }
  /**
   Returns the first day of the week.
   */
  func firstDayOfWeek () -> Int {
    let distanceToStartOfWeek = Foundation.Date.dayInSeconds() * Double(self.components().weekday! - 1)
    let interval: TimeInterval = self.timeIntervalSinceReferenceDate - distanceToStartOfWeek
    return Foundation.Date(timeIntervalSinceReferenceDate: interval).day()
  }
  
  /**
   Returns the last day of the week.
   */
  func lastDayOfWeek () -> Int {
    let distanceToStartOfWeek = Foundation.Date.dayInSeconds() * Double(self.components().weekday! - 1)
    let distanceToEndOfWeek = Foundation.Date.dayInSeconds() * Double(7)
    let interval: TimeInterval = self.timeIntervalSinceReferenceDate - distanceToStartOfWeek + distanceToEndOfWeek
    return Foundation.Date(timeIntervalSinceReferenceDate: interval).day()
  }
  /**
   Returns true if a weekday.
   */
  func isWeekday() -> Bool {
    return !self.isWeekend()
  }
  /**
   Returns true if weekend.
   */
  func isWeekend() -> Bool {
    let range = (Calendar.current as NSCalendar).maximumRange(of: NSCalendar.Unit.weekday)
    return (self.weekday() == range.location || self.weekday() == range.length)
  }
  
  // MARK: To String
  
  /**
   A string representation using short date and time style.
   */
  func toString() -> String {
    return self.toString(.short, timeStyle: .short, doesRelativeDateFormatting: false)
  }
  
  /**
   A string representation based on a format.
   - Parameter format: The format of date can be .ISO8601(.ISO8601Format?), .DotNet, .RSS, .AltRSS or Custom(FormatString).
   - Parameter timeZone: The time zone to interpret the date can be .Local, .UTC applies to Custom format only
   - Returns The date string representation
   */
  func toString(_ format: DateFormat, timeZone: TimeZone = .local) -> String {
    var dateFormat: String
    let zone: Foundation.TimeZone
    switch format {
    case .dotNet:
      let offset = NSTimeZone.default.secondsFromGMT() / 3600
      let nowMillis = 1000 * self.timeIntervalSince1970
      return  "/Date(\(nowMillis)\(offset))/"
    case .iso8601(let isoFormat):
      dateFormat = (isoFormat != nil) ? isoFormat!.rawValue : ISO8601Format.DateTimeMilliSec.rawValue
      zone = Foundation.TimeZone.autoupdatingCurrent
    case .rss:
      dateFormat = RSSFormat
      zone = Foundation.TimeZone.autoupdatingCurrent
    case .altRSS:
      dateFormat = AltRSSFormat
      zone = Foundation.TimeZone.autoupdatingCurrent
    case .longDate:
      dateFormat = LongDateFormat
      zone = Foundation.TimeZone.autoupdatingCurrent

    case .custom(let string):
      switch timeZone {
      case .local:
        zone = Foundation.TimeZone.autoupdatingCurrent
      case .utc:
        zone = Foundation.TimeZone(secondsFromGMT: 0)!
      }
      dateFormat = string
    }
    
    let formatter = Foundation.Date.formatter(dateFormat, timeZone: zone)
    return formatter.string(from: self)
  }
  
  /**
   A string representation based on custom style.
   
   - Parameter dateStyle: The date style to use.
   - Parameter timeStyle: The time style to use.
   - Parameter doesRelativeDateFormatting: Enables relative date formatting.
   - Parameter timeZone: The time zone to use.
   - Parameter locale: The locale to use.
   - Returns A string representation of the date.
   */
  func toString(_ dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style, doesRelativeDateFormatting: Bool = false, timeZone: Foundation.TimeZone = Foundation.TimeZone.autoupdatingCurrent, locale: Locale = Locale.current) -> String {
    let formatter = Foundation.Date.formatter(dateStyle, timeStyle: timeStyle, doesRelativeDateFormatting: doesRelativeDateFormatting, timeZone: timeZone, locale: locale)
    return formatter.string(from: self)
  }
  
  /**
   A string representation based on a relative time language. i.e. just now, 1 minute ago etc..
   */
  func relativeTimeToString() -> String {
    let time = self.timeIntervalSince1970
    let now = Foundation.Date().timeIntervalSince1970
    
    let timeIsInPast = now - time > 0
    
    let seconds = abs(now - time)
    let minutes = round(seconds/60)
    let hours = round(minutes/60)
    let days = round(hours/24)
    
    func describe(_ time: String) -> String {
      if timeIsInPast { return "\(time) ago" }
      else { return "in \(time)" }
    }
    
    if seconds < 10 {
      return NSLocalizedString("just now", comment: "Show the relative time from a date")
    } else if seconds < 60 {
      let relativeTime = NSLocalizedString(describe("%.f seconds"), comment: "Show the relative time from a date")
      return String(format: relativeTime, seconds)
    }
    
    if minutes < 60 {
      if minutes == 1 {
        return NSLocalizedString(describe("1 minute"), comment: "Show the relative time from a date")
      } else {
        let relativeTime = NSLocalizedString(describe("%.f minutes"), comment: "Show the relative time from a date")
        return String(format: relativeTime, minutes)
      }
    }
    
    if hours < 24 {
      if hours == 1 {
        return NSLocalizedString(describe("1 hour"), comment: "Show the relative time from a date")
      } else {
        let relativeTime = NSLocalizedString(describe("%.f hours"), comment: "Show the relative time from a date")
        return String(format: relativeTime, hours)
      }
    }
    
    if days < 7 {
      if days == 1 {
        return NSLocalizedString(describe("1 day"), comment: "Show the relative time from a date")
      } else {
        let relativeTime = NSLocalizedString(describe("%.f days"), comment: "Show the relative time from a date")
        return String(format: relativeTime, days)
      }
    }
    
    return self.toString()
  }
  
  /**
   A string representation of the weekday.
   */
  func weekdayToString() -> String {
    let formatter = Foundation.Date.formatter()
    return formatter.weekdaySymbols[self.weekday()-1] as String
  }
  
  /**
   A short string representation of the weekday.
   */
  func shortWeekdayToString() -> String {
    let formatter = Foundation.Date.formatter()
    return formatter.shortWeekdaySymbols[self.weekday()-1] as String
  }
  
  /**
   A very short string representation of the weekday.
   
   - Returns String
   */
  func veryShortWeekdayToString() -> String {
    let formatter = Foundation.Date.formatter()
    return formatter.veryShortWeekdaySymbols[self.weekday()-1] as String
  }
  
  /**
   A string representation of the month.
   
   - Returns String
   */
  func monthToString() -> String {
    let formatter = Foundation.Date.formatter()
    return formatter.monthSymbols[self.month()-1] as String
  }
  
  /**
   A short string representation of the month.
   
   - Returns String
   */
  func shortMonthToString() -> String {
    let formatter = Foundation.Date.formatter()
    return formatter.shortMonthSymbols[self.month()-1] as String
  }
  
  /**
   A very short string representation of the month.
   
   - Returns String
   */
  func veryShortMonthToString() -> String {
    let formatter = Foundation.Date.formatter()
    return formatter.veryShortMonthSymbols[self.month()-1] as String
  }
  
  
  // MARK: Static Cached Formatters
  
  /**
   Returns a cached static array of NSDateFormatters so that thy are only created once.
   */
  fileprivate static func sharedDateFormatters() -> [String: DateFormatter] {
    struct Static {
      static var formatters: [String: DateFormatter]? = nil
      static var once: Int = 0
    }
    // dispatch_once(&Static.once) {
      Static.formatters = [String: DateFormatter]()
    // }
    return Static.formatters!
  }
  
  /**
   Returns a cached formatter based on the format, timeZone and locale. Formatters are cached in a singleton array using hashkeys generated by format, timeZone and locale.
   
   - Parameter format: The format to use.
   - Parameter timeZone: The time zone to use, defaults to the local time zone.
   - Parameter locale: The locale to use, defaults to the current locale
   - Returns The date formatter.
   */
  fileprivate static func formatter(_ format:String = DefaultFormat, timeZone: Foundation.TimeZone = Foundation.TimeZone.autoupdatingCurrent, locale: Locale = Locale.current) -> DateFormatter {
    let hashKey = "\(format.hashValue)\(timeZone.hashValue)\(locale.hashValue)"
    var formatters = Foundation.Date.sharedDateFormatters()
    if let cachedDateFormatter = formatters[hashKey] {
      return cachedDateFormatter
    } else {
      let formatter = DateFormatter()
      formatter.dateFormat = format
      formatter.timeZone = timeZone
      formatter.locale = locale
      formatter.amSymbol = "am"
      formatter.pmSymbol = "pm"
      formatters[hashKey] = formatter
      return formatter
    }
  }
  
  /**
   Returns a cached formatter based on date style, time style and relative date. Formatters are cached in a singleton array using hashkeys generated by date style, time style, relative date, timeZone and locale.
   
   - Parameter dateStyle: The date style to use.
   - Parameter timeStyle: The time style to use.
   - Parameter doesRelativeDateFormatting: Enables relative date formatting.
   - Parameter timeZone: The time zone to use.
   - Parameter locale: The locale to use.
   - Returns The date formatter.
   */
  fileprivate static func formatter(_ dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style, doesRelativeDateFormatting: Bool, timeZone: Foundation.TimeZone = Foundation.TimeZone.autoupdatingCurrent, locale: Locale = Locale.current) -> DateFormatter {
    var formatters = Foundation.Date.sharedDateFormatters()
    let hashKey = "\(dateStyle.hashValue)\(timeStyle.hashValue)\(doesRelativeDateFormatting.hashValue)\(timeZone.hashValue)\(locale.hashValue)"
    if let cachedDateFormatter = formatters[hashKey] {
      return cachedDateFormatter
    } else {
      let formatter = DateFormatter()
      formatter.dateStyle = dateStyle
      formatter.timeStyle = timeStyle
      formatter.doesRelativeDateFormatting = doesRelativeDateFormatting
      formatter.timeZone = timeZone
      formatter.locale = locale
      formatters[hashKey] = formatter
      return formatter
    }
  }
  
}
