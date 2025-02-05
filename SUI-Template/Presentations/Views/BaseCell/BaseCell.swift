import SwiftUI

struct BaseCell: View {
  
  let viewModel: BaseCellViewModel
  
  init(viewModel: BaseCellViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    HStack(spacing: 10) {
      Spacer()
      VStack(alignment: .leading, spacing: 6) {
        Text(viewModel.title)
          .font(.largeTitle)
        Text(viewModel.descriptionTitle)
          .font(.headline)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      
      Spacer()
      
      if let imageURL = URL(string: viewModel.imageURL) {
        AsyncImage(url: imageURL) { imageData in
          if let image = imageData.image {
            image
              .resizable()
              .scaledToFit()
          }
        }
        .frame(maxWidth: 60, maxHeight: 60)
      }
      
      Spacer()
    }
    .background(.mint)
  }
}

#Preview {
  let vm = BaseCellViewModel(title: "AAAA", descriptionTitle: "Bbbbbbbbbbb", imageURL: "https://rickandmortyapi.com/api/character/avatar/361.jpeg")
  BaseCell(viewModel: vm)
}
