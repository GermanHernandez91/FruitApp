import Foundation

final class FruitsRemoteDataSource {
    
    // MARK: - Properties
    private var apiClient: APIClientProtocol
    
    // MARK: - Lifecycle
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
}

extension FruitsRemoteDataSource: FruitsDataFetch {
    
    func fetchFruits(completion: @escaping FruitsResult) {
        
        let url = FruitsEndpoint.fetchFruits.url()
        let request = FruitsRequest(url: url, httpMethod: .GET)
        
        apiClient.fetch(model: FruitsResponse.self, request: request) { response in
            let result = convert(result: getResult(forResponse: response))
            
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

private func getResult<T>(forResponse response: Result<T, NetworkError>) -> Result<T, RepositoryError> {
    switch response {
    case .success(let model):
        return .success(model)
    case .failure(let error):
        return .failure(.convert(from: error))
    }
}

private func convert(result: Result<FruitsResponse, RepositoryError>) -> Result<FruitsDto, Error> {
    switch result {
    case .success(let response):
        return .success(.init(response: response))
    case .failure(let error):
        return .failure(error)
    }
}
