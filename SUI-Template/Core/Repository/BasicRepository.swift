import Foundation

protocol BasicRepositoryProtocol {
  func fetchBasicModel() async throws -> BaseDTOModel
}

final class BasicRepository: BasicRepositoryProtocol {
  private let dtoParsingService: DTOParsingServiceProtocol
  private let networkService: NetworkServiceProtocol
  
  init(dtoParsingService: DTOParsingServiceProtocol = DTOParsingService(), networkService: NetworkServiceProtocol = NetworkService()) {
    self.dtoParsingService = dtoParsingService
    self.networkService = networkService
  }
  
  func fetchBasicModel() async throws -> BaseDTOModel {
   let urlStr = "https://rickandmortyapi.com/api"
    do {
      let data = try await networkService.fetchData(urlStr)
      let model = try dtoParsingService.parseData(data, BaseDTOModel.self)
      return model
    } catch let err {
      throw err
    }
  }
}
