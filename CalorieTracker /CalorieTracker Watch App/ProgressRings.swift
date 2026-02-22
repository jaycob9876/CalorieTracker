import SwiftUI

struct ProgressRingsView: View {
    let calories: Double
    let waterLitres: Double

    // Goals used for the ring progress
    private let calorieGoal: Double = 1200
    private let waterGoalLitres: Double = 2.0

    var body: some View {
        ZStack {
            // Background ring
            Circle()
                .stroke(.gray.opacity(0.25), lineWidth: 8)

            // Calories progress ring which i put in yellow as red was to dark
            Circle()
                .trim(from: 0, to: min(calories / calorieGoal, 1))
                .stroke(
                    Color(red: 1.0, green: 0.92, blue: 0.7),
                    style: StrokeStyle(lineWidth: 10, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))

            // Water intake progress ring which is blue
            Circle()
                .trim(from: 0, to: min(waterLitres / waterGoalLitres, 1))
                .stroke(
                    Color.blue.opacity(0.6),
                    style: StrokeStyle(lineWidth: 14, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .frame(width: 80, height: 80)

            // these are the figures insdie the ring to show which represents each ring 
            VStack(spacing: 4) {
                Text("\(Int(calories))")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundStyle(Color(red: 1.0, green: 0.92, blue: 0.7))

                Text("\(Int(waterLitres * 1000))ml")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.blue.opacity(0.8))
            }
        }
        .frame(width: 130, height: 130)
    }
}
