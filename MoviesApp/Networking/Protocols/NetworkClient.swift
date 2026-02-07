//
//  NetworkClient.swift
//  MoviesApp
//
//  Created by bhagya sahoo on 07/02/26.
//

protocol NetworkClient {
    func send<E: Endpoint>(_ endpoint: E) async throws -> E.Response
}
