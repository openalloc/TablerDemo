//
//  FruitToolbar.swift
//
// Copyright 2021, 2022 OpenAlloc LLC
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

struct FruitToolbar: ToolbarContent {
    @Binding var headerize: Bool
    @Binding var footerize: Bool
    @Binding var colorize: Bool

    var body: some ToolbarContent {
        ToolbarItemGroup {
            Toggle(isOn: $colorize) { Image(systemName: colorize ? "paintpalette.fill" : "paintpalette") }
            Toggle(isOn: $headerize) { Image(systemName: headerize ? "arrow.up.square.fill" : "arrow.up.square") }
            Toggle(isOn: $footerize) { Image(systemName: footerize ? "arrow.down.square.fill" : "arrow.down.square") }
        }
    }
}
