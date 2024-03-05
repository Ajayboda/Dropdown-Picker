//
//  DropdownView.swift
//  Dropdown Picker
//
//  Created by Ajay Boda on 04/03/24.
//

import SwiftUI

enum Anchor {
    case buttom
    case top
}

struct DropdownView: View {
    
    var hint: String
    var options: [String]
    var anchor: Anchor = .buttom
    var maxWidth: CGFloat = 180
    var cornerRadius: CGFloat = 15
    @Binding var selection: String?
    @State private var showOptions: Bool = false
    @SceneStorage("drop_down_zindex") private var index = 1000.0
    @State private var zindex = 1000.0
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 0) {
                
                if showOptions && anchor == .top {
                    optionView
                }
                
                HStack(spacing: 0) {
                    Text(selection ?? hint)
                        .foregroundStyle(selection == nil ? .gray : .primary)
                        .lineLimit(1)
                    
                    Spacer(minLength: 0)
                    
                    Image(systemName: "chevron.down")
                        .font(.title3)
                        .foregroundStyle(.gray)
                        .rotationEffect(.init(degrees: showOptions ? -180 : 0))
                }
                .padding(.horizontal, 15)
                .frame(width: size.width, height: size.height)
                .background(.white)
                .contentShape(.rect)
                .onTapGesture {
                    
                    index += 1
                    zindex = index
                    withAnimation(.snappy) {
                        showOptions.toggle()
                    }
                }
                .zIndex(10)
                
                if showOptions && anchor == .buttom {
                    optionView
                }
            }
            .clipped()
            .contentShape(.rect)
            .background(Color.white.shadow(.drop(color: .primary.opacity(0.15), radius: 4)), in: .rect(cornerRadius: cornerRadius))
            .frame(height: size.height, alignment: anchor == .top ? .bottom : .top)
        }
        
        .frame(width: maxWidth, height: 50)
        .zIndex(zindex)
        
    }

    // OptionView
    
    var optionView: some View {
      
        VStack(spacing: 10) {
            ScrollView {
                ForEach(options, id: \.self) { option in
                    HStack(spacing: 0) {
                        Text(option)
                            .lineLimit(1)
                        
                        Spacer(minLength: 0)
                        
                        Image(systemName: "checkmark")
                            .font(.caption)
                            .opacity(selection == option ? 1 : 0)
                    }
                    .foregroundStyle(selection == option ? Color.primary : Color.gray)
                    .animation(.none, value: selection)
                    .frame(height: 40)
                    .contentShape(.rect)
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selection = option
                            
                            showOptions = false
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 5)
        .transition(.move(edge: anchor == .top ? .bottom : .top))
        .frame(height: (CGFloat(options.count) * 50.0) > 200.0 ? 200.0 : (CGFloat(options.count) * 50.0))
    }
        
    
}

#Preview {
    ContentView()
}
