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
  var height: CGFloat
  
  var body: some View {
    VStack(spacing: 5) {
      CommonLabel(text: title)
        .padding(.top)
      CommonLabel(text: date.toYMDForm())
      CommonLabel(text: contents, lineLimit: 2)
        .padding(.bottom)
      Spacer()
    }
    .frame(maxWidth: .infinity, minHeight: height, maxHeight: height)
    .foregroundColor(Color.black)
    .background(Color.init(red: 224/255, green: 224/255, blue: 224/255))
    .clipShape(RoundedRectangle(cornerRadius: spacing/2))
  }
}

struct CommonLabel: View {
  var text: String
  var lineLimit = 1
  
  init(text: String, lineLimit: Int = 1) {
    self.text = text
    self.lineLimit = lineLimit
  }
  
  var body: some View {
    HStack {
      Text(text)
        .lineLimit(lineLimit)
        .truncationMode(.tail)
        .padding(.leading, 6)
        .padding(.trailing, 6)
        .multilineTextAlignment(.leading)
        .minimumScaleFactor(0.4)
      Spacer()
    }
  }
}

struct IssueListItemView_Previews: PreviewProvider {
  static var previews: some View {
    IssueListItemView(
      title: "title",
      date: "date",
      contents: "contents",
      height: 180
    )
  }
}

private extension String {
  func toYMDForm(_ separator: String = "-") -> String {
    let dateAndTime = self.split(separator: "T")
    
    return String(dateAndTime.first ?? "")
      + " "
      + String(dateAndTime.last?.prefix(5) ?? "")
  }
}
