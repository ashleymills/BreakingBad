//
//  CharacterScreen.swift
//  Breaking Bad
//
//  Created by Ashley Mills on 02/09/2020.
//

import SwiftUI

struct CharacterScreen: View {

    @ObservedObject var character: CharacterViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack {
                switch character.image.type {
                case .loading:
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .bbHighlight))
                        .frame(height: 300)
                case .failed:
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .padding()
                case let .loaded(image):
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                }
                HStack {
                    VStack(alignment: .textAlignment, spacing: 5) {
                        details(title: "Name", value: character.name)
                        details(title: "Occupation", value: character.occupation)
                        details(title: "Status", value: character.status)
                        details(title: "Nickname", value: character.nickname)
                        details(title: "Seasons", value: character.seasons)
                    }
                    .padding(.horizontal, 10)
                    Spacer(minLength: 0)
                }
                .padding(.bottom, 10)
            }
            .navigationTitle(character.name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                                    Button(action: dismiss) {
                                        Image(systemName: "xmark")
                                            .padding([.vertical, .leading])
                                            .accentColor(.bbHighlight)
                                })
        }
    }

    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }

    func details(title: String, value: String) -> some View {
        HStack(alignment: .top) {
            Text("\(title):")
                .font(Font.subheadline.weight(.bold))
                .alignmentGuide(.textAlignment) { $0[.trailing] }
            Text(value)
                .font(.subheadline)
        }
    }
}

extension HorizontalAlignment {
    private enum TextAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[HorizontalAlignment.center]
        }
    }
    static let textAlignment = HorizontalAlignment(TextAlignment.self)
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                CharacterScreen(character: .walterLoaded)
            }
            NavigationView {
                CharacterScreen(character: .cousinsLoaded)
            }
                .preferredColorScheme(.dark)
            NavigationView {
                CharacterScreen(character: .walterLoading)
            }
            NavigationView {
                CharacterScreen(character: .cousinsFailed)
            }
            .preferredColorScheme(.dark)
        }
    }
}
