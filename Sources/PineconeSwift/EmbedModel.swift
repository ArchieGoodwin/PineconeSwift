//
//  EmbedModel.swift
//  Summarly
//
//  Created by Sergey Dikarev on 25.03.2023.
//

import Foundation

public struct EmbedModel: Codable {
    public let model: String
    public let input: [String]
    
    public init(model: String, input: [String]) {
        self.model = model
        self.input = input
    }
}


public struct EmbedResponse: Codable {
    public let object: String
    public let model: String
    public let data: [Embedding]
    public let usage: Usage

    public init(object: String, model: String, data: [Embedding], usage: Usage) {
        self.object = object
        self.model = model
        self.data = data
        self.usage = usage
    }
}

public struct Embedding: Codable {
    public let object: String
    public let embedding: [Double]
    public let index: Int
    
    public init(object: String, embedding: [Double], index: Int) {
        self.object = object
        self.embedding = embedding
        self.index = index
    }
}

public struct Usage: Codable {
    public let prompt_tokens: Int
    public let total_tokens: Int
    
    public init(prompt_tokens: Int, total_tokens: Int) {
        self.prompt_tokens = prompt_tokens
        self.total_tokens = total_tokens
    }
}

public struct EmbedResult: Codable {
    public let id: String? = UUID().uuidString
    public let index: Int
    public let embedding: [Double]
    public let text: String
    
    public init(index: Int, embedding: [Double], text: String) {
        self.index = index
        self.embedding = embedding
        self.text = text
    }
}
