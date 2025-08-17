//
//  AlertPresenter.swift
//  Alertsy
//
//  Created by Ben Lawrence on 17/08/2025.
//

import SwiftUI

public extension View {
    func withAlertManager(_ alertManager: AlertManager) -> some View {
        self.alert(
            alertManager.configuration?.title ?? "",
            isPresented: Binding(
                get: { alertManager.isPresented },
                set: { newValue in
                    if !newValue {
                        alertManager.dismiss()
                    }
                }
            )
        ) {
            if let config = alertManager.configuration {
                if let primaryAction = config.primaryAction {
                    Button(primaryAction.title, role: buttonRole(for: primaryAction.style)) {
                        primaryAction.action()
                    }
                }
                
                if let secondaryAction = config.secondaryAction {
                    Button(secondaryAction.title, role: buttonRole(for: secondaryAction.style)) {
                        secondaryAction.action()
                    }
                }
                
                if config.primaryAction == nil && config.secondaryAction == nil {
                    Button("OK", role: .cancel) {}
                }
            }
        } message: {
            if let message = alertManager.configuration?.message {
                Text(message)
            }
        }
    }
}

private func buttonRole(for style: AlertAction.Style) -> ButtonRole? {
    switch style {
    case .default: return nil
    case .cancel: return .cancel
    case .destructive: return .destructive
    }
}

public extension View {
    func withAlertManager() -> some View {
        self.withAlertManager(.shared)
    }
}
