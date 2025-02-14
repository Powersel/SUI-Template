import SwiftUI

struct RecipeCell: View {
  
  private let model: RecipeDTO
  
  init(recipeDTO: RecipeDTO) {
    self.model = recipeDTO
  }
  
  var body: some View {
    HStack(spacing: 10) {
      Spacer(minLength: 30)
      VStack(alignment: .leading, spacing: 6) {
        Text(model.name)
          .font(.headline)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      
      Spacer()
      
      if let urlStr = model.previewPhotoURL, let imageURL = URL(string: urlStr) {
        AsyncImage(url: imageURL) { imageData in
          if let image = imageData.image {
            image
              .resizable()
              .scaledToFit()
          }
        }
        .frame(maxWidth: 60, maxHeight: 60)
        .cornerRadius(30)
      }
      
      Spacer(minLength: 20)
    }
    .onAppear() {
      
    }
    .background(Color(UIColor.lightGray))
    .clipShape(Capsule())
  }
}

#Preview {
  let dto = RecipeDTO(cuisine: "Malaysian",
                      name: "Apam Balik",
                      photoURL: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                      previewPhotoURL: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                      id: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                      sourceURL: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                      videoURL: "https://www.youtube.com/watch?v=6R8ffRRJcrg")
  RecipeCell(recipeDTO: dto)
}
