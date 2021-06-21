import Foundation

final class FruitsRepo {
    
    // MARK: - Properties
    private var remoteDataSource: FruitsDataFetch
    
    // MARK: - Lifecycle
    init(remoteDataSource: FruitsDataFetch) {
        self.remoteDataSource = remoteDataSource
    }
    
}

extension FruitsRepo: FruitsRepository {
    
    func fetchFruits(completion: @escaping FruitsResult) {
        remoteDataSource.fetchFruits(completion: completion)
    }
}
