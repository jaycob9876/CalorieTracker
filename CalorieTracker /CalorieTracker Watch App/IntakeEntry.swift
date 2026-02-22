import Foundation

//the entry part represents what the user has inputed in for example breakfast
// breakfast 500 cal or water 400ml
struct Entry: Identifiable, Codable {
    let id = UUID() // unique ID for swiftui lists
    let name: String // entrys like breakfast, snack etc
    let calories: Double // callories for the food secton
    let waterML: Double // this is for the water section

    //these are the coding keys which fielfs the save to storage.
    private enum CodingKeys: String, CodingKey {
        case name, calories, waterML
    }
}
