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
    NavigationView {
      GeometryReader { proxy in
        MainContentsListGridView<IssueListEntity, NavigationLink<IssueListItemView, IssueDetailView>>(
          proxy,
          rowNumber: $viewModel.gridColumnNumber,
          identifiables: $viewModel.issueLists
        ) { entity in
          
          NavigationLink(destination: IssueDetailView()) {
            
            IssueListItemView(
              title: entity.title,
              date: entity.createdAt ?? "",
              contents: entity.comments.first?.content ?? "",
              height: proxy.size.height / viewModel.gridRowNumber)
          }
        }.animation(.easeIn(duration: 0.2))
      }
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
          Button(action: {
            viewModel.gridColumnNumber = .one
          }, label: {
            Image(systemName: "rectangle.grid.1x2.fill")
              .foregroundColor(viewModel.getToolbarGridButtonColor(.one).toColor())
          })
          Button(action: {
            viewModel.gridColumnNumber = .two
          }, label: {
            Image(systemName: "rectangle.grid.2x2.fill")
              .foregroundColor(viewModel.getToolbarGridButtonColor(.two).toColor())
          })
          Button(action: {
            viewModel.gridColumnNumber = .three
          }, label: {
            Image(systemName: "square.grid.3x2.fill")
              .foregroundColor(viewModel.getToolbarGridButtonColor(.three).toColor())
          })
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
