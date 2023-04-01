//
//  EmbedModel.swift
//  Summarly
//
//  Created by Sergey Dikarev on 25.03.2023.
//

import Foundation

public struct EmbedModel: Codable {
    let model: String
    let input: [String]
}


public struct EmbedResponse: Codable {
    let object: String
    let model: String
    let data: [Embedding]
    let usage: Usage

}

public struct Embedding: Codable {
    let object: String
    let embedding: [Double]
    let index: Int
}

public struct Usage: Codable {
    let prompt_tokens: Int
    let total_tokens: Int
}

public struct EmbedResult: Codable {
    let id: String? = UUID().uuidString
    let index: Int
    let embedding: [Double]
    let text: String
    
}
