//
//  SearchBar.swift
//  iOS Example
//
//  Created by Eugene Rysaj on 06.03.2020.
//  Copyright © 2020 Awesome Org. All rights reserved.
//

import SwiftUI

struct SearchBar : View {
  @Binding var text : String
  @State var showCancelButton: Bool = true

  var body: some View {
    HStack {
        HStack {
            Image(systemName: "magnifyingglass")

            TextField("keywords", text: $text, onEditingChanged: { isEditing in
                self.showCancelButton = true
            }, onCommit: {
                print("onCommit")
            }).foregroundColor(.primary)

            Button(action: {
                self.text = ""
            }) {
                Image(systemName: "xmark.circle.fill").opacity(text == "" ? 0 : 1)
            }
        }
        .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
        .foregroundColor(.secondary)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10.0)

        if showCancelButton  {
            Button("Cancel") {
                    UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                    self.text = ""
                    self.showCancelButton = false
            }
            .foregroundColor(Color(.systemBlue))
        }
    }
    .padding(.horizontal)
    .navigationBarHidden(showCancelButton)
//    .animation(.default) // animation does not work properly
  }
}

extension UIApplication {
  func endEditing(_ force: Bool) {
    self.windows
      .filter{$0.isKeyWindow}
      .first?
      .endEditing(force)
  }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
  var gesture = DragGesture().onChanged{_ in
    UIApplication.shared.endEditing(true)
  }
  
  func body(content: Content) -> some View {
    content.gesture(gesture)
  }
}

extension View {
  func resignKeyboardOnDragGesture() -> some View {
    return modifier(ResignKeyboardOnDragGesture())
  }
}
