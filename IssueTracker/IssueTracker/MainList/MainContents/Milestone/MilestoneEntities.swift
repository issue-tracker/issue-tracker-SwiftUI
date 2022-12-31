//
//  MilestoneEntities.swift
//  IssueTracker
//
//  Created by 백상휘 on 2022/12/31.
//

import Foundation

struct AllMilestoneEntity: Codable {
  let openedMilestones: [MilestoneListEntity]
  let closedMilestones: [MilestoneListEntity]
}

struct MilestoneListEntity: Codable {
  let id: Int
  let title: String
  let description: String?
  let dueDate: String?
  let openIssueCount: Int
  let closedIssueCount: Int
  let closed: Bool
  
  func getDateCreated() -> Date? {
    guard let dueDate = dueDate else {
      return nil
    }
    
    return DateFormatter().date(from: dueDate)
  }
}

struct MilestoneInIssueEntity: Decodable {
  let id: Int
  let title: String
}
