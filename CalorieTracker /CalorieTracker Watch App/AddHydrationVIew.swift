import SwiftUI

struct AddWaterView: View {
    let data: TrackerData
    @Environment(\.dismiss) private var dismiss

    //before typing the amount water it shows an example that highlights how to set it up
    @State private var waterMLText = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Water (ml) e.g. 400", text: $waterMLText)
            }
            .navigationTitle("Add Water")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        // This inputs it as ml directly
                        let ml = Double(waterMLText) ?? 0
                        if ml > 0 {
                            data.addEntry(name: "Water", calories: 0, waterML: ml)
                        }
                        dismiss()
                    }
                }
            }
        }
    }
}
