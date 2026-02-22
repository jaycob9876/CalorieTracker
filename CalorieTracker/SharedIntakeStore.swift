import Foundation
import WidgetKit

// This is the connection between the app and the widget.
// The app writes the totals here and then the widget reads them.
enum SharedIntakeStore {

    // App Group ID which matches whcih deifnes the group
    static let appGroupID = "group.com.jacob.TrackerWatch2"

    // Keys used in shared UserDefaults
    static let caloriesKey = "calories_intake"
    static let waterKey = "water_intake"
    static let updatedKey = "last_updated"

    // Shared UserDefaults container
    static var defaults: UserDefaults {
        UserDefaults(suiteName: appGroupID)!
    }

    // Called by the app whenever totals change
    static func write(calories: Double, waterLitres: Double) {
        defaults.set(Int(calories.rounded()), forKey: caloriesKey)
        defaults.set(waterLitres, forKey: waterKey)
        defaults.set(Date(), forKey: updatedKey)

        // Tells the system to refresh the widget 
        WidgetCenter.shared.reloadAllTimelines()
    }

    // Called by the widget whenever it needs current values
    static func read() -> (calories: Int, waterLitres: Double, updated: Date?) {
        let c = defaults.integer(forKey: caloriesKey)
        let w = defaults.double(forKey: waterKey)
        let d = defaults.object(forKey: updatedKey) as? Date
        return (c, w, d)
    }
}
