//
//  StackViews.swift
//  TablerDemo
//
//  Created by Reed Esau on 5/5/22.
//

import SwiftUI
import Tabler

extension ContentView {
    // MARK: - Stack Views

    var stackView: some View {
        VStack {
            if headerize && !footerize {
                TablerStack(stackConfig,
                            header: header,
                            row: row,
                            rowBackground: rowBackground,
                            results: fruits)
            } else if !headerize && !footerize {
                TablerStack(stackConfig,
                            row: row,
                            rowBackground: rowBackground,
                            results: fruits)
            } else if headerize && footerize {
                TablerStack(stackConfig,
                            header: header,
                            footer: footer,
                            row: row,
                            rowBackground: rowBackground,
                            results: fruits)
            } else if !headerize && footerize {
                TablerStack(stackConfig,
                            footer: footer,
                            row: row,
                            rowBackground: rowBackground,
                            results: fruits)
            }
        }
    }

    var stack1View: some View {
        VStack {
            if headerize && !footerize {
                TablerStack1(stackConfig,
                             header: header,
                             row: row,
                             rowBackground: rowBackground,
                             rowOverlay: singleSelectOver,
                             results: fruits,
                             selected: $selected)
            } else if !headerize && !footerize {
                TablerStack1(stackConfig,
                             row: row,
                             rowBackground: rowBackground,
                             rowOverlay: singleSelectOver,
                             results: fruits,
                             selected: $selected)
            } else if headerize && footerize {
                TablerStack1(stackConfig,
                             header: header,
                             footer: footer,
                             row: row,
                             rowBackground: rowBackground,
                             rowOverlay: singleSelectOver,
                             results: fruits,
                             selected: $selected)
            } else if !headerize && footerize {
                TablerStack1(stackConfig,
                             footer: footer,
                             row: row,
                             rowBackground: rowBackground,
                             rowOverlay: singleSelectOver,
                             results: fruits,
                             selected: $selected)
            }
        }
    }

    var stackBView: some View {
        VStack {
            if headerize && !footerize {
                TablerStackB(stackConfig,
                             header: header,
                             row: brow,
                             rowBackground: rowBackground,
                             results: $fruits)
            } else if !headerize && !footerize {
                TablerStackB(stackConfig,
                             row: brow,
                             rowBackground: rowBackground,
                             results: $fruits)
            } else if headerize && footerize {
                TablerStackB(stackConfig,
                             header: header,
                             footer: footer,
                             row: brow,
                             rowBackground: rowBackground,
                             results: $fruits)
            } else if !headerize && footerize {
                TablerStackB(stackConfig,
                             footer: footer,
                             row: brow,
                             rowBackground: rowBackground,
                             results: $fruits)
            }
        }
    }

    var stack1BView: some View {
        VStack {
            if headerize && !footerize {
                TablerStack1B(stackConfig,
                              header: header,
                              row: brow,
                              rowBackground: rowBackground,
                              rowOverlay: singleSelectOver,
                              results: $fruits,
                              selected: $selected)
            } else if !headerize && !footerize {
                TablerStack1B(stackConfig,
                              row: brow,
                              rowBackground: rowBackground,
                              rowOverlay: singleSelectOver,
                              results: $fruits,
                              selected: $selected)
            } else if headerize && footerize {
                TablerStack1B(stackConfig,
                              header: header,
                              footer: footer,
                              row: brow,
                              rowBackground: rowBackground,
                              rowOverlay: singleSelectOver,
                              results: $fruits,
                              selected: $selected)
            } else if !headerize && footerize {
                TablerStack1B(stackConfig,
                              footer: footer,
                              row: brow,
                              rowBackground: rowBackground,
                              rowOverlay: singleSelectOver,
                              results: $fruits,
                              selected: $selected)
            }
        }
    }

    var stackMView: some View {
        VStack {
            if headerize && !footerize {
                TablerStackM(stackConfig,
                             header: header,
                             row: row,
                             rowBackground: rowBackground,
                             rowOverlay: multiSelectOver,
                             results: fruits,
                             selected: $mselected)
            } else if !headerize && !footerize {
                TablerStackM(stackConfig,
                             row: row,
                             rowBackground: rowBackground,
                             rowOverlay: multiSelectOver,
                             results: fruits,
                             selected: $mselected)
            } else if headerize && footerize {
                TablerStackM(stackConfig,
                             header: header,
                             footer: footer,
                             row: row,
                             rowBackground: rowBackground,
                             rowOverlay: multiSelectOver,
                             results: fruits,
                             selected: $mselected)
            } else if !headerize && footerize {
                TablerStackM(stackConfig,
                             footer: footer,
                             row: row,
                             rowBackground: rowBackground,
                             rowOverlay: multiSelectOver,
                             results: fruits,
                             selected: $mselected)
            }
        }
    }

    var stackMBView: some View {
        VStack {
            if headerize && !footerize {
                TablerStackMB(stackConfig,
                              header: header,
                              row: brow,
                              rowBackground: rowBackground,
                              rowOverlay: multiSelectOver,
                              results: $fruits,
                              selected: $mselected)
            } else if !headerize && !footerize {
                TablerStackMB(stackConfig,
                              row: brow,
                              rowBackground: rowBackground,
                              rowOverlay: multiSelectOver,
                              results: $fruits,
                              selected: $mselected)
            } else if headerize && footerize {
                TablerStackMB(stackConfig,
                              header: header,
                              footer: footer,
                              row: brow,
                              rowBackground: rowBackground,
                              rowOverlay: multiSelectOver,
                              results: $fruits,
                              selected: $mselected)
            } else if !headerize && footerize {
                TablerStackMB(stackConfig,
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
