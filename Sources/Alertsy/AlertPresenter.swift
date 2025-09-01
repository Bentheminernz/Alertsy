//
//  AlertPresenter.swift
//  Alertsy
//
//  Created by Ben Lawrence on 17/08/2025.
//

import SwiftUI

extension View {
    func withAlertManager(_ alertManager: AlertManager) -> some View {
        self.alert(
            alertManager.configuration?.title ?? "",
            isPresented: Binding(
                get: { 
                    alertManager.isPresented && alertManager.configuration?.presentationStyle == .alert
                },
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
                        alertManager.dismiss()
                    }
                }
                
                if let secondaryAction = config.secondaryAction {
                    Button(secondaryAction.title, role: buttonRole(for: secondaryAction.style)) {
                        secondaryAction.action()
                        alertManager.dismiss()
                    }
                }
                
                if config.primaryAction == nil && config.secondaryAction == nil {
                    Button("OK", role: .cancel) {
                        alertManager.dismiss()
                    }
                }
            }
        } message: {
            if let message = alertManager.configuration?.message {
                Text(message)
            }
        }
        .confirmationDialog(
            alertManager.configuration?.title ?? "",
            isPresented: Binding(
                get: { 
                    alertManager.isPresented && alertManager.configuration?.presentationStyle == .confirmationDialog
                },
                set: { newValue in
                    if !newValue {
                        alertManager.dismiss()
                    }
                }
            )
        ) {
            if let config = alertManager.configuration {
                // For confirmation dialogs, use additionalActions primarily
                ForEach(Array(config.additionalActions.enumerated()), id: \.offset) { index, action in
                    Button(action.title, role: buttonRole(for: action.style)) {
                        action.action()
                        alertManager.dismiss()
                    }
                }
                
                // Fallback to primary/secondary actions if no additional actions
                if config.additionalActions.isEmpty {
                    if let primaryAction = config.primaryAction {
                        Button(primaryAction.title, role: buttonRole(for: primaryAction.style)) {
                            primaryAction.action()
                            alertManager.dismiss()
                        }
                    }
                    
                    if let secondaryAction = config.secondaryAction {
                        Button(secondaryAction.title, role: buttonRole(for: secondaryAction.style)) {
                            secondaryAction.action()
                            alertManager.dismiss()
                        }
                    }
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
