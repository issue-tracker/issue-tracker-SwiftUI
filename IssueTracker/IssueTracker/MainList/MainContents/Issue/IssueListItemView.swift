//
//  IssueListItemView.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/30.
//

import SwiftUI

struct IssueListItemView: View {
  
  var title: String
  var date: String
  var contents: String
  
  var body: some View {
    VStack(spacing: 5) {
      Text(title)
      Text(date)
      Text(contents)
      Spacer()
    }
    .background(Color.white)
    .clipShape(RoundedRectangle(cornerRadius: spacing/2))
  }
}

struct IssueListItemView_Previews: PreviewProvider {
  static var previews: some View {
    IssueListItemView(
      title: "title",
      date: "date",
      contents: "contents")
  }
}
