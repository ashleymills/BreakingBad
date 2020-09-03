//
//  SeaasonToggle.swift
//  Breaking Bad
//
//  Created by Ashley Mills on 03/09/2020.
//

import SwiftUI

struct SeaasonToggle: View {

    let season: Int
    @Binding var isOn: Bool

    var body: some View {
        Toggle(isOn: $isOn) {
            Text("\(season)")
        }
        .toggleStyle(SeasonToggleStyle())
    }
}

struct SeasonToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: { configuration.isOn.toggle() }) {
            VStack {
                if configuration.isOn {
                    Image(systemName: "checkmark.circle")
                } else {
                    Image(systemName: "circle")
                }
                configuration.label
            }
            .accentColor(configuration.isOn ? .bbHighlight : .gray)
        }
        .imageScale(.large)
        .padding(10)
    }
}

struct SeaasonToggle_Previews: PreviewProvider {

    static var _isOn: Bool = false
    static var isOn = Binding<Bool>(get: { _isOn }, set: { _isOn = $0 })

    static var previews: some View {
        VStack {
            SeaasonToggle(season: 1, isOn: .constant(false))
            SeaasonToggle(season: 2, isOn: .constant(true))
            SeaasonToggle(season: 3, isOn: isOn)
        }
        .previewLayout(.sizeThatFits)
    }
}
