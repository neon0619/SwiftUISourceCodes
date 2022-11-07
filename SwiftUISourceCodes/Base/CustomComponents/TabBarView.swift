//
//  TabBarView.swift
//  SwiftUISourceCodes
//
//  Created by Christopher Castillo on 8/11/22.
//

import SwiftUI

enum Tab: Int, CaseIterable, Identifiable {
    case people
    case settings
    
    var id: Int { self.rawValue }
    
    func icon(_ currentIndex: Int) -> String {
        let isSelected = self.rawValue == currentIndex
        switch self {
        case .people:
            return isSelected ? "person.fill" : "person"
        case .settings:
            return isSelected ? "gearshape.fill" : "gearshape"
        }
    }
    
    var title : String {
        switch self {
        case .people:
            return "People"
        case .settings:
            return "Settings"
        }
    }
    
}

struct TabBarView: View {
    
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack {
            Spacer().frame(height: 7)
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    
                    VStack {
                        Image(systemName: tab.icon(selectedTab))
                            .scaleEffect(selectedTab == tab.rawValue ? 1.25 : 1.0)
                            .onTapGesture {
                                withAnimation(.easeIn(duration: 0.1)) {
                                    selectedTab = tab.id
                                }
                        }
                        
                        Spacer().frame(height: 6)
                        Text(tab.title)
                            .foregroundColor(selectedTab == tab.rawValue ? Theme.fontColor : .gray)
                            .font(.system(size: 11)
                                .weight(.semibold))
                            .tracking(-0.3)

                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.all, -6)
                    
                    Spacer()
                }
            }
            .frame(width: nil, height: 50)
        }
        .background(Theme.detailackground)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 6)
        
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(selectedTab: .constant(0))
    }
}
