# PineconeSwift

PineconeSwift is an open-source Swift Package designed to seamlessly integrate Pinecone, a powerful vector database, into your Swift applications. With PineconeSwift, you can easily leverage Pinecone's capabilities to efficiently store and query high-dimensional vectors, enabling you to build state-of-the-art machine learning and recommendation systems.

## Features

- **Effortless integration** with Pinecone, a high-performance vector database
- Support for **key database operations**, including upsert, query, fetch, and update
- **Intuitive and easy-to-use API** designed specifically for Swift developers
- Built with **performance and scalability** in mind, suitable for various application types
- Thoroughly **tested and documented**, ensuring a smooth development experience

PineconeSwift is your go-to solution for integrating Pinecone's cutting-edge vector database technology into your Swift projects, enabling you to build advanced, scalable, and robust applications with ease.

## Usage 

For example for upsert:

Create an array of EmbedResult structs: 

```
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
```
Then simply create PineconeSwift object and call for upsert method:

```            
let pai = PineconeSwift(apikey: {your_Pinecone_API_key}}, baseURL: {your Pinecone_base_url_to_index}})

let result = try await pai.upsertVectors(with: embeddings, namespace: {string}})
```
