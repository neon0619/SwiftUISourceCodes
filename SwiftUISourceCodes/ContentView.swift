//
//  ContentView.swift
//  SwiftUISourceCodes
//
//  Created by Christopher Castillo on 8/3/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = 0
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            VStack {
                TabView(selection: $selectedTab) {
                    ForEach(Tab.allCases, id: \.rawValue) { tab in
                    
                        switch tab.id {
                        case 0:
                            PeopleView()
                        case 1:
                            SettingsView()
                        default:
                            EmptyView()
                        }
                    }
                }
            }
            VStack {
                Spacer()
                TabBarView(selectedTab: $selectedTab)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
