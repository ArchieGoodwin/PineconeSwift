//
//  PineconeApi.swift
//  Summarly
//
//  Created by Sergey Dikarev on 25.03.2023.
//

import Foundation


public class PineconeSwift {
    fileprivate(set) var apikey: String
    fileprivate(set) var baseURL: String
    
    public init(apikey: String, baseURL: String) {
        self.apikey = apikey
        self.baseURL = baseURL
    }
}


extension PineconeSwift {
    
    public func queryVectors(with vector: EmbedResult, namespace: String, topK: Int, includeValues: Bool = true, includeMetadata: Bool, endpoint: PineconeEndpoint = .query) async throws -> [PineconeVector] {
    
        let pineconeVector = PineconeVector(id: vector.id!, values: vector.embedding, metadata: ["text": vector.text], score: nil)
        
        let body = PineconeQueryRequest(vector: pineconeVector.values, namespace: namespace, topK: topK, includeValues: includeValues, includeMetadata: includeMetadata, id: nil)
        let request = prepareRequest(endpoint, body: body)
        
        let session = URLSession.shared
        let (data, _) = try await session.data(for: request)
        print(NSString(string: String(decoding: data, as: UTF8.self)))

        let res = try JSONDecoder().decode(PineconeQueryResponse.self, from: data)
        
        return res.matches
        
    }
    
    public func fetchVectors(with ids: [String], namespace: String?, endpoint: PineconeEndpoint = .fetch) async throws -> [PineconeVector] {
    
        let body = PineconeFetchRequest(namespace: namespace, ids: ids)
        let request = prepareRequest(endpoint, body: body)
        
        let session = URLSession.shared
        let (data, _) = try await session.data(for: request)
        print(NSString(string: String(decoding: data, as: UTF8.self)))

        let res = try JSONDecoder().decode(PineconeFetchResponse.self, from: data)
        
        return res.vectors.additionalProp
        
    }
    
    
    public func upsertVectors(with vectors: [EmbedResult], namespace: String, endpoint: PineconeEndpoint = .upsert) async throws -> Bool {
        
        let pineconeVectors = vectors.map { embRes in
            return PineconeVector(id: embRes.id!, values: embRes.embedding, metadata: ["text" : embRes.text], score: nil)
        }
        
        let body = PineconeInsertRequest( vectors: pineconeVectors, namespace: namespace)
        let request = prepareRequest(endpoint, body: body)
        
        let session = URLSession.shared
        let (data, response) = try await session.data(for: request)
        print(NSString(string: String(decoding: data, as: UTF8.self)))

        let res = try JSONDecoder().decode(PineconeUpsertResponse.self, from: data)
        print("upsertVectors", res.upsertedCount)
        if let httpResponse = response as? HTTPURLResponse {
            print("Status Code: \(httpResponse.statusCode)")
            return httpResponse.statusCode >= 200 && httpResponse.statusCode < 300
        }
        
        return false
        
    }
    
    public func updateVectors(with vector: EmbedResult, metadata: [String: String], namespace: String, id: String, endpoint: PineconeEndpoint = .update) async throws -> Bool {
      
        
        let body = PineconeUpdateRequest(setMetadata: metadata, namespace: namespace, id: id, values: vector.embedding)
        let request = prepareRequest(endpoint, body: body)
        
        let session = URLSession.shared
        let (data, response) = try await session.data(for: request)
        print(NSString(string: String(decoding: data, as: UTF8.self)))

        let res = try JSONDecoder().decode(PineconeUpsertResponse.self, from: data)
        print("upsertVectors", res.upsertedCount)
        if let httpResponse = response as? HTTPURLResponse {
            print("Status Code: \(httpResponse.statusCode)")
            return httpResponse.statusCode >= 200 && httpResponse.statusCode < 300
        }
        
        return false
        
    }
    
    
    private func prepareRequest<BodyType: Encodable>(_ endpoint: PineconeEndpoint, body: BodyType) -> URLRequest {
        var urlComponents = URLComponents(url: URL(string: baseURL)!, resolvingAgainstBaseURL: true)
        urlComponents?.path = endpoint.path
        var request = URLRequest(url: urlComponents!.url!)
        request.httpMethod = endpoint.method

        request.setValue(self.apikey, forHTTPHeaderField: "Api-Key")
        
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("application/json", forHTTPHeaderField: "accept")

        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(body) {
            request.httpBody = encoded
        }
        
        return request
    }
}


public enum PineconeEndpoint {
    case upsert
    case query
    case update
    case fetch
}


public extension PineconeEndpoint {
    var path: String {
        switch self {
            case .upsert:
                return "/vectors/upsert"
            case .query:
                return "/query"
            case .update:
                return "/vectors/update"
            case .fetch:
                return "/vectors/fetch"
        }
    }
    
    var method: String {
        switch self {
            case .upsert:
                return "POST"
            case .query:
                return "POST"
            case .update:
                return "POST"
            case .fetch:
                return "GET"
        }
    }
    
   
}
