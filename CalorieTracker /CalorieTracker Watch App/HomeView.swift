import SwiftUI

struct ContentView: View {
    @State private var data = TrackerData()

    // Controls which sheet is open
    @State private var activeSheet: SheetType? = nil

    enum SheetType: Identifiable {
        case addFood
        case addWater
        case history
        var id: Self { self }
    }

    // Same colours used across the app some are simliar some are adjusted to the color patterns i was looking for
    let lightYellow = Color(red: 1.0, green: 0.92, blue: 0.7)
    let lightBlue = Color.blue.opacity(0.5)

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 14) {

                    Text("Calorie Tracker")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .foregroundStyle(.primary)
                        .padding(.top, 12)
                        .padding(.bottom, 6)

                    // Rings show numbers in the middle to show which information is for which ring
                    ProgressRingsView(
                        calories: data.caloriesToday,
                        waterLitres: data.waterTodayLitres
                    )
                    .frame(maxWidth: .infinity)

                    VStack(spacing: 6) {
                        Text("\(Int(data.caloriesToday)) Calorie")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundStyle(lightYellow)

                        Text("\(Int(data.waterTodayLitres * 1000))ml Water ")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(lightBlue)
                    }
                    .padding(.vertical, 8)

                    VStack(spacing: 16) {
                        Button {
                            activeSheet = .addFood
                        } label: {
                            Label("Add Food", systemImage: "fork.knife")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                                .frame(width: 160, height: 48)
                                .background(Color.gray.opacity(0.7))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .buttonStyle(.plain)

                        Button {
                            activeSheet = .addWater
                        } label: {
                            Label("Add Water", systemImage: "drop.fill")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                                .frame(width: 160, height: 48)
                                .background(lightBlue)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)

                    // List of the users entry for the day
                    if !data.entries.isEmpty {
                        VStack(spacing: 8) {
                            Text("Today")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundStyle(.secondary)

                            ForEach(data.entries) { entry in
                                HStack(spacing: 6) {
                                    Text(entry.name)
                                        .font(.system(size: 13))
                                        .lineLimit(1)

                                    Spacer()
                                    // this hsows the calories
                                    if entry.calories > 0 {
                                        Text("\(Int(entry.calories)) cal")
                                            .font(.system(size: 12))
                                            .foregroundStyle(lightYellow)
                                    }
                                    // this section shows the water intake 
                                    if entry.waterML > 0 {
                                        Text("\(Int(entry.waterML))ml")
                                            .font(.system(size: 12))
                                            .foregroundStyle(lightBlue)
                                    }
                                }
                                .padding(.vertical, 3)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 6)
                    }

                    Spacer(minLength: 10)
                    // these are the reset and history buttons and how they function
                    // copied and pasted them as they were both similar
                    VStack(spacing: 16) {
                        Button {
                            data.resetTodayForDemo()
                        } label: {
                            Text("Reset Today")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                                .frame(width: 160, height: 48)
                                .background(Color.gray.opacity(0.7))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .buttonStyle(.plain)

                        Button {
                            activeSheet = .history
                        } label: {
                            Text("View History")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white)
                                .frame(width: 160, height: 48)
                                .background(lightBlue)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
            }
            .sheet(item: $activeSheet) { sheet in
                switch sheet {
                case .addFood:
                    AddFoodView(data: data)
                case .addWater:
                    AddWaterView(data: data)
                case .history:
                    HistoryView(
                        previousCalories: data.previousDayCalories,
                        todayCalories: data.caloriesToday
                    )
                }
            }
            .onAppear {
                // this part hopefully chekcs if the days changed adn would reset the watch back to 0 for the next day
                data.resetIfNewDay()
            }
        }
    }
}
