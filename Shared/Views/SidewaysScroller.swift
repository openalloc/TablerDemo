//
//  SidewaysScroller.swift
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

/// wrap a view in a horizontal scroll view, for display of large tables on compact display area
public struct SidewaysScroller<Content: View>: View {
    var minWidth: CGFloat
    @ViewBuilder var content: () -> Content

    public init(minWidth: CGFloat,
                @ViewBuilder content: @escaping () -> Content)
    {
        self.minWidth = minWidth
        self.content = content
    }

    public var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal) {
                VStack(alignment: .leading) {
                    content()
                }
                .frame(minWidth: max(minWidth, geo.size.width))
            }
        }
    }
}
