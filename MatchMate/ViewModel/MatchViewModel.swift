//
//  MatchViewModel 2.swift
//  MatchMate
//
//  Created by Sagar Patel on 25/01/25.
//

import Foundation
import Combine

class MatchViewModel: ObservableObject {
    @Published var users: [UserEntity] = []
    private let coreDataManager = CoreDataManager.shared
    private var cancellables = Set<AnyCancellable>()
    private var service: FindMatchService
    
    init() {
        self.service = FindMatchService(apiService: ApiService(baseURL: "https://randomuser.me/api/?results=10"))
        fetchProfilesFromAPI()
        fetchCachedProfiles()
    }
    
    // MARK: - Fetch Cached Profiles
    func fetchCachedProfiles() {
        users = coreDataManager.fetchProfiles()
    }
    
    // MARK: - Fetch Profiles from API
    func fetchProfilesFromAPI() {
        service.fetchMatches()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error fetching profiles: \(error)")
                }
            }, receiveValue: { [weak self] fetchedUsers in
                self?.syncProfiles(fetchedUsers.results)
            })
            .store(in: &cancellables)
            
    }
    
    // MARK: - Sync Profiles with Core Data
    private func syncProfiles(_ fetchedUsers: [User]) {
        let cachedUserIDs = Set(users.map { $0.userId })
        
        for user in fetchedUsers {
            if !cachedUserIDs.contains(user.login?.uuid ?? "") {
                coreDataManager.addUser(
                    id: user.login?.uuid ?? "",
                    firstName: user.name?.first ?? "",
                    lastName: user.name?.last ?? "",
                    imageURL: user.picture?.large ?? "",
                    status: UserStatus.pending.rawValue,
                    city: user.location?.city ?? "",
                    state: user.location?.state ?? "",
                    country: user.location?.country ?? ""
                )
            }
        }
        
        fetchCachedProfiles()
    }
    
    // MARK: - Accept User
    func accept(user: UserEntity) {
        coreDataManager.updateUserStatus(id: user.userId ?? "", status: "Accepted")
        fetchCachedProfiles()
    }
    
    // MARK: - Decline User
    func decline(user: UserEntity) {
        coreDataManager.updateUserStatus(id: user.userId ?? "", status: "Declined")
        fetchCachedProfiles()
    }
}
