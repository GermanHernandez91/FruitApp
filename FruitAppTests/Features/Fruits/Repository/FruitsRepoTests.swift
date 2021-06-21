import XCTest
@testable import FruitApp

final class FruitsRepoTests: XCTestCase {
    
    /**
        Scenario 1: SUCCESS
        Create repo and expect correct result from fetchFruits
     */
    func test_scenario1() {
        let sut = FruitsRepo(remoteDataSource: SuccessdingMockRemoteDataSource())
        
        sut.fetchFruits { result in
            switch result {
            case .success(let exepectedDto):
                XCTAssertEqual(exepectedDto, mockFruitsDto)
            case .failure(let error):
                XCTAssertThrowsError(error)
            }
        }
    }
    
    /**
        Scenario 2: ERROR
        Create repo and expect error from fetchFruits
     */
    func test_scenario2() {
        let sut = FruitsRepo(remoteDataSource: FailingMockRemoteDataSource())
        
        sut.fetchFruits { result in
            switch result {
            case .success(_):
                XCTAssertThrowsError("Unit test should be failing")
            case .failure(let error):
                XCTAssertEqual(error as! NetworkError, NetworkError.invalidResponse)
            }
        }
    }
}

private final class SuccessdingMockRemoteDataSource: FruitsDataFetch {
    
    func fetchFruits(completion: @escaping FruitsResult) {
        completion(.success(mockFruitsDto))
    }
}

private final class FailingMockRemoteDataSource: FruitsDataFetch {
 
    func fetchFruits(completion: @escaping FruitsResult) {
        completion(.failure(NetworkError.invalidResponse))
    }
}

private let mockFruitsDto = FruitsDto(response: mockFruitsResponse)
private let mockFruitsResponse = FruitsResponse(fruit: [])
