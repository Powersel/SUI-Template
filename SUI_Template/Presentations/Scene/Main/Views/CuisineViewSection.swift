import SwiftUI

struct CuisineViewSection: View {
  
  private let recipeDTOs: [RecipeDTO]
  private let cuisineName: String
  
  init(recipeDTOs: [RecipeDTO]) {
    let name = recipeDTOs.isEmpty ? "Unknown cuisine" : recipeDTOs[0].cuisine 
    self.cuisineName = name
    self.recipeDTOs = recipeDTOs
  }
  
  var body: some View {
    Section(header: Text(cuisineName)) {
      ForEach(recipeDTOs) { recipe in
        RecipeCell(recipeDTO: recipe)
      }
    }
    .headerProminence(.increased)
  }
}
