//
//  SettingsView.swift
//  SwiftUISourceCodes
//
//  Created by Christopher Castillo on 8/25/22.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage(UserDefaultKey.hapticsEnabled) private var isHapticEnabled: Bool = true
    
    var body: some View {
        Form {
            haptics
        }
        .navigationTitle("Settings")
        .embedInNavigation()
        
    }
}

private extension SettingsView {
    var haptics: some View {
        Toggle("Enable Haptics", isOn: $isHapticEnabled)
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
