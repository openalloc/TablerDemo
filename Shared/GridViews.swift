//
//  GridViews.swift
//  TablerDemo
//
//  Created by Reed Esau on 5/5/22.
//

import SwiftUI
import Sideways
import Tabler

extension ContentView {
    
    var gridView: some View {
        Sideways(minWidth: minWidth) {
            if headerize && !footerize {
                TablerGrid(gridConfig,
                           header: header,
                           row: rowItems,
                           rowBackground: rowBackground,
                           results: fruits)
            } else if !headerize && !footerize {
                TablerGrid(gridConfig,
                           row: rowItems,
                           rowBackground: rowBackground,
                           results: fruits)
            } else if headerize && footerize {
                TablerGrid(gridConfig,
                           header: header,
                           footer: footer,
                           row: rowItems,
                           rowBackground: rowBackground,
                           results: fruits)
            } else if !headerize && footerize {
                TablerGrid(gridConfig,
                           footer: footer,
                           row: rowItems,
                           rowBackground: rowBackground,
                           results: fruits)
            }
        }
    }
    
    var gridBView: some View {
        Sideways(minWidth: minWidth) {
            if headerize && !footerize {
                TablerGridB(gridConfig,
                            header: header,
                            row: rowItemsBound,
                            rowBackground: rowBackground,
                            results: $fruits)
            } else if !headerize && !footerize {
                TablerGridB(gridConfig,
                            row: rowItemsBound,
                            rowBackground: rowBackground,
                            results: $fruits)
            } else if headerize && footerize {
                TablerGridB(gridConfig,
                            header: header,
                            footer: footer,
                            row: rowItemsBound,
                            rowBackground: rowBackground,
                            results: $fruits)
            } else if !headerize && footerize {
                TablerGridB(gridConfig,
                            footer: footer,
                            row: rowItemsBound,
                            rowBackground: rowBackground,
                            results: $fruits)
            }
        }
    }
    
    var grid1View: some View {
        Sideways(minWidth: minWidth) {
            if headerize && !footerize {
                TablerGrid1(gridConfig,
                            header: header,
                            row: rowItems,
                            rowBackground: singleSelectBack,
                            results: fruits,
                            selected: $selected)
            } else if !headerize && !footerize {
                TablerGrid1(gridConfig,
                            row: rowItems,
                            rowBackground: singleSelectBack,
                            results: fruits,
                            selected: $selected)
            } else if headerize && footerize {
                TablerGrid1(gridConfig,
                            header: header,
                            footer: footer,
                            row: rowItems,
                            rowBackground: singleSelectBack,
                            results: fruits,
                            selected: $selected)
            } else if !headerize && footerize {
                TablerGrid1(gridConfig,
                            footer: footer,
                            row: rowItems,
                            rowBackground: singleSelectBack,
                            results: fruits,
                            selected: $selected)
            }
        }
    }
    
    var grid1BView: some View {
        Sideways(minWidth: minWidth) {
            if headerize && !footerize {
                TablerGrid1B(gridConfig,
                             header: header,
                             row: rowItemsBound,
                             rowBackground: singleSelectBack,
                             results: $fruits,
                             selected: $selected)
            } else if !headerize && !footerize {
                TablerGrid1B(gridConfig,
                             row: rowItemsBound,
                             rowBackground: singleSelectBack,
                             results: $fruits,
                             selected: $selected)
            } else if headerize && footerize {
                TablerGrid1B(gridConfig,
                             header: header,
                             footer: footer,
                             row: rowItemsBound,
                             rowBackground: singleSelectBack,
                             results: $fruits,
                             selected: $selected)
            } else if !headerize && footerize {
                TablerGrid1B(gridConfig,
                             footer: footer,
                             row: rowItemsBound,
                             rowBackground: singleSelectBack,
                             results: $fruits,
                             selected: $selected)
            }
        }
    }
    
    var gridMView: some View {
        Sideways(minWidth: minWidth) {
            if headerize && !footerize {
                TablerGridM(gridConfig,
                            header: header,
                            row: rowItems,
                            rowBackground: multiSelectBack,
                            results: fruits,
                            selected: $mselected)
            } else if !headerize && !footerize {
                TablerGridM(gridConfig,
                            row: rowItems,
                            rowBackground: multiSelectBack,
                            results: fruits,
                            selected: $mselected)
            } else if headerize && footerize {
                TablerGridM(gridConfig,
                            header: header,
                            footer: footer,
                            row: rowItems,
                            rowBackground: multiSelectBack,
                            results: fruits,
                            selected: $mselected)
            } else if !headerize && footerize {
                TablerGridM(gridConfig,
                            footer: footer,
                            row: rowItems,
                            rowBackground: multiSelectBack,
                            results: fruits,
                            selected: $mselected)
            }
        }
    }
    
    var gridMBView: some View {
        Sideways(minWidth: minWidth) {
            if headerize && !footerize {
                TablerGridMB(gridConfig,
                             header: header,
                             row: rowItemsBound,
                             rowBackground: multiSelectBack,
                             results: $fruits,
                             selected: $mselected)
            } else if !headerize && !footerize {
                TablerGridMB(gridConfig,
                             row: rowItemsBound,
                             rowBackground: multiSelectBack,
                             results: $fruits,
                             selected: $mselected)
            } else if headerize && footerize {
                TablerGridMB(gridConfig,
                             header: header,
                             footer: footer,
                             row: rowItemsBound,
                             rowBackground: multiSelectBack,
                             results: $fruits,
                             selected: $mselected)
            } else if !headerize && footerize {
                TablerGridMB(gridConfig,
                             footer: footer,
                             row: rowItemsBound,
                             rowBackground: multiSelectBack,
                             results: $fruits,
                             selected: $mselected)
            }
        }
    }
}
