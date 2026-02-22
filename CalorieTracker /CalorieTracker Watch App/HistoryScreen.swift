import SwiftUI

struct HistoryView: View {
    let previousCalories: Double
    let todayCalories: Double

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("History")
                    .font(.title2.bold())
                    .padding(.top, 20)

                VStack(spacing: 16) {
                    HStack {
                        Text("Yesterday:")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text("\(Int(previousCalories)) cal")
                            .font(.title3)
                    }

                    HStack {
                        Text("Today:")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text("\(Int(todayCalories)) cal")
                            .font(.title3)
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 20)

                Spacer()
            }
        }
    }
}
