//
//  SelectBorder.swift
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

/// View that can be used to indicated a selected row via overlay.
/// Typically used with brightly-colored backgrounds.
public struct SelectBorder: View {
    private var isSelected: Bool

    public init(_ isSelected: Bool) {
        self.isSelected = isSelected
    }

    public var body: some View {
        RoundedRectangle(cornerRadius: 4, style: .continuous)
            .strokeBorder(strokeColor,
                          lineWidth: 2,
                          antialiased: true)
            .shadow(color: .black, radius: 2, x: 1, y: 1)
            .padding(.horizontal, 4)
    }

    private var strokeColor: Color {
        isSelected ? .primary.opacity(0.8) : .clear
    }
}
