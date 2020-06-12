//
//  SymbolsView.swift
//  iOS Example
//
//  Created by Eugene Rysaj on 13.06.2020.
//  Copyright © 2020 Awesome Org. All rights reserved.
//

import SwiftUI
import AlphaVantageKit

struct SymbolsView: View {
  var body: some View {
    HStack {
      Text("MSFT").fontWeight(.bold)
      Spacer()
      Text("138.90")
      ZStack {
        RoundedRectangle(cornerRadius: 10.0)
          .fill(Color.green)
        HStack {
          Text("+").foregroundColor(.white)
          Spacer()
          Text("0.50").foregroundColor(.white)
        }.padding()
      }
      .frame(width: 100.0, height: 40.0)
    }
    .frame(height: 60)
  }
}

#if DEBUG
struct SymbolsView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
     SymbolsView()
      .environment(\.colorScheme, .light)

     SymbolsView()
      .environment(\.colorScheme, .dark)
    }
  }
}
#endif
