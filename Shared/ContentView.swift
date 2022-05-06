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
import Sideways

struct ContentView: View {
    
    typealias Context = TablerContext<Fruit>
    typealias Sort = TablerSort<Fruit>
    
    // MARK: - Parameters
    
    @State var fruits: [Fruit]
    
    public init(_ fruits: [Fruit]) {
        _fruits = State(initialValue: fruits)
    }
    
    // MARK: - Locals
    
    let columnSpacing: CGFloat = 10
    let minWidth: CGFloat = 450
    let title = "Tabler Demo"
    
    var gridItems: [GridItem] {[
        GridItem(.flexible(minimum: 40, maximum: 60), spacing: columnSpacing, alignment: .leading),
        GridItem(.flexible(minimum: 100, maximum: 200), spacing: columnSpacing, alignment: .leading),
        GridItem(.flexible(minimum: 100, maximum: 140), spacing: columnSpacing, alignment: .trailing),
        GridItem(.flexible(minimum: 50, maximum: 60), spacing: columnSpacing, alignment: .leading),
    ]}
    
    @State var selected: Fruit.ID? = nil
    @State var mselected = Set<Fruit.ID>()
    @State var colorize: Bool = false
    @State var headerize: Bool = true
    @State var footerize: Bool = false
    @State var hovered: Fruit.ID? = nil
    
    var hoverColor: Color {
        colorize ? .clear : .orange.opacity(0.3)
    }
    
    var listConfig: TablerListConfig<Fruit> {
        TablerListConfig<Fruit>(onMove: moveAction, onHover: hoverAction)
        //filter: { $0.weight > 10 }
    }
    
    var stackConfig: TablerStackConfig<Fruit> {
        TablerStackConfig<Fruit>(onHover: hoverAction)
    }
    
    var gridConfig: TablerGridConfig<Fruit> {
        TablerGridConfig<Fruit>(gridItems: gridItems, onHover: hoverAction)
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
    
    var columnPadding: EdgeInsets {
        EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
    }
    
    var headerBackground: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(
                LinearGradient(gradient: .init(colors: [Color.gray.opacity(0.5), Color.gray.opacity(0.3)]),
                               startPoint: .top,
                               endPoint: .bottom)
            )
    }
    
    var footerBackground: some View {
        Rectangle()
            .fill(
                Color.blue
            )
    }
    
    func header(ctx: Binding<Context>) -> some View {
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
    
    func footer(ctx: Binding<Context>) -> some View {
        LazyVGrid(columns: gridItems, alignment: .leading) {
            Text("ID")
                .padding(columnPadding)
                .background(footerBackground)
            Text("Name")
                .padding(columnPadding)
                .background(footerBackground)
            Text("Weight")
                .padding(columnPadding)
                .background(footerBackground)
            Text("Color")
                .padding(columnPadding)
                .background(footerBackground)
        }
    }
    
    // UNBOUND value row (read-only)
    func row(element: Fruit) -> some View {
        LazyVGrid(columns: gridItems, alignment: .leading) {
            rowItems(element: element)
        }
    }
    
    @ViewBuilder
    func rowItems(element: Fruit) -> some View {
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
    func brow(element: Binding<Fruit>) -> some View {
        LazyVGrid(columns: gridItems, alignment: .leading) {
            rowItemsBound(element: element)
        }
    }
    
    @ViewBuilder
    func rowItemsBound(element: Binding<Fruit>) -> some View {
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
    
    @ViewBuilder
    var lists: some View {
        NavigationLink("TablerList"   ) { listView  .toolbar { myToolbar } }
        NavigationLink("TablerListB"  ) { listBView  .toolbar { myToolbar } }
        NavigationLink("TablerList1"  ) { list1View .toolbar { myToolbar } }
        NavigationLink("TablerList1B" ) { list1BView .toolbar { myToolbar } }
        NavigationLink("TablerListM"  ) { listMView .toolbar { myToolbar } }
        NavigationLink("TablerListMB" ) { listMBView .toolbar { myToolbar } }
    }
    
    @ViewBuilder
    var stacks: some View {
        NavigationLink("TablerStack"  ) { stackView .toolbar { myToolbar } }
        NavigationLink("TablerStackB" ) { stackBView .toolbar { myToolbar } }
        NavigationLink("TablerStack1" ) { stack1View .toolbar { myToolbar } }
        NavigationLink("TablerStack1B") { stack1BView .toolbar { myToolbar } }
        NavigationLink("TablerStackM" ) { stackMView .toolbar { myToolbar } }
        NavigationLink("TablerStackMB" ) { stackMBView .toolbar { myToolbar } }
    }
    
    @ViewBuilder
    var grids: some View {
        NavigationLink("TablerGrid"   ) { gridView .toolbar { myToolbar } }
        NavigationLink("TablerGridB"  ) { gridBView .toolbar { myToolbar } }
        NavigationLink("TablerGrid1"   ) { grid1View .toolbar { myToolbar } }
        NavigationLink("TablerGrid1B"  ) { grid1BView .toolbar { myToolbar } }
        NavigationLink("TablerGridM"   ) { gridMView .toolbar { myToolbar } }
        NavigationLink("TablerGridMB"  ) { gridMBView .toolbar { myToolbar } }
    }
    
    var myToolbar: FruitToolbar {
        FruitToolbar(headerize: $headerize,
                     footerize: $footerize,
                     colorize: $colorize)
    }
    
    func singleSelectBack(fruit: Fruit) -> some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(Color.accentColor.opacity(selected == fruit.id ? 1 : (hovered == fruit.id ? 0.2 : 0.0)))
    }
    
    func singleSelectOver(fruit: Fruit) -> some View {
        RoundedRectangle(cornerRadius: 5)
            .strokeBorder(selected == fruit.id ? .white : .clear,
                          lineWidth: 2,
                          antialiased: true)
    }
    
    func multiSelectBack(fruit: Fruit) -> some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(Color.accentColor.opacity(mselected.contains(fruit.id) ? 1 : (hovered == fruit.id ? 0.2 : 0.0)))
    }
    
    func multiSelectOver(fruit: Fruit) -> some View {
        RoundedRectangle(cornerRadius: 5)
            .strokeBorder(mselected.contains(fruit.id) ? .white : .clear,
                          lineWidth: 2,
                          antialiased: true)
    }
    
    func rowBackground(fruit: Fruit) -> some View {
        LinearGradient(gradient: .init(colors: [fruit.color, fruit.color.opacity(0.5)]),
                       startPoint: .top,
                       endPoint: .bottom)
            .opacity(colorize ? 1.0 : (hovered == fruit.id ? 0.2 : 0.0))
    }
    
    // MARK: - Action Handlers
    
    func hoverAction(fruitID: Fruit.ID, isHovered: Bool) {
        if isHovered { hovered = fruitID } else { hovered = nil }
    }
    
    func moveAction(from source: IndexSet, to destination: Int) {
        fruits.move(fromOffsets: source, toOffset: destination)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(Fruit.bootstrap)
    }
}
