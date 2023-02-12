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

struct Completion: Decodable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let choices: [Choice]
    let usage: Usage
}

final class Service {
    
    enum Error: Swift.Error {
        case invalidURL
    }
    
    static func makeCompletion(with prompt: String) async throws -> Completion {
        guard let url = URL(string: "https://api.openai.com/v1/completions") else {
            throw Error.invalidURL
        }
        let json: [String: Any] = ["model": "text-davinci-003", "prompt": prompt, "temperature": 0, "max_tokens": 1000]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let openAIKey = dict.object(forKey: "openaiapikey") as? String else { throw Error.invalidURL }
            request.setValue("Bearer \(openAIKey)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let completion = try decoder.decode(Completion.self, from: data)
        return completion
    }
}
