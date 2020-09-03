//
//  CharacterView.swift
//  Breaking Bad
//
//  Created by Ashley Mills on 02/09/2020.
//

import SwiftUI

struct CharacterView: View {

    @ObservedObject var character: CharacterViewModel

    init(character: CharacterViewModel) {
        self.character = character
    }

    var body: some View {
        ZStack {
            switch character.image.type {
            case .loading:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .bbHighlight))
            case .failed:
                Image(systemName: "person")
                    .resizable()
                    .padding()
                    .scaledToFill()
                    .layoutPriority(-1)
            case let .loaded(image):
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .layoutPriority(-1)
            }
            bannerView()
        }
        .cornerRadius(10)
        .clipped()
        .aspectRatio(1, contentMode: .fit)
    }

    func bannerView() -> some View {
        VStack(alignment: .center) {
            Spacer()
            Text(character.name)
                .multilineTextAlignment(.center)
                .font(Font.subheadline.weight(.bold))
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(BlurView())
        }
    }
}

struct BlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialDark))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: .systemThinMaterialDark)
    }
}

struct CharacterView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            CharacterView(character: .loading)
                .previewLayout(.fixed(width: 150.0, height: 150.0))
            CharacterView(character: .loaded)
                .previewLayout(.fixed(width: 150.0, height: 150.0))
            CharacterView(character: .failed)
                .previewLayout(.fixed(width: 150.0, height: 150.0))
            CharacterView(character: .loaded)
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: 150.0, height: 150.0))
        }
    }
}
