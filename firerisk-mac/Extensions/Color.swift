//
//  Color.swift
//  firerisk-mac
//
//  Created by Jonas Lindau on 2026-04-05.
//

import SwiftUI

extension Color {
    static func riskColor(for risk: Int) -> Color {
        switch risk {
        case 1: return Color.blue       //TODO #4A90E2
        case 2: return Color.green      //TODO #2E7D32
        case 3: return Color.yellow     //TODO #F9D423
        case 4: return Color.orange     //TODO #F39C12
        case 5: return Color.red        //TODO #E74C3C
        case 6: return Color.red        //TODO #8B0000
        default: return Color.gray
        }
    }
}
