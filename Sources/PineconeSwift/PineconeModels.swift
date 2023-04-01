//
//  PineconeModels.swift
//  Summarly
//
//  Created by Sergey Dikarev on 25.03.2023.
//

import Foundation


public struct PineconeInsertRequest: Codable {
    let vectors: [PineconeVector]
    let namespace: String
    
    public init(vectors: [PineconeVector], namespace: String) {
        self.vectors = vectors
        self.namespace = namespace
    }
}

public struct PineconeQueryRequest: Codable {
    let vector: [Double]
    let namespace: String
    let topK: Int
    let includeValues: Bool
    let includeMetadata: Bool
    let id: String?
    
    public init(vector: [Double], namespace: String, topK: Int, includeValues: Bool, includeMetadata: Bool, id: String?) {
        self.vector = vector
        self.namespace = namespace
        self.topK = topK
        self.includeValues = includeValues
        self.includeMetadata = includeMetadata
        self.id = id
    }
}


public struct PineconeVector: Codable {
    let id: String
    let values: [Double]
    let metadata: [String: String]
    let score: Double?
    
    public init(id: String, values: [Double], metadata: [String : String], score: Double?) {
        self.id = id
        self.values = values
        self.metadata = metadata
        self.score = score
    }
}

public struct PineconeQueryResponse: Codable {
    let matches: [PineconeVector]
    let namespace: String
    
    public init(matches: [PineconeVector], namespace: String) {
        self.matches = matches
        self.namespace = namespace
    }
}

public struct PineconeUpsertResponse: Codable {
    let upsertedCount: Int
    
    public init(upsertedCount: Int) {
        self.upsertedCount = upsertedCount
    }
}

public struct PineconeUpdateRequest: Codable {
    let setMetadata: [String: String]
    let namespace: String
    let id: String
    let values: [Double]
    
    public init(setMetadata: [String : String], namespace: String, id: String, values: [Double]) {
        self.setMetadata = setMetadata
        self.namespace = namespace
        self.id = id
        self.values = values
    }
}

public struct PineconeFetchRequest: Codable {
    let namespace: String?
    let ids: [String]
    
    public init(namespace: String?, ids: [String]) {
        self.namespace = namespace
        self.ids = ids
    }
}

public struct PineconeFetchResponse: Codable {
    let vectors: FetchVectors
    let namespace: String
    
    public init(vectors: FetchVectors, namespace: String) {
        self.vectors = vectors
        self.namespace = namespace
    }
}

public struct FetchVectors: Codable {
    let additionalProp: [PineconeVector]
    
    public init(additionalProp: [PineconeVector]) {
        self.additionalProp = additionalProp
    }
}
