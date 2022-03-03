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

struct Alpha: ViewModifier
{
    func body(content: Content) -> some View {
        content
            .opacity(0.5)
            .contextMenu {
                Button(action: {}) { Text("Hello") }
                Button(action: {}) { Text("World") }
            }
    }
}

struct SubheadlineModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.secondary)
            .font(.subheadline)
    }
}

struct ContentView: View {
    
    private typealias Config = TablerConfig<Fruit>
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
        GridItem(.flexible(minimum: 35, maximum: 50), alignment: .leading),
        GridItem(.flexible(minimum: 100, maximum: 200), alignment: .leading),
        GridItem(.flexible(minimum: 90, maximum: 100), alignment: .trailing),
        GridItem(.flexible(minimum: 35, maximum: 50), alignment: .leading),
    ]
    
    @State private var selected: Fruit.ID? = nil
    @State private var mselected = Set<String>()
    @State private var toEdit: Fruit? = nil
    @State private var isAdd: Bool = false
    @State private var colorize: Bool = false
    @State private var headerize: Bool = true
    
    private var myToolbar: FruitToolbar {
        FruitToolbar(colorize: $colorize, headerize: $headerize)
    }
    
    private var listConfig: TablerListConfig<Fruit> {
        TablerListConfig<Fruit>(onRowColor: rowColorAction)
    }
    
    private var stackConfig: TablerStackConfig<Fruit> {
        TablerStackConfig<Fruit>(onRowColor: rowColorAction)
    }
    
    private var gridConfig: TablerGridConfig<Fruit> {
        TablerGridConfig<Fruit>(gridItems: gridItems, onRowColor: rowColorAction)
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
    }
    
    private func header(_ ctx: Binding<Context>) -> some View {
        LazyVGrid(columns: gridItems, alignment: .leading) {
            Sort.columnTitle("ID", ctx, \.id)
                .onTapGesture { tablerSort(ctx, &fruits, \.id) { $0.id < $1.id } }
            Sort.columnTitle("Name", ctx, \.name)
                .onTapGesture { tablerSort(ctx, &fruits, \.name) { $0.name < $1.name } }
            Sort.columnTitle("Weight", ctx, \.weight)
                .onTapGesture { tablerSort(ctx, &fruits, \.weight) { $0.weight < $1.weight } }
            Text("Color")
        }
    }
    
    // UNBOUND value row (read-only)
    private func row(_ element: Fruit) -> some View {
        LazyVGrid(columns: gridItems, alignment: .leading) {
            Text(element.id)
            Text(element.name).foregroundColor(colorize ? .primary : element.color)
            Text(String(format: "%.0f g", element.weight))
            Image(systemName: "rectangle.fill")
                .foregroundColor(element.color)
                .border(colorize ? Color.primary : Color.clear)
        }
    }
    
    @ViewBuilder
    private func gridRow(_ element: Fruit) -> some View {
        Text(element.id)
        Text(element.name).foregroundColor(colorize ? .primary : element.color)
        Text(String(format: "%.0f g", element.weight))
        Image(systemName: "rectangle.fill")
            .foregroundColor(element.color)
            .border(colorize ? Color.primary : Color.clear)
    }
    
    // BOUND value row (with direct editing)
    private func brow(_ element: Binding<Fruit>) -> some View {
        LazyVGrid(columns: gridItems, alignment: .leading) {
            Text(element.wrappedValue.id)
            TextField("Name", text: element.name)
                .textFieldStyle(.roundedBorder)
                .border(Color.secondary)
            Text(String(format: "%.0f g", element.wrappedValue.weight))
            ColorPicker("Color", selection: element.color)
                .labelsHidden()
        }
    }
    
    @ViewBuilder
    var lists: some View {
        NavigationLink("TablerList"   ) { listView  .toolbar { myToolbar }}
        NavigationLink("TablerList1"  ) { list1View .toolbar { myToolbar }}
        NavigationLink("TablerListM"  ) { listMView .toolbar { myToolbar }}
        NavigationLink("TablerListB"  ) { listBView .toolbar { myToolbar }}
        NavigationLink("TablerList1B" ) { list1BView.toolbar { myToolbar }}
        NavigationLink("TablerListMB" ) { listMBView.toolbar { myToolbar }}
    }
    
    @ViewBuilder
    private var stacks: some View {
        NavigationLink("TablerStack"  ) { stackView  .toolbar { myToolbar }}
        NavigationLink("TablerStack1" ) { stack1View .toolbar { myToolbar }}
        NavigationLink("TablerStackB" ) { stackBView .toolbar { myToolbar }}
        NavigationLink("TablerStack1B") { stack1BView.toolbar { myToolbar }}
    }
    
    @ViewBuilder
    private var grids: some View {
        NavigationLink("TablerGrid"   ) { gridView  .toolbar { myToolbar }}
    }
    
    // MARK: - List Views
    
    private var listView: some View {
        SidewaysScroller(minWidth: minWidth) {
            if headerize {
                TablerList(listConfig,
                           headerContent: header,
                           rowContent: row,
                           results: fruits)
            } else {
                TablerList(listConfig,
                           rowContent: row,
                           results: fruits)
            }
        }
    }
    
    private var list1View: some View {
        SidewaysScroller(minWidth: minWidth) {
            if headerize {
                TablerList1(listConfig,
                            headerContent: header,
                            rowContent: row,
                            selectContent: { SelectBorder(colorize && $0) },
                            results: fruits,
                            selected: $selected)
            } else {
                TablerList1(listConfig,
                            rowContent: row,
                            selectContent: { SelectBorder(colorize && $0) },
                            results: fruits,
                            selected: $selected)
            }
        }
    }
    
    private var listMView: some View {
        SidewaysScroller(minWidth: minWidth) {
            if headerize {
                TablerListM(listConfig,
                            headerContent: header,
                            rowContent: row,
                            selectContent: { SelectBorder(colorize && $0) },
                            results: fruits,
                            selected: $mselected)
            } else {
                TablerListM(listConfig,
                            rowContent: row,
                            selectContent: { SelectBorder(colorize && $0) },
                            results: fruits,
                            selected: $mselected)
            }
        }
    }
    
    private var listBView: some View {
        SidewaysScroller(minWidth: minWidth) {
            if headerize {
                TablerListB(listConfig,
                            headerContent: header,
                            rowContent: brow,
                            results: $fruits)
            } else {
                TablerListB(listConfig,
                            rowContent: brow,
                            results: $fruits)
            }
        }
    }
    
    private var list1BView: some View {
        SidewaysScroller(minWidth: minWidth) {
            if headerize {
                TablerList1B(listConfig,
                             headerContent: header,
                             rowContent: brow,
                             selectContent: { SelectBorder(colorize && $0) },
                             results: $fruits,
                             selected: $selected)
            } else {
                TablerList1B(listConfig,
                             rowContent: brow,
                             selectContent: { SelectBorder(colorize && $0) },
                             results: $fruits,
                             selected: $selected)
            }
        }
    }
    
    private var listMBView: some View {
        SidewaysScroller(minWidth: minWidth) {
            if headerize {
                TablerListMB(listConfig,
                             headerContent: header,
                             rowContent: brow,
                             selectContent: { SelectBorder(colorize && $0) },
                             results: $fruits,
                             selected: $mselected)
            } else {
                TablerListMB(listConfig,
                             rowContent: brow,
                             selectContent: { SelectBorder(colorize && $0) },
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
                            headerContent: header,
                            rowContent: row,
                            results: fruits)
            } else {
                TablerStack(stackConfig,
                            rowContent: row,
                            results: fruits)
            }
        }
    }
    
    private var stack1View: some View {
        SidewaysScroller(minWidth: minWidth) {
            if headerize {
                TablerStack1(stackConfig,
                             headerContent: header,
                             rowContent: row,
                             selectContent: { SelectBorder(colorize && $0) },
                             results: fruits,
                             selected: $selected)
            } else {
                TablerStack1(stackConfig,
                             rowContent: row,
                             selectContent: { SelectBorder(colorize && $0) },
                             results: fruits,
                             selected: $selected)
            }
        }
    }
    
    private var stackBView: some View {
        SidewaysScroller(minWidth: minWidth) {
            if headerize {
                TablerStackB(stackConfig,
                             headerContent: header,
                             rowContent: brow,
                             results: $fruits)
            } else {
                TablerStackB(stackConfig,
                             rowContent: brow,
                             results: $fruits)
            }
        }
    }
    
    private var stack1BView: some View {
        SidewaysScroller(minWidth: minWidth) {
            if headerize {
                TablerStack1B(stackConfig,
                              headerContent: header,
                              rowContent: brow,
                              selectContent: { SelectBorder(colorize && $0) },
                              results: $fruits,
                              selected: $selected)
            } else {
                TablerStack1B(stackConfig,
                              rowContent: brow,
                              selectContent: { SelectBorder(colorize && $0) },
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
                           headerContent: header,
                           rowContent: gridRow,
                           results: fruits)
            } else {
                TablerGrid(gridConfig,
                           rowContent: gridRow,
                           results: fruits)
            }
        }
    }
    
    // MARK: - Action Handlers
    
    private var rowColorAction: TablerConfig<Fruit>.OnRowColor? {
        colorize ? { (.primary, $0.color) } : nil
    }
}

struct FruitToolbar: ToolbarContent {
    @Binding var colorize: Bool
    @Binding var headerize: Bool

    //private var toolbarGroup: ToolbarItemGroup {
    var body: some ToolbarContent {
        ToolbarItemGroup {
            Toggle(isOn: $colorize) { Text("Colorize") }
            Toggle(isOn: $headerize) { Text("Header") }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(Fruit.bootstrap)
    }
}
