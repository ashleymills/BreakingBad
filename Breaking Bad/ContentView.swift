//
//  HomeScreen.swift
//  Breaking Bad
//
//  Created by Ashley Mills on 02/09/2020.
//

import SwiftUI
import Combine

struct HomeScreen: View {

    @StateObject var viewModel = CharacterListViewModel()

    private let columns = Array(repeatElement(GridItem(.flexible(minimum: 0, maximum: .greatestFiniteMagnitude)), count: 2))
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.characters) { character in
                    NavigationLink(
                        destination: CharacterDetailView(character: character),
                        label: {
                            CharacterView(character: character)
                                .onAppear {
                                    viewModel.loadImage(for: character)
                                }
                        })
                }
            }
            .padding(10)
        }
        .alert(item: $viewModel.error) { error in
            Alert(title: Text("Error loading characters"), message: Text(error.localizedDescription), primaryButton: .default(Text("Retry"), action: viewModel.fetch), secondaryButton: .cancel(Text("OK")))
        }
        .onAppear(perform: loadCharacters)
        .navigationTitle("Breaking Bad Cast")
    }

    func loadCharacters() {
        viewModel.fetch()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeScreen()
        }
    }
}
