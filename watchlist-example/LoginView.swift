//
//  LoginView.swift
//  watchlist-example
//
//  Created by William Towe on 2/3/25.
//

import Feige
import Foundation
import SwiftUI
import UIKit

struct LoginView: View {
    // MARK: - Public Properties
    @StateObject
    var viewModel: LoginViewModel
    
    // MARK: - View
    var body: some View {
        VStack(spacing: .margin) {
            TextField(String(localized: "login.username.placeholder", defaultValue: "Enter your username"), text: $viewModel.username)
                .textInputAutocapitalization(.never)
                .padding(.padding)
                .overlay(RoundedRectangle(cornerRadius: .cornerRadius)
                    .stroke(.gray)
                )
            SecureField(String(localized: "login.password.placeholder", defaultValue: "Enter your password"), text: $viewModel.password)
                .padding(.padding)
                .overlay(RoundedRectangle(cornerRadius: .cornerRadius)
                    .stroke(.gray)
                )
            Button(action: {
                Task { @MainActor in
                    do {
                        _ = try await viewModel.login()
                    }
                    catch {
                        loginError = error
                        isDisplayingLoginAlert = true
                    }
                }
            }, label: {
                Text(String(localized: "login.button", defaultValue: "Login"))
                    .frame(maxWidth: .infinity)
            })
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.canLogin.not())
            .alert(String(localized: "login.alert", defaultValue: "Error"), isPresented: $isDisplayingLoginAlert) {
                Button(String(localized: "button.okay", defaultValue: "Okay"), role: .cancel) {}
            } message: {
                Text(loginError?.localizedDescription ?? String(localized: "login.error", defaultValue: "Something went wrong. Please try again later."))
            }
            Spacer()
        }
        .padding()
    }
    
    // MARK: - Private Properties
    @State
    private var isDisplayingLoginAlert = false
    @State
    private var loginError: Error?
}
