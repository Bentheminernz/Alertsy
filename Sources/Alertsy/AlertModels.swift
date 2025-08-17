//
//  AlertModels.swift
//  Alertsy
//
//  Created by Ben Lawrence on 17/08/2025.
//

public struct AlertConfiguration: Sendable {
    /// The title of the alert.
    public let title: String
    
    /// An optional message to display in the alert.
    public let message: String?
    
    /// The optional primary action button for the alert.
    public let primaryAction: AlertAction?
    
    /// The optional secondary action button for the alert.
    public let secondaryAction: AlertAction?
    
    public init(
        title: String,
        message: String? = nil,
        primaryAction: AlertAction? = nil,
        secondaryAction: AlertAction? = nil
    ) {
        self.title = title
        self.message = message
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
    }
}

public struct AlertAction: Sendable {
    /// The title of the action button.
    public let title: String
    
    /// The style of the action button.
    public let style: Style
    
    /// The action to perform when the button is tapped.
    public let action: @Sendable () -> Void
    
    /// The style of the alert action button.
    public enum Style: Sendable {
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
}
