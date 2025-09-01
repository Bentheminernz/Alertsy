//
//  AlertModels.swift
//  Alertsy
//
//  Created by Ben Lawrence on 17/08/2025.
//

/// The presentation style for alerts and confirmation dialogs.
public enum AlertPresentationStyle: Sendable, Equatable {
    /// Present as a standard alert dialog.
    case alert
    /// Present as a confirmation dialog (action sheet style).
    case confirmationDialog
}

public struct AlertConfiguration: Sendable, Equatable {
    /// The title of the alert.
    public let title: String
    
    /// An optional message to display in the alert.
    public let message: String?
    
    /// The presentation style (alert or confirmation dialog).
    public let presentationStyle: AlertPresentationStyle
    
    /// The optional primary action button for the alert.
    public let primaryAction: AlertAction?
    
    /// The optional secondary action button for the alert.
    public let secondaryAction: AlertAction?
    
    /// Additional actions for confirmation dialogs (supports multiple actions).
    public let additionalActions: [AlertAction]
    
    public init(
        title: String,
        message: String? = nil,
        presentationStyle: AlertPresentationStyle = .alert,
        primaryAction: AlertAction? = nil,
        secondaryAction: AlertAction? = nil,
        additionalActions: [AlertAction] = []
    ) {
        self.title = title
        self.message = message
        self.presentationStyle = presentationStyle
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
        self.additionalActions = additionalActions
    }
}

public struct AlertAction: Sendable, Equatable {
    /// The title of the action button.
    public let title: String
    
    /// The style of the action button.
    public let style: Style
    
    /// The action to perform when the button is tapped.
    public let action: @Sendable () -> Void
    
    /// The style of the alert action button.
    public enum Style: Sendable, Equatable {
        /// A default action button style.
        case `default`
        
        /// A cancel action button style.
        case cancel
        
        /// A destructive action button style.
        case destructive
    }
    
    public init(
        title: String,
        style: Style = .default,
        action: @Sendable @escaping () -> Void = {}
    ) {
        self.title = title
        self.style = style
        self.action = action
    }
    
    // Equatable conformance - comparing only title and style since functions can't be compared
    public static func == (lhs: AlertAction, rhs: AlertAction) -> Bool {
        lhs.title == rhs.title && lhs.style == rhs.style
    }
}
