//
//  SwiftUIView.swift
//  myMoney
//
//  Created by Никита on 16.08.2022.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<10) { i in
                    GeometryReader { geo in
                        VStack {
                            Text("\(i) - value")
                                .frame(width: 200, height: 200, alignment: .leading)
                                .background(Color.mint)
                                .cornerRadius(30)
                        }
                        .rotation3DEffect(Angle(degrees: geo.frame(in: .global).minX - 30) / -20, axis: (x: 0, y: 10, z: 0))
                    }
                    .frame(width: 275, height: 275)
                }
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
