//
//  AnswerView.swift
//  TCAPractice
//
//  Created by S J on 1/2/24.
//

import Foundation
import SwiftUI

//question Id is key
let answerViewsDict: [Int: [Int: any View]] = [1:
                                  [
                                    1: VStack {
                                        Text("Welcome to SwiftUI")
                                            .font(.headline)
                                        Button("Click Me") {
                                            print("Button tapped")
                                        }
                                    },
                                    2: VStack {
                                        Text("Welcome to SwiftUI")
                                            .font(.headline)
                                        Button("Click Me") {
                                            print("Button tapped")
                                        }
                                    .background(Color.blue)
                                    },
                                    3: VStack {
                                        Text("Welcome to SwiftUI")
                                            .font(.headline)
                                        Button("Click Me") {
                                            print("Button tapped")
                                        }
                                    .background(Color.red)
                                    },
                                    4: VStack {
                                        Text("Welcome to SwiftUI")
                                            .font(.headline)
                                        Button("Click Me") {
                                            print("Button tapped")
                                        }
                                    .background(Color.green)
                                    }
                                  ],
                                   2:[
                                    1: VStack {
                                        Text("Welcome to SwiftUI")
                                            .font(.headline)
                                        Button("Click Me") {
                                            print("Button tapped")
                                        }
                                    },
                                    2: VStack {
                                        Text("Welcome to SwiftUI")
                                            .font(.headline)
                                        Button("Click Me") {
                                            print("Button tapped")
                                        }
                                    .background(Color.blue)
                                    },
                                    3: VStack {
                                        Text("Welcome to SwiftUI")
                                            .font(.headline)
                                        Button("Click Me") {
                                            print("Button tapped")
                                        }
                                    .background(Color.red)
                                    },
                                    4: VStack {
                                        Text("Welcome to SwiftUI")
                                            .font(.headline)
                                        Button("Click Me") {
                                            print("Button tapped")
                                        }
                                    .background(Color.green)
                                    }
                                   ],
                                   3: [
                                    1: VStack {
                                        Text("Welcome to SwiftUI")
                                            .font(.headline)
                                        Button("Click Me") {
                                            print("Button tapped")
                                        }
                                    },
                                    2: VStack {
                                        Text("Welcome to SwiftUI")
                                            .font(.headline)
                                        Button("Click Me") {
                                            print("Button tapped")
                                        }
                                    .background(Color.blue)
                                    },
                                    3: VStack {
                                        Text("Welcome to SwiftUI")
                                            .font(.headline)
                                        Button("Click Me") {
                                            print("Button tapped")
                                        }
                                    .background(Color.red)
                                    },
                                    4: VStack {
                                        Text("Welcome to SwiftUI")
                                            .font(.headline)
                                        Button("Click Me") {
                                            print("Button tapped")
                                        }
                                    .background(Color.green)
                                    }
                                   ]
]

