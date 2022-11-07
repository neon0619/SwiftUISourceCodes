//
//  DetailViewModel.swift
//  SwiftUISourceCodes
//
//  Created by Christopher Castillo on 8/23/22.
//

import Foundation

class DetailViewModel: ObservableObject {
    
    @Published private(set) var userInfo: UserDetailModel?
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published private(set) var isLoading = false
    @Published var hasError: Bool = false
    
    private let networkingManager: NetworkingManagerImpl!
    
    init(networkingManager: NetworkingManagerImpl = NetworkingManager.shared) {
        self.networkingManager = networkingManager
    }
    
    @MainActor
    func fetchDetails(for id: Int) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            self.userInfo = try await networkingManager.request(session: .shared,
                                                                .detail(id: id),
                                                                type: UserDetailModel.self)
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(err: error)
            }
        }
    }
    
}
