//
//  question.swift
//  Trivia
//
//  Created by Shoaib Ashfaq on 3/9/24.
//

import Foundation

struct Question{
    let question: String
    let options: [Options]
}

struct Options{
    let sent: String
    let isAns: Bool
}
