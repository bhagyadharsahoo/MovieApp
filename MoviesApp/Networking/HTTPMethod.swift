//
//  HTTPMethod.swift
//  MoviesApp
//
//  Created by bhagya sahoo on 07/02/26.
//


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case statusCode(Int)
    case decoding(Error)
    case underlying(Error)
}
