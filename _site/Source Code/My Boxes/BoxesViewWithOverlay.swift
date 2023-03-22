//
//  BoxesViewWithOverlay.swift
//  My Boxes
//
//  Created by Mirae on 2022/10/17.
//

import SwiftUI

struct BoxesViewWithOverlay: View {
    @Binding var boxes: [Box]
    
    var body: some View {
        BoxesView(boxes: $boxes, saveAction: { })
    }
}

struct BoxesViewWithOverlay_Previews: PreviewProvider {
    static var previews: some View {
        BoxesViewWithOverlay(boxes: .constant(Box.sampleData))
    }
}
