//
//  FHKPopupConfig.swift
//  FHKUtils
//
//  Created by Fredy Leon on 2/3/26.
//

import SwiftUI

public enum FHKPopupType {
    case information(buttonText: String)
    case confirmation(okText: String, cancelText: String)
}

public struct FHKPopupConfig {
    let title: String
    let message: String
    let type: FHKPopupType
    let onOK: () -> Void
    let onCancel: (() -> Void)?

    public init(
        title: String,
        message: String,
        type: FHKPopupType,
        onOK: @escaping () -> Void,
        onCancel: (() -> Void)? = nil
    ) {
        self.title = title
        self.message = message
        self.type = type
        self.onOK = onOK
        self.onCancel = onCancel
    }
}
