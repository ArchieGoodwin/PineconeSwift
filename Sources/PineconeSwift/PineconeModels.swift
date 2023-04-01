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
}

public struct PineconeQueryRequest: Codable {
    let vector: [Double]
    let namespace: String
    let topK: Int
    let includeValues: Bool
    let includeMetadata: Bool
    let id: String?
}


public struct PineconeVector: Codable {
    let id: String
    let values: [Double]
    let metadata: [String: String]
    let score: Double?
}

public struct PineconeQueryResponse: Codable {
    let matches: [PineconeVector]
    let namespace: String
}

public struct PineconeUpsertResponse: Codable {
    let upsertedCount: Int
}

public struct PineconeUpdateRequest: Codable {
    let setMetadata: [String: String]
    let namespace: String
    let id: String
    let values: [Double]
}

public struct PineconeFetchRequest: Codable {
    let namespace: String?
    let ids: [String]
}

public struct PineconeFetchResponse: Codable {
    let vectors: FetchVectors
    let namespace: String
}

public struct FetchVectors: Codable {
    let additionalProp: [PineconeVector]
}
