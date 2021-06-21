import Foundation

typealias FruitsResult = (Result<FruitsDto, Error>) -> Void

protocol FruitsRepository: FruitsDataFetch { }

protocol FruitsDataFetch {
    func fetchFruits(completion: @escaping FruitsResult)
}
