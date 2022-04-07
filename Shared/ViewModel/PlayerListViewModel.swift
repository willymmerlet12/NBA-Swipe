//
//  PlayerListViewModel.swift
//  NBA-IOS-App
//
//  Created by Willy Merlet on 21/03/22.
//

import SwiftUI

class PlayerListViewModel: ObservableObject {

    @Published var players = [Player]()
    @Published var displaying_players: [Player]?
    
    func fetchPlayers() async throws {
        let urlString = Constants.baseURL + Endpoints.players
        
        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        
        let playerResponse: [Player] = try await HttpClient.shared.fetch(url: url)
        
        DispatchQueue.main.async {
            self.players = playerResponse
        }
    }
    
//    func delete(at offsets: IndexSet) {
//        offsets.forEach { i in
//            guard let playerID = players[i].id else {
//                return
//            }
//
//            guard let url = URL(string: Constants.baseURL + Endpoints.players + "/\(playerID)") else {
//                return
//            }
//
//            Task {
//                do {
//                    try await HttpClient.shared.delete(at: playerID, url: url)
//                } catch {
//                    print("❌Error: \(error)")
//                }
//            }
//        }
//
//        players.remove(atOffsets: offsets)
//
//    }
    
    func getIndex(player: Player)->Int{
        
        let index = players.firstIndex(where: { currentPlayer in
            return player.id == currentPlayer.id
        }) ?? 0
        
        return index
    }
}
