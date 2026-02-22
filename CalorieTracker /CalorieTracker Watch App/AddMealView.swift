import SwiftUI

struct AddFoodView: View {
    let data: TrackerData
    @Environment(\.dismiss) private var dismiss

    @State private var selectedCategory = "Other"
    @State private var calories = ""

    // Categories shown in the picker options when user writes down the calories
    let categories = [
        "Breakfast", "Lunch", "Dinner", "Snack", "Fruit", "Vegetable","Protein", "Dairy", "Pasta", "Sweets", "Chococlate", "Nuts", "Other"
    ]

    var body: some View {
        NavigationStack {
            Form {
                Picker("Category", selection: $selectedCategory) { ForEach(categories, id: \.self) { cat in Text(cat).tag(cat)
                    }
                }

                TextField("Calories", text: $calories)
            }
            .navigationTitle("Add Food/Snack")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {Button("Cancel") { dismiss() }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        // Basic validation, this converts the text to number and then adds entry
                        if let cal = Double(calories), cal > 0 {
                            data.addEntry(name: selectedCategory, calories: cal)
                        }
                        dismiss()
                    }
                }
            }
        }
    }
}
