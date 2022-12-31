//
//  IssueListView.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/30.
//

import SwiftUI

struct IssueListView: View {
  
  @ObservedObject
  var viewModel = IssueListViewModel()
  
  var body: some View {
    GeometryReader { proxy in
      ScrollView(spacing: spacing) {
        LazyVGrid(columns: getLayout(proxy)) {
          ForEach(
            viewModel.issueLists,
            id: \.self
          ) { issue in
            
            NavigationLink(destination: IssueDetailView()) {
              
              IssueListItemView(
                title: issue.title,
                date: issue.createdAt ?? "",
                contents: issue.comments.first?.content ?? "")
              .frame(height: proxy.size.height / 3.5)
            }
          }
        } // end of LazyVGrid
      } // end of ScrollView
    } // end of GeometryReader
  }
  
  private func getLayout(_ proxy: GeometryProxy) -> [GridItem] {
    Array(
      repeating: GridItem(.adaptive(
        minimum: proxy.size.width / CGFloat(viewModel.gridRowNumber.rawValue),
        maximum: proxy.size.width)),
      count: viewModel.gridRowNumber.rawValue)
  }
}

struct IssueListView_Previews: PreviewProvider {
  static var previews: some View {
    IssueListView()
  }
}
