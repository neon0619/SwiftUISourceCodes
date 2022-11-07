//
//  PeopleViewModel.swift
//  SwiftUISourceCodes
//
//  Created by Christopher Castillo on 8/22/22.
//

import Foundation

final class PeopleViewModel: ObservableObject {
    
    @Published private(set) var users: [User] = []
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published private(set) var viewState: ViewState?
    @Published var hasError: Bool = false
    
    private(set) var pageNum = 1
    private(set) var totalPages: Int?
    
    var isLoading: Bool { viewState == .loading }
    var isFetching: Bool { viewState == .fetching }
    
    private let networkingManager: NetworkingManagerImpl!
    
    init(networkingManager: NetworkingManagerImpl = NetworkingManager.shared) {
        self.networkingManager = networkingManager
    }
    
    @MainActor
    func fetchUsers() async {
        reset()
        viewState = .fetching
        defer { viewState = .finished }
        
        do {
            let response = try await networkingManager.request(session: .shared,
                                                               .people(page: pageNum),
                                                               type: UsersModel.self)
            self.totalPages = response.totalPages
            self.users = response.data
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(err: error)
            }
        }
    }
    
    @MainActor
    func fetchNextSetofUsers() async {
        
        guard pageNum != totalPages else { return }
        
        viewState = .fetching
        defer { viewState = .finished }
        
        pageNum += 1
        
        do {
            let response = try await networkingManager.request(session: .shared,
                                                               .people(page: pageNum),
                                                               type: UsersModel.self)
            self.totalPages = response.totalPages
            self.users += response.data
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(err: error)
            }
        }
    }
    
    func hasReachedEnd(of user: User) -> Bool {
        return users.last?.id == user.id
    }
}


extension PeopleViewModel {
    enum ViewState {
        case loading
        case fetching
        case finished
    }
}

private extension PeopleViewModel {
    func reset() {
        if viewState == .finished {
            users.removeAll()
            pageNum = 1
            totalPages = nil
            viewState = nil
        }
    }
}

