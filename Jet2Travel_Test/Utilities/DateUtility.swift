import UIKit

class DateUtility {
  static func getElapsedInterval(dateString: String, toDate: Date) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone.autoupdatingCurrent
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

    guard let date = dateFormatter.date(from: dateString) else {
      return nil
    }
    
    let interval = Calendar.current.dateComponents([.year, .month, .day, .hour], from: date, to: toDate)
      if let year = interval.year, year > 0 {
          return year == 1 ? "\(year)" + " " + "year ago" :
              "\(year)" + " " + "years ago"
      } else if let month = interval.month, month > 0 {
          return month == 1 ? "\(month)" + " " + "month ago" :
              "\(month)" + " " + "months ago"
      } else if let day = interval.day, day > 0 {
          return day == 1 ? "\(day)" + " " + "day ago" :
              "\(day)" + " " + "days ago"
      } else if let hour = interval.hour, hour > 0 {
        return hour == 1 ? "\(hour)" + " " + "hours ago" :
            "\(hour)" + " " + "hours ago"
      } else {
          return "a moment ago"
      }
  }
}
