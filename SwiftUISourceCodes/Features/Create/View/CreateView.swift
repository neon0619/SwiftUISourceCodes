//
//  CreateView.swift
//  SwiftUISourceCodes
//
//  Created by Christopher Castillo on 8/21/22.
//

import SwiftUI

struct CreateView {
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusField: Field?
    @StateObject private var vm = CreateViewModel()
    let successfulAction: () -> Void
}

extension CreateView: View {
    var body: some View {
        Form {
            Section {
                firstname
                lastname
                job
            } footer: {
                
                if case .validation(let err) = vm.error,
                   let errDesc = err.errorDescription {
                    Text(errDesc)
                        .foregroundStyle(.red)
                }
            }
            Section {
                submit
            }
        }
        .disabled(vm.state == .submitting)
        .navigationTitle("Create")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                done
            }
        }
        .onChange(of: vm.state) { formState in
            if formState == .successful {
                dismiss()
                successfulAction()
            }
        }
        .alert(isPresented: $vm.hasError, error: vm.error) { }
        .overlay {
            if vm.state == .submitting {
                ProgressView()
            }
        }
        .embedInNavigation()
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView {}
    }
}

extension CreateView {
    enum Field: Hashable {
        case firstName
        case lastName
        case job
    }
}

private extension CreateView {
    
    var firstname: some View {
        TextField("First name", text: $vm.person.firstName)
            .focused($focusField, equals: .firstName)
    }
    
    var lastname: some View {
        TextField("Last name", text: $vm.person.lastName)
            .focused($focusField, equals: .lastName)
    }
    
    var job: some View {
        TextField("Job", text: $vm.person.job)
            .focused($focusField, equals: .job)
    }
    
    var submit: some View {
        Button("Submit") {
            focusField = nil
            Task {
                await vm.create()
            }
        }
    }
    
    var done: some View {
        Button("Done") {
            dismiss()
        }
    }
}
