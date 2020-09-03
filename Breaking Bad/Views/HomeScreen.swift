//
//  HomeScreen.swift
//  Breaking Bad
//
//  Created by Ashley Mills on 02/09/2020.
//

import SwiftUI
import Combine

struct HomeScreen: View {

    @StateObject var viewModel: CharacterListViewModel
    @State var showingCharacter: CharacterViewModel?

    private let columns = Array(repeatElement(GridItem(.flexible(minimum: 0, maximum: .greatestFiniteMagnitude)), count: 2))

    init(viewModel: CharacterListViewModel = CharacterListViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Group {
            if viewModel.characters.isEmpty {
                LoadingView()
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(viewModel.characters) { character in
                            Button(action: { showingCharacter = character }) {
                                CharacterView(character: character)
                                    .onAppear {
                                        viewModel.loadImage(for: character)
                                    }
                            }
                        }
                    }
                    .padding(10)
                }
            }
        }
        .background(Color.bbBackground.edgesIgnoringSafeArea(.all))
        .onAppear(perform: loadCharacters)
        .navigationTitle("Breaking Bad")
        .alert(item: $viewModel.error) { error in
            Alert(title: Text("Error loading characters"), message: Text(error.localizedDescription), primaryButton: .default(Text("Retry"), action: viewModel.fetch), secondaryButton: .cancel(Text("OK")))
        }
        .sheet(item: $showingCharacter) { character in
            NavigationView {
                CharacterScreen(character: character)
            }
        }
    }

    func LoadingView() -> some View {
        VStack {
            Text("Loading")
                .foregroundColor(.bbHighlight)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .bbHighlight))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    func loadCharacters() {
        viewModel.fetch()
    }
}

struct ContentView_Previews: PreviewProvider {

    static let characterData: Data = {
        Bundle.main.url(forResource: "BB", withExtension: "json")
            .flatMap { try? Data(contentsOf: $0)} ?? Data()
    }()

    static let sessionData = [
        URL(string: "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_the-cousins-lg.jpg")!: UIImage(named: "cousins")!.pngData()!,
        URL(string:"https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg")!: UIImage(named: "walter")!.pngData()!,
        Endpoint.characters.url: characterData
    ]

    static let session = MockSession(data: sessionData)

    static var previews: some View {
        NavigationView {
            HomeScreen(viewModel: CharacterListViewModel(session: session))
        }
    }
}
