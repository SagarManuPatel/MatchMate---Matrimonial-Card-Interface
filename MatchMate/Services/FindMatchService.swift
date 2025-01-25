//
//  FindMatchService.swift
//  MatchMate
//
//  Created by Sagar Patel on 25/01/25.
//

import Combine

class FindMatchService {
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func fetchMatches(endPoint: String = "") -> AnyPublisher<APIResponse, Error> {
        apiService.fetch(endpoint: endPoint, type: APIResponse.self)
    }
}
