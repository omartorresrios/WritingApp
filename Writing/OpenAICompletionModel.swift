//
//  OpenAICompletionModel.swift
//  Writing
//
//  Created by Omar Torres on 13/02/23.
//

struct Choice: Decodable {
    let text: String
    let finishReason: String
    let index: Int
}

struct Usage: Decodable {
    let promptTokens: Int
    let completionTokens: Int
    let totalTokens: Int
}

struct TextCompletion: Decodable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let choices: [Choice]
    let usage: Usage
}
