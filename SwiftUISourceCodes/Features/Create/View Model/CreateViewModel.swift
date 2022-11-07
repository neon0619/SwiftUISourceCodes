//
//  CreateViewModel.swift
//  SwiftUISourceCodes
//
//  Created by Christopher Castillo on 8/24/22.
//

import Foundation


final class CreateViewModel: ObservableObject {
    
    @Published var person = CreateModel()
    @Published private(set) var state: SubmissionState?
    @Published private(set) var error: FormError?
    @Published var hasError: Bool = false
    
    private let networkingManager: NetworkingManagerImpl!
    private let validator: CreateValidatorImpl!
    
    init(networkingManager: NetworkingManagerImpl = NetworkingManager.shared,
         validator: CreateValidatorImpl = CreateValidator()) {
        self.networkingManager = networkingManager
        self.validator = validator
    }

    @MainActor
    func create() async {
        
        do {
            
            /* 1. Validate Form Locally */
            try validator.validate(person)
            
            /* 2. Change the state to Submitting */
            state = .submitting
            
            /* 3. Encode the data */
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try encoder.encode(person)
            print("data : \(data)")
            /* 4. Create API Post request with data */
            try await networkingManager.request(session: .shared, .create(submissionData: data))
            
            /* 5. Change state to successful */
            state = .successful
            
        } catch {
            self.hasError = true
            self.state = .unsuccessful
            
            switch error {
            case is NetworkingManager.NetworkingError:
                self.error = .networking(error: error as! NetworkingManager.NetworkingError)
            case is CreateValidator.CreateValidatorError:
                self.error = .validation(error: error as! CreateValidator.CreateValidatorError)
            default:
                self.error = .system(error: error)
            }
            
        }
        
    }
}

extension CreateViewModel {
    enum SubmissionState {
        case unsuccessful
        case submitting
        case successful
    }
}

extension CreateViewModel {
    enum FormError: LocalizedError {
        case networking(error: LocalizedError)
        case validation(error: LocalizedError)
        case system(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .networking(let err),
                 .validation(let err):
                return err.errorDescription
            case .system(let err):
                return err.localizedDescription
            }
        }
        
    }
}

extension CreateViewModel.FormError: Equatable {
    static func == (lhs: CreateViewModel.FormError, rhs: CreateViewModel.FormError) -> Bool {
        switch (lhs, rhs) {
        case (.networking(let lhsType), .networking(let rhsType)):
            return lhsType.errorDescription == rhsType.errorDescription
        case (.validation(let lhsType), .validation(let rhsType)):
            return lhsType.errorDescription == rhsType.errorDescription
        case (.system(let lhsType), .system(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        default:
            return false
         }
    }
    
    
}

/* CLOSURE METHOD */
//func create() {
//
//    do {
//        try validator.validate(person)
//        state = .submitting
//
//        let encoder = JSONEncoder()
//        encoder.keyEncodingStrategy = .convertToSnakeCase
//        let data = try? encoder.encode(person)
//
//        networkingManager.request(.create(submissionData: data)) { [weak self] res in
//            DispatchQueue.main.async {
//                switch res {
//                case .success():
//                    self?.state = .successful
//                case .failure(let err):
//                    self?.state = .unsuccessful
//                    self?.hasError = true
//                    if let networkingError = err as? NetworkingManager.NetworkingError {
//                        self?.error = .networking(error: networkingError)
//                    }
//                }
//            }
//        }
//    } catch {
//        self.hasError = true
//        if let validationError = error as? CreateValidator.CreateValidatorError {
//            self.error = .validation(error: validationError)
//        }
//    }
//
//}

