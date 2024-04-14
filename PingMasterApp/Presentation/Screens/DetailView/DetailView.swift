//
//  DetailView.swift
//  PingApp
//
//  Created by Muneer K K on 13/04/2024.
//

import SwiftUI

struct DetailView: View {
    let latency: String
    var body: some View {
        Text("\(latency)")
    }
}

#Preview {
    DetailView(latency: "Test")
}
