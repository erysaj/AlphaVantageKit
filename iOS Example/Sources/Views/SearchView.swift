//
//  SearchView.swift
//  iOS Example
//
//  Created by Eugene Rysaj on 06.03.2020.
//  Copyright © 2020 Awesome Org. All rights reserved.
//

import SwiftUI
import AlphaVantageKit
import AlphaVantageStubs

struct MatchView: View {
  let match: SymbolSearchRs.Match

  var body: some View {
    ZStack {
      Text(match.symbol).bold().frame(maxWidth: .infinity, alignment: .leading)
      HStack {
        Spacer(minLength: 70.0)
        Text(match.name).lineLimit(1).truncationMode(.tail)
      }
    }
  }
}

struct SearchView: View {
  let response = try! AssetReader().readJSON(SymbolSearchRs.self, path: "search_results.json")
  
  @State private var query : String = ""
  @State private var showCancelButton: Bool = false

  var body: some View {
    VStack {
      SearchBar(text: $query)
      
      List {
        ForEach(self.matches, id: \SymbolSearchRs.Match.symbol) { MatchView(match: $0)
        }
      }
      .navigationBarTitle("Search")
      .resignKeyboardOnDragGesture()
    }
  }

  var matches: [SymbolSearchRs.Match] {
    return response.bestMatches
  }
}

#if DEBUG
struct SearchView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
     SearchView()
      .environment(\.colorScheme, .light)

     SearchView()
      .environment(\.colorScheme, .dark)
    }
  }
}
#endif
