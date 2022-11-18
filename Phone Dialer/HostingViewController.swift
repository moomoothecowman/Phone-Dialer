//
//  HostingViewController.swift
//  Phone Dialer 
//
//  Created by Tyler Welch on 1/14/23.
//

import Cocoa
import SwiftUI

class HostingController: NSHostingController<AppDelegate> {
    @objc required dynamic init?(coder: NSCoder) {
        super.init(coder: coder, rootView: ViewController())
    }
}
