//
//  MainContentsListView.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/30.
//

import SwiftUI

struct MainContentsListView: View {
  var body: some View {
    GeometryReader { proxy in
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          IssueListView()
            .frameFitSize(proxy.size)
          LabelListView()
            .frameFitSize(proxy.size)
          MilestoneListView()
            .frameFitSize(proxy.size)
        }
      }
    }
  }
}

struct MainContentsListViewModifier: ViewModifier {
  
  private var frame: CGSize
  
  init(frame: CGSize) {
    self.frame = frame
  }
  
  func body(content: Content) -> some View {
    content
      .frame(width: frame.width, height: frame.height)
  }
}

private extension View {
  func frameFitSize(_ size: CGSize) -> some View {
    ModifiedContent(content: self, modifier: MainContentsListViewModifier(frame: size))
  }
}

struct MainContentsListView_Previews: PreviewProvider {
  static var previews: some View {
    MainContentsListView()
  }
}
