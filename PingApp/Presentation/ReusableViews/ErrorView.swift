//
//  ErrorView.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import SwiftUI

struct ErrorView: View {
    let errorMessage: String
    let retryAction: () -> Void

    var body: some View {
        VStack {
            Text(errorMessage)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()

            Button(action: retryAction) {
                Text(Strings.ErrorView.erroViewTitle)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

#Preview {
    ErrorView(errorMessage: "") {}
}
