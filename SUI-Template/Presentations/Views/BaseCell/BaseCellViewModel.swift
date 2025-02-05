import Foundation

final class BaseCellViewModel: ObservableObject {
  @Published
  private(set) var title: String = ""
  
  @Published
  private(set) var descriptionTitle: String = ""
  
  @Published
  private(set) var imageURL: String = ""

  init(title: String, descriptionTitle: String, imageURL: String) {
    self.title = title
    self.descriptionTitle = descriptionTitle
    self.imageURL = imageURL
  }
}
