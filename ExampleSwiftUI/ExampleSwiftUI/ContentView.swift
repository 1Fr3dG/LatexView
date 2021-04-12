//
//  ContentView.swift
//  ExampleSwiftUI
//
//  Created by 高宇 on 2021/4/12.
//

import SwiftUI
import ALLatexView

struct ContentView: View {
    @State var latex = #"$$\dfrac{-b+\sqrt{b^2-4ac}}{2a}$$"#
    @State var latexHeight:CGFloat? = 0
    var body: some View {
        VStack{
        Text("View Test")
            .frame(width: 200.0, height: 150.0)
            .padding(0.0)

        LatexView($latex, height: $latexHeight)
            .background(Color.purple)
            .frame(height: latexHeight)
            .padding()
        
        TextEditor(text: $latex)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
