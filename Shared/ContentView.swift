//
// ContentView.swift
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
import Tabler

let columnSpacing: CGFloat = 10

struct ContentView: View {
    
    private typealias Context = TablerContext<Fruit>
    private typealias Sort = TablerSort<Fruit>
    
    // MARK: - Parameters
    
    @State private var fruits: [Fruit]
    
    public init(_ fruits: [Fruit]) {
        _fruits = State(initialValue: fruits)
    }
    
    // MARK: - Locals
    
    private let minWidth: CGFloat = 400
    private let title = "Tabler Demo"
    
    private var gridItems: [GridItem] = [
        GridItem(.flexible(minimum: 35, maximum: 50), spacing: columnSpacing, alignment: .leading),
        GridItem(.flexible(minimum: 100, maximum: 200), spacing: columnSpacing, alignment: .leading),
        GridItem(.flexible(minimum: 40, maximum: 100), spacing: columnSpacing, alignment: .trailing),
        GridItem(.flexible(minimum: 35, maximum: 50), spacing: columnSpacing, alignment: .leading),
    ]
    
    @State private var selected: Fruit.ID? = nil
    @State private var mselected = Set<Fruit.ID>()
    @State private var colorize: Bool = false
    @State private var headerize: Bool = true
    
    private var hoverColor: Color {
        colorize ? .clear : .orange.opacity(0.3)
    }
    
    private var listConfig: TablerListConfig<Fruit> {
        TablerListConfig<Fruit>(hoverColor: hoverColor)
    }
    
    private var stackConfig: TablerStackConfig<Fruit> {
        TablerStackConfig<Fruit>(hoverColor: hoverColor)
    }
    
    private var gridConfig: TablerGridConfig<Fruit> {
        TablerGridConfig<Fruit>(gridItems: gridItems, hoverColor: hoverColor)
    }
    
    // MARK: - Views
    
    var body: some View {
        NavigationView {
            List {
                Section("List-based") {
                    lists
                }
                
                Section("Stack-based") {
                    stacks
                }
                
                Section("Grid-based") {
                    grids
                }
            }
#if os(iOS)
            .navigationTitle(title)
#endif
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
#if os(macOS)
        .navigationTitle(title)
#endif
        .toolbar {
            ToolbarItemGroup {
                Toggle(isOn: $colorize) { Text("Colorize") }
                Button(action: { fruits.shuffle() }) { Text("Shuffle") }
                Toggle(isOn: $headerize) { Text("Header") }
            }
        }
    }
    
    private var columnPadding: EdgeInsets {
        EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
    }
    
    private var headerBackground: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(
                LinearGradient(gradient: .init(colors: [Color.gray.opacity(0.5), Color.gray.opacity(0.3)]),
                               startPoint: .top,
                               endPoint: .bottom)
            )
    }
    
    private func header(ctx: Binding<Context>) -> some View {
        LazyVGrid(columns: gridItems, alignment: .leading) {
            Sort.columnTitle("ID", ctx, \.id)
                .onTapGesture { tablerSort(ctx, &fruits, \.id) { $0.id < $1.id } }
                .padding(columnPadding)
                .background(headerBackground)
            Sort.columnTitle("Name", ctx, \.name)
                .onTapGesture { tablerSort(ctx, &fruits, \.name) { $0.name < $1.name } }
                .padding(columnPadding)
                .background(headerBackground)
            Sort.columnTitle("Weight", ctx, \.weight)
                .onTapGesture { tablerSort(ctx, &fruits, \.weight) { $0.weight < $1.weight } }
                .padding(columnPadding)
                .background(headerBackground)
            Text("Color")
                .padding(columnPadding)
                .background(headerBackground)
        }
    }
    
    // UNBOUND value row (read-only)
    private func row(element: Fruit) -> some View {
        LazyVGrid(columns: gridItems, alignment: .leading) {
            Text(element.id)
                .padding(columnPadding)
            Text(element.name).foregroundColor(colorize ? .primary : element.color)
                .padding(columnPadding)
            Text(String(format: "%.0f g", element.weight))
                .padding(columnPadding)
            Image(systemName: "rectangle.fill")
                .padding(columnPadding)
                .foregroundColor(element.color)
                .border(colorize ? Color.primary : Color.clear)
        }
    }
    
    @ViewBuilder
    private func gridRow(element: Fruit) -> some View {
        Text(element.id)
            .padding(columnPadding)
        Text(element.name).foregroundColor(colorize ? .primary : element.color)
            .padding(columnPadding)
        Text(String(format: "%.0f g", element.weight))
            .padding(columnPadding)
        Image(systemName: "rectangle.fill")
            .padding(columnPadding)
            .foregroundColor(element.color)
            .border(colorize ? Color.primary : Color.clear)
    }
    
    // BOUND value row (with direct editing)
    private func brow(element: Binding<Fruit>) -> some View {
        LazyVGrid(columns: gridItems, alignment: .leading) {
            Text(element.wrappedValue.id)
                .padding(columnPadding)
            TextField("Name", text: element.name)
                .padding(columnPadding)
                .textFieldStyle(.roundedBorder)
                .border(Color.secondary)
            Text(String(format: "%.0f g", element.wrappedValue.weight))
                .padding(columnPadding)
            ColorPicker("Color", selection: element.color)
                .padding(columnPadding)
                .labelsHidden()
        }
    }
    
    @ViewBuilder
    var lists: some View {
        NavigationLink("TablerList"   ) { listView }
        NavigationLink("TablerList1"  ) { list1View    }
        NavigationLink("TablerListM"  ) { listMView    }
        NavigationLink("TablerListB"  ) { listBView    }
        NavigationLink("TablerList1B" ) { list1BView    }
        NavigationLink("TablerListMB" ) { listMBView    }
    }
    
    @ViewBuilder
    private var stacks: some View {
        NavigationLink("TablerStack"  ) { stackView }
        NavigationLink("TablerStack1" ) { stack1View }
        NavigationLink("TablerStackB" ) { stackBView }
        NavigationLink("TablerStack1B") { stack1BView }
    }
    
    @ViewBuilder
    private var grids: some View {
        NavigationLink("TablerGrid"   ) { gridView }
    }
    
    // MARK: - List Views
    
    private var listView: some View {
        SidewaysScroller(minWidth: minWidth) {
            if headerize {
                TablerList(listConfig,
                           header: header,
                           row: row,
                           rowBackground: rowBackgroundAction,
                           results: fruits)
            } else {
                TablerList(listConfig,
                           row: row,
                           rowBackground: rowBackgroundAction,
                           results: fruits)
            }
        }
    }
    
    private var list1View: some View {
        SidewaysScroller(minWidth: minWidth) {
            if headerize {
                TablerList1(listConfig,
                            header: header,
                            row: row,
                            rowBackground: rowBackgroundAction,
                            selectOverlay: selectOverlayAction,
                            results: fruits,
                            selected: $selected)
            } else {
                TablerList1(listConfig,
                            row: row,
                            rowBackground: rowBackgroundAction,
                            selectOverlay: selectOverlayAction,
                            results: fruits,
                            selected: $selected)
            }
        }
    }
    
    private var listMView: some View {
        SidewaysScroller(minWidth: minWidth) {
            if headerize {
                TablerListM(listConfig,
                            header: header,
                            row: row,
                            rowBackground: rowBackgroundAction,
                            selectOverlay: selectOverlayAction,
                            results: fruits,
                            selected: $mselected)
            } else {
                TablerListM(listConfig,
                            row: row,
                            rowBackground: rowBackgroundAction,
                            selectOverlay: selectOverlayAction,
                            results: fruits,
                            selected: $mselected)
            }
        }
    }
    
    private var listBView: some View {
        SidewaysScroller(minWidth: minWidth) {
            if headerize {
                TablerListB(listConfig,
                            header: header,
                            row: brow,
                            rowBackground: rowBackgroundAction,
                            results: $fruits)
            } else {
                TablerListB(listConfig,
                            row: brow,
                            rowBackground: rowBackgroundAction,
                            results: $fruits)
            }
        }
    }
    
    private var list1BView: some View {
        SidewaysScroller(minWidth: minWidth) {
            if headerize {
                TablerList1B(listConfig,
                             header: header,
                             row: brow,
                             rowBackground: rowBackgroundAction,
                             selectOverlay: selectOverlayAction,
                             results: $fruits,
                             selected: $selected)
            } else {
                TablerList1B(listConfig,
                             row: brow,
                             rowBackground: rowBackgroundAction,
                             selectOverlay: selectOverlayAction,
                             results: $fruits,
                             selected: $selected)
            }
        }
    }
    
    private var listMBView: some View {
        SidewaysScroller(minWidth: minWidth) {
            if headerize {
                TablerListMB(listConfig,
                             header: header,
                             row: brow,
                             rowBackground: rowBackgroundAction,
                             selectOverlay: selectOverlayAction,
                             results: $fruits,
                             selected: $mselected)
            } else {
                TablerListMB(listConfig,
                             row: brow,
                             rowBackground: rowBackgroundAction,
                             selectOverlay: selectOverlayAction,
                             results: $fruits,
                             selected: $mselected)
            }
        }
    }
    
    // MARK: - Stack Views
    
    private var stackView: some View {
        SidewaysScroller(minWidth: minWidth) {
            if headerize {
                TablerStack(stackConfig,
                            header: header,
                            row: row,
                            rowBackground: rowBackgroundAction,
                            results: fruits)
            } else {
                TablerStack(stackConfig,
                            row: row,
                            rowBackground: rowBackgroundAction,
                            results: fruits)
            }
        }
    }
    
    private var stack1View: some View {
        SidewaysScroller(minWidth: minWidth) {
            if headerize {
                TablerStack1(stackConfig,
                             header: header,
                             row: row,
                             rowBackground: rowBackgroundAction,
                             selectOverlay: selectOverlayAction,
                             results: fruits,
                             selected: $selected)
            } else {
                TablerStack1(stackConfig,
                             row: row,
                             rowBackground: rowBackgroundAction,
                             selectOverlay: selectOverlayAction,
                             results: fruits,
                             selected: $selected)
            }
        }
    }
    
    private var stackBView: some View {
        SidewaysScroller(minWidth: minWidth) {
            if headerize {
                TablerStackB(stackConfig,
                             header: header,
                             row: brow,
                             rowBackground: rowBackgroundAction,
                             results: $fruits)
            } else {
                TablerStackB(stackConfig,
                             row: brow,
                             rowBackground: rowBackgroundAction,
                             results: $fruits)
            }
        }
    }
    
    private var stack1BView: some View {
        SidewaysScroller(minWidth: minWidth) {
            if headerize {
                TablerStack1B(stackConfig,
                              header: header,
                              row: brow,
                              rowBackground: rowBackgroundAction,
                              selectOverlay: selectOverlayAction,
                              results: $fruits,
                              selected: $selected)
            } else {
                TablerStack1B(stackConfig,
                              row: brow,
                              rowBackground: rowBackgroundAction,
                              selectOverlay: selectOverlayAction,
                              results: $fruits,
                              selected: $selected)
            }
        }
    }
    
    // MARK: - Stack Views
    
    private var gridView: some View {
        SidewaysScroller(minWidth: minWidth) {
            if headerize {
                TablerGrid(gridConfig,
                           header: header,
                           row: gridRow,
                           rowBackground: rowBackgroundAction,
                           results: fruits)
            } else {
                TablerGrid(gridConfig,
                           row: gridRow,
                           rowBackground: rowBackgroundAction,
                           results: fruits)
            }
        }
    }
    
    // MARK: - Action Handlers
    
    private func selectOverlayAction(isSelected: Bool) -> some View {
        SelectBorder(colorize && isSelected)
    }
    
    private func rowBackgroundAction(fruit: Fruit) -> some View {
        LinearGradient(gradient: .init(colors: [fruit.color, fruit.color.opacity(0.2)]),
                       startPoint: .top,
                       endPoint: .bottom)
            .opacity(colorize ? 1 : 0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(Fruit.bootstrap)
    }
}
