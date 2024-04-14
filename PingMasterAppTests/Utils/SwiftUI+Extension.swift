//
//  SwiftUI+Extension.swift
//  PingAppTests
//
//  Created by Muneer K K on 14/04/2024.
//

import Foundation
import SwiftUI
extension SwiftUI.View {
    func toVC() -> UIViewController {
        let vc = UIHostingController(rootView: self)
        vc.view.frame = UIScreen.main.bounds
        return vc
    }
}
