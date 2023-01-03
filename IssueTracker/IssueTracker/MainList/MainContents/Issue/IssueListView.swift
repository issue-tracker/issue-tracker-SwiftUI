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
      MainContentsListGridView<IssueListEntity, NavigationLink<IssueListItemView, IssueDetailView>>(
        proxy,
        rowNumber: $viewModel.gridRowNumber,
        identifiables: $viewModel.issueLists
      ) { entity in
        
        NavigationLink(destination: IssueDetailView()) {
          
          IssueListItemView(
            title: entity.title,
            date: entity.createdAt ?? "",
            contents: entity.comments.first?.content ?? "",
            height: proxy.size.height / 3.5)
        }
      }
    }
  }
}

struct IssueListView_Previews: PreviewProvider {
  static var previews: some View {
    IssueListView()
  }
}
