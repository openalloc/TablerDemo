//
//  ListViews.swift
//  TablerDemo
//
//  Created by Reed Esau on 5/5/22.
//

import SwiftUI
import Tabler

extension ContentView {
    var listView: some View {
        VStack {
            if headerize && !footerize {
                TablerList(listConfig,
                           header: header,
                           row: row,
                           rowBackground: rowBackground,
                           results: fruits)
            } else if !headerize && !footerize {
                TablerList(listConfig,
                           row: row,
                           rowBackground: rowBackground,
                           results: fruits)
            } else if headerize && footerize {
                TablerList(listConfig,
                           header: header,
                           footer: footer,
                           row: row,
                           rowBackground: rowBackground,
                           results: fruits)
            } else if !headerize && footerize {
                TablerList(listConfig,
                           footer: footer,
                           row: row,
                           rowBackground: rowBackground,
                           results: fruits)
            }
        }
    }

    var list1View: some View {
        VStack {
            if headerize && !footerize {
                TablerList1(listConfig,
                            header: header,
                            row: row,
                            rowBackground: rowBackground,
                            rowOverlay: singleSelectOver,
                            results: fruits,
                            selected: $selected)
            } else if !headerize && !footerize {
                TablerList1(listConfig,
                            row: row,
                            rowBackground: rowBackground,
                            rowOverlay: singleSelectOver,
                            results: fruits,
                            selected: $selected)
            } else if headerize && footerize {
                TablerList1(listConfig,
                            header: header,
                            footer: footer,
                            row: row,
                            rowBackground: rowBackground,
                            rowOverlay: singleSelectOver,
                            results: fruits,
                            selected: $selected)
            } else if !headerize && footerize {
                TablerList1(listConfig,
                            footer: footer,
                            row: row,
                            rowBackground: rowBackground,
                            rowOverlay: singleSelectOver,
                            results: fruits,
                            selected: $selected)
            }
        }
    }

    var listMView: some View {
        VStack {
            if headerize && !footerize {
                TablerListM(listConfig,
                            header: header,
                            row: row,
                            rowBackground: rowBackground,
                            rowOverlay: multiSelectOver,
                            results: fruits,
                            selected: $mselected)
            } else if !headerize && !footerize {
                TablerListM(listConfig,
                            row: row,
                            rowBackground: rowBackground,
                            rowOverlay: multiSelectOver,
                            results: fruits,
                            selected: $mselected)
            } else if headerize && footerize {
                TablerListM(listConfig,
                            header: header,
                            footer: footer,
                            row: row,
                            rowBackground: rowBackground,
                            rowOverlay: multiSelectOver,
                            results: fruits,
                            selected: $mselected)
            } else if !headerize && footerize {
                TablerListM(listConfig,
                            footer: footer,
                            row: row,
                            rowBackground: rowBackground,
                            rowOverlay: multiSelectOver,
                            results: fruits,
                            selected: $mselected)
            }
        }
    }

    var listBView: some View {
        VStack {
            if headerize && !footerize {
                TablerListB(listConfig,
                            header: header,
                            row: brow,
                            rowBackground: rowBackground,
                            results: $fruits)
            } else if !headerize && !footerize {
                TablerListB(listConfig,
                            row: brow,
                            rowBackground: rowBackground,
                            results: $fruits)
            } else if headerize && footerize {
                TablerListB(listConfig,
                            header: header,
                            footer: footer,
                            row: brow,
                            rowBackground: rowBackground,
                            results: $fruits)
            } else if !headerize && footerize {
                TablerListB(listConfig,
                            footer: footer,
                            row: brow,
                            rowBackground: rowBackground,
                            results: $fruits)
            }
        }
    }

    var list1BView: some View {
        VStack {
            if headerize && !footerize {
                TablerList1B(listConfig,
                             header: header,
                             row: brow,
                             rowBackground: rowBackground,
                             rowOverlay: singleSelectOver,
                             results: $fruits,
                             selected: $selected)
            } else if !headerize && !footerize {
                TablerList1B(listConfig,
                             row: brow,
                             rowBackground: rowBackground,
                             rowOverlay: singleSelectOver,
                             results: $fruits,
                             selected: $selected)
            } else if headerize && footerize {
                TablerList1B(listConfig,
                             header: header,
                             footer: footer,
                             row: brow,
                             rowBackground: rowBackground,
                             rowOverlay: singleSelectOver,
                             results: $fruits,
                             selected: $selected)
            } else if !headerize && footerize {
                TablerList1B(listConfig,
                             footer: footer,
                             row: brow,
                             rowBackground: rowBackground,
                             rowOverlay: singleSelectOver,
                             results: $fruits,
                             selected: $selected)
            }
        }
    }

    var listMBView: some View {
        VStack {
            if headerize && !footerize {
                TablerListMB(listConfig,
                             header: header,
                             row: brow,
                             rowBackground: rowBackground,
                             rowOverlay: multiSelectOver,
                             results: $fruits,
                             selected: $mselected)
            } else if !headerize && !footerize {
                TablerListMB(listConfig,
                             row: brow,
                             rowBackground: rowBackground,
                             rowOverlay: multiSelectOver,
                             results: $fruits,
                             selected: $mselected)
            } else if headerize && footerize {
                TablerListMB(listConfig,
                             header: header,
                             footer: footer,
                             row: brow,
                             rowBackground: rowBackground,
                             rowOverlay: multiSelectOver,
                             results: $fruits,
                             selected: $mselected)
            } else if !headerize && footerize {
                TablerListMB(listConfig,
                             footer: footer,
                             row: brow,
                             rowBackground: rowBackground,
                             rowOverlay: multiSelectOver,
                             results: $fruits,
                             selected: $mselected)
            }
        }
    }
}
