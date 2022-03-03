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
    @State private var mselected = Set<Fruit.ID>()
    @State private var colorize: Bool = false
    @State private var headerize: Bool = true
    
    private func getConfig(rowSpacing: CGFloat,
                           insets: EdgeInsets) -> Config {
        TablerConfig(onRowColor: { (.primary, colorize ? $0.color : .clear) },
                     rowSpacing: rowSpacing,
                     paddingInsets: insets)
    }
    
    private var listConfig: Config {
        getConfig(rowSpacing: TablerConfigDefaults.rowSpacing,
                  insets: TablerConfigDefaults.paddingInsets)
    }

    private var stackConfig: Config {
        getConfig(rowSpacing: TablerStackConfigDefaults.rowSpacing,
                  insets: TablerStackConfigDefaults.paddingInsets)
    }
    
    private var gridConfig: Config {
        getConfig(rowSpacing: TablerGridConfigDefaults.rowSpacing,
                  insets: TablerGridConfigDefaults.paddingInsets)
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
                           results: fruits)
            } else {
                TablerList(listConfig,
                           row: row,
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
                            selectOverlay: { SelectBorder(colorize && $0) },
                            results: fruits,
                            selected: $selected)
            } else {
                TablerList1(listConfig,
                            row: row,
                            selectOverlay: { SelectBorder(colorize && $0) },
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
                            selectOverlay: { SelectBorder(colorize && $0) },
                            results: fruits,
                            selected: $mselected)
            } else {
                TablerListM(listConfig,
                            row: row,
                            selectOverlay: { SelectBorder(colorize && $0) },
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
                            results: $fruits)
            } else {
                TablerListB(listConfig,
                            row: brow,
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
                             selectOverlay: { SelectBorder(colorize && $0) },
                             results: $fruits,
                             selected: $selected)
            } else {
                TablerList1B(listConfig,
                             row: brow,
                             selectOverlay: { SelectBorder(colorize && $0) },
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
                             selectOverlay: { SelectBorder(colorize && $0) },
                             results: $fruits,
                             selected: $mselected)
            } else {
                TablerListMB(listConfig,
                             row: brow,
                             selectOverlay: { SelectBorder(colorize && $0) },
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
                            results: fruits)
            } else {
                TablerStack(stackConfig,
                            row: row,
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
                             selectOverlay: { SelectBorder(colorize && $0) },
                             results: fruits,
                             selected: $selected)
            } else {
                TablerStack1(stackConfig,
                             row: row,
                             selectOverlay: { SelectBorder(colorize && $0) },
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
                             results: $fruits)
            } else {
                TablerStackB(stackConfig,
                             row: brow,
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
                              selectOverlay: { SelectBorder(colorize && $0) },
                              results: $fruits,
                              selected: $selected)
            } else {
                TablerStack1B(stackConfig,
                              row: brow,
                              selectOverlay: { SelectBorder(colorize && $0) },
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
                           gridItems: gridItems,
                           header: header,
                           row: gridRow,
                           results: fruits)
            } else {
                TablerGrid(gridConfig,
                           gridItems: gridItems,
                           row: gridRow,
                           results: fruits)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(Fruit.bootstrap)
    }
}
