//
//  Service.swift
//  Writing
//
//  Created by Omar Torres on 25/01/23.
//

import Foundation

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

final class Service {
    
    static let completionsURL = "https://api.openai.com/v1/completions"
    static let davinciModel = "text-davinci-003"
    static let temperature = 0
    static let maxTokens = 1000
    
    enum Error: Swift.Error {
        case invalidURL
        case plistFailed
    }
    
    static func completionsUrlRequest(url: URL, openAIKey: String, jsonData: Data?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(openAIKey)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    static func makeCompletion(with prompt: String) async throws -> TextCompletion {
        guard let url = URL(string: completionsURL) else { throw Error.invalidURL }
        
        let json: [String: Any] = ["model": "text-davinci-003", "prompt": prompt, "temperature": 0, "max_tokens": 1000]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let openAIKey = dict.object(forKey: "openaiapikey") as? String else { throw Error.plistFailed }
        let request = completionsUrlRequest(url: url, openAIKey: openAIKey, jsonData: jsonData)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let completion = try decoder.decode(TextCompletion.self, from: data)
        return completion
    }
}
