//
//  Home.swift
//  NBA-IOS-App
//
//  Created by Willy Merlet on 21/03/22.
//

import SwiftUI

struct Home: View {
    @StateObject var playerData: PlayerListViewModel = PlayerListViewModel()
    @StateObject var viewModel = PlayerListViewModel()
    var body: some View {
        
        VStack{
            
            // Top Nav Bar...
            Button {
                
            } label: {
                
                Image("menu")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .overlay(
            
                Text("NBA material")
                    .font(.title.bold())
            )
            .foregroundColor(.black)
            .padding()

            // Users Stack...
            ZStack{
                
//                if (playerData.fetchPlayers()) {
                    
//                    if players.isEmpty{
//                        Text("Come back later we can find more matches for you!")
//                            .font(.caption)
//                            .foregroundColor(.gray)
//                    }
//                    else{
                        
                        // Displaying Cards...
                        // Cards are reversed since its Zstack..
                        // you can use reverse here...
                        // or you can use while fetching users...
                    ForEach(playerData.players){ player in
                            
                            // Card View...
                            StackCardView(player: player)
                                .environmentObject(playerData)
                        }
//                    }
//                }
//                else{
//                    ProgressView()
//                }
//            }
            }
            .padding(.top,30)
            .padding()
            .padding(.vertical)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Action Buttons....
            HStack(spacing: 15){
                
                Button {
                    
                } label: {
                    
                    Image(systemName: "arrow.uturn.backward")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(13)
                        .background(Color("Gray"))
                        .clipShape(Circle())
                }
                
                Button {
                    doSwipe(rightSwipe: true)
                } label: {
                    
                    Image(systemName: "xmark")
                        .font(.system(size: 20, weight: .black))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(18)
                        .background(Color.red)
                        .clipShape(Circle())
                }
                
                Button {
                    
                } label: {
                    
                    Image(systemName: "star.fill")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(13)
                        .background(Color.yellow)
                        .clipShape(Circle())
                }
                
                Button {
                    doSwipe()
                } label: {
                    
                    Image(systemName: "heart.fill")
                        .font(.system(size: 20, weight: .black))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(18)
                        .background(Color.green)
                        .clipShape(Circle())
                }

            }
            .padding(.bottom)
//            .disabled(playerData.displaying_players?.isEmpty ?? false)
//            .opacity((playerData.displaying_players?.isEmpty ?? false) ? 0.6 : 1)
        }
        .onAppear {
            Task {
                do {
                    try await playerData.fetchPlayers()
                } catch {
                    print("❌Error: \(error)")
                }
               
            }
         
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    func doSwipe(rightSwipe: Bool = false){
        
        guard let first = playerData.players.last else{
            return
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("ACTIONFROMBUTTON"), object: nil, userInfo: [
        
            "id": first.id,
            "rightSwipe": rightSwipe
        ])
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
