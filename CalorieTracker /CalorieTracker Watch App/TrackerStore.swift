import Foundation
import Observation

// this is the main brains of the app
// It stores entries, calculates totals, and even saves/loads using UserDefaults.
@Observable
class TrackerData {

    var entries: [Entry] = [] // list of everyhting logged in for the day
    var previousDayCalories: Double = 0.0

    private let defaults = UserDefaults.standard
    private var lastResetDate: Date

    init() {
        // Load last reset date (or use today if first run)
        lastResetDate = defaults.object(forKey: "lastReset") as? Date ?? Date()

        loadData()
        resetIfNewDay()

        // on launch, push current totals to widget as well (so it’s not stale)
        pushToWidget()
    }

    // total calories for the day
    var caloriesToday: Double {
        entries.reduce(0) { $0 + $1.calories }
    }


    var waterTodayLitres: Double {
        entries.reduce(0) { $0 + $1.waterML } / 1000.0
    }

    // Add a food or water entry
    func addEntry(name: String, calories: Double, waterML: Double = 0) {
        let entry = Entry(name: name, calories: calories, waterML: waterML)
        entries.append(entry)
        save()
    }

    // this part checks if the current date is different form the last reset date
    // if it is different this then means the calories move to the history section which clears the entries
    func resetIfNewDay() {
        let today = Date()

        if !Calendar.current.isDateInToday(lastResetDate) {
            previousDayCalories = caloriesToday
            entries.removeAll()
            lastResetDate = today
            save()
        }
    }

    // Manual reset button
    func resetTodayForDemo() {
        previousDayCalories = caloriesToday
        entries.removeAll()
        save()
    }
    // this part saves everything ro userdefaults
    private func save() {
        defaults.set(lastResetDate, forKey: "lastReset")
        defaults.set(previousDayCalories, forKey: "previousDayCalories")
        // these store the entries array ands stores it
        if let data = try? JSONEncoder().encode(entries) {
            defaults.set(data, forKey: "entries")
        }

        pushToWidget() // this sends the signals to the widget
    }

    private func loadData() {
        if let data = defaults.data(forKey: "entries"),
           let decoded = try? JSONDecoder().decode([Entry].self, from: data) {
            entries = decoded
        }

        previousDayCalories = defaults.double(forKey: "previousDayCalories")
    }
    
    private func pushToWidget() {
        SharedIntakeStore.write( calories: caloriesToday,waterLitres: waterTodayLitres
        )
    }
}
