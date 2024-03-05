//
//  ContentView.swift
//  Dropdown Picker
//
//  Created by Ajay Boda on 04/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selections: String?
    
    var options = ["Youtube", "Whatsapp", "Instagram", "SnapChat", "Facebook", "Twitter"]
    
    var body: some View {
        NavigationStack {

            VStack(spacing: 15) {
                DropdownView(
                    hint: "Select",
                    options: options,
                    anchor: .top,
                    selection: $selections)
            }
            
            .navigationTitle("Dropdown Picker")
        }
    }
}

#Preview {
    ContentView()
}
