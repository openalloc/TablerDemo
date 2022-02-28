//
//  Fruit.swift
//
// Copyright 2022 FlowAllocator LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import SwiftUI

struct Fruit: Identifiable {
    var id: String
    var name: String
    var weight: Double
    var color: Color
    init(_ id: String = "",
         _ name: String = "",
         _ weight: Double = 0,
         _ color: Color = .gray) {
        self.id = id
        self.name = name
        self.weight = weight
        self.color = color
    }
    
    static var bootstrap: [Fruit] = [
        Fruit("🍌", "Banana", 118, .brown),
        Fruit("🍓", "Strawberry", 12, .red),
        Fruit("🍊", "Orange", 190, .orange),
        Fruit("🥝", "Kiwi", 75, .green),
        Fruit("🍇", "Grape", 7, .purple),
        Fruit("🫐", "Blueberry", 2, .blue),
    ]
}
