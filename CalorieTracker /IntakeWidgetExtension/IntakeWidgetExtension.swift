import WidgetKit
import SwiftUI

struct IntakeWidgetEntry: TimelineEntry { // this is the data object for the widget timeline
    let date: Date
    let calories: Int
    let waterLitres: Double
}

struct IntakeWidgetProvider: TimelineProvider { // shows what the widget shows

    func placeholder(in context: Context) -> IntakeWidgetEntry {
        IntakeWidgetEntry(date: .now, calories: 1200, waterLitres: 1.5)
    }

    func getSnapshot(in context: Context, completion: @escaping (IntakeWidgetEntry) -> Void) {// the shot sed in the gallery preview
        let data = SharedIntakeStore.read()
        completion(IntakeWidgetEntry(date: .now, calories: data.calories, waterLitres: data.waterLitres))
    }
    // this is waht runs the watch face.
    func getTimeline(in context: Context, completion: @escaping (Timeline<IntakeWidgetEntry>) -> Void) {
        let data = SharedIntakeStore.read()
        let entry = IntakeWidgetEntry(date: .now, calories: data.calories, waterLitres: data.waterLitres)

        // refresh for the app
        completion(Timeline(entries: [entry], policy: .never))
    }
}

struct IntakeWidgetView: View {
    var entry: IntakeWidgetProvider.Entry

    // as set beofore same colours had to search up color options to get the specific colour I wanted
    let lightYellow = Color(red: 1.0, green: 0.92, blue: 0.7,)
    let lightBlue = Color.blue.opacity(0.6)

    var body: some View {
        VStack(spacing: 4) {

            HStack(spacing: 4) {
                Image(systemName: "fork.knife")
                    .foregroundStyle(lightYellow)
                Text("\(entry.calories)cal")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundStyle(lightYellow)
            }

            HStack(spacing: 4) {
                Image(systemName: "drop.fill")
                    .foregroundStyle(lightBlue)


                Text("\(Int(entry.waterLitres * 1000))ml")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(lightBlue)
            }
        }
        .padding(8)
    }
}

@main
struct IntakeWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "IntakeWidget", provider: IntakeWidgetProvider()) { entry in
            IntakeWidgetView(entry: entry)
        }
        .configurationDisplayName("Daily Intake")
        .description("Shows calories and water.")
        .supportedFamilies([.accessoryRectangular])
    }
}
