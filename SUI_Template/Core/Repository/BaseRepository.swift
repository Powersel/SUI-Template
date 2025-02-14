import Foundation

protocol BaseRepositoryProtocol {
  func fetchBaseModel() async throws -> BaseDTOModel
  func fetchBaseModelFromDisk() async throws -> BaseDTOModel
}

final class BaseRepository: BaseRepositoryProtocol {
  private let dtoParsingService: DTOParsingServiceProtocol
  private let networkService: NetworkServiceProtocol
  private let fakeNetworkService: FakeNetworkServiceProtocol
  
  init(dtoParsingService: DTOParsingServiceProtocol = DTOParsingService(), networkService: NetworkServiceProtocol = NetworkService(),
       fakeNetworkService: FakeNetworkServiceProtocol = FakeNetworkService()) {
    self.dtoParsingService = dtoParsingService
    self.networkService = networkService
    self.fakeNetworkService = fakeNetworkService
  }
  
  func fetchBaseModel() async throws -> BaseDTOModel {
    do {
      let urlStr = APIEndpoint.base.path
      let data = try await networkService.fetchData(urlStr)
      let model = try dtoParsingService.parseData(data, BaseDTOModel.self)
      return model
    } catch let err {
      throw err
    }
  }
  
  func fetchBaseModelFromDisk() async throws -> BaseDTOModel {
    do {
      let data = try await fakeNetworkService.getLocalFileData()
      let model = try dtoParsingService.parseData(data, BaseDTOModel.self)
      return model
    } catch let err {
      throw err
    }
  }
}
