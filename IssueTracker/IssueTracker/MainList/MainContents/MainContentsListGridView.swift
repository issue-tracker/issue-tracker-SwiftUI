//
//  MainContentsListGridView.swift
//  IssueTracker
//
//  Created by 백상휘 on 2023/01/03.
//

import SwiftUI

struct MainContentsListGridView<Item: Hashable, ContentsView: View>: View {
  
  typealias HandlerType = (Item) -> (ContentsView)
  
  let geometryProxy: GeometryProxy
  let itemHandler: HandlerType
  
  @Binding
  var rowNumber: MainContentsGridRowNumber
  @Binding
  var identifiables: [Item]
  
  init(
    _ proxy: GeometryProxy,
    rowNumber: Binding<MainContentsGridRowNumber>,
    identifiables: Binding<[Item]>,
    itemHandler: @escaping HandlerType
  ) {
    
    self.geometryProxy = proxy
    self.itemHandler = itemHandler
    self._rowNumber = rowNumber
    self._identifiables = identifiables
  }
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: getLayout(geometryProxy), spacing: spacing) {
        ForEach(identifiables, id: \.hashValue) {
          itemHandler($0)
        }
      } // end of LazyVGrid
    } // end of ScrollView
  }
  
  private func getLayout(_ proxy: GeometryProxy) -> [GridItem] {
    var width = proxy.size.width / CGFloat(rowNumber.rawValue)
    
    width -= (spacing * CGFloat(3 - rowNumber.rawValue))
    
    return Array(
      repeating: GridItem(.fixed(width)),
      count: rowNumber.rawValue)
  }
}
