import SwiftUI

private struct AlertsyKey: @MainActor EnvironmentKey {
    @MainActor
    static let defaultValue: AlertManager = AlertManager()
}

public extension EnvironmentValues {
    /// Accessor for the shared `AlertManager` instance.
    @MainActor
    var alertsy: AlertManager {
        get { self[AlertsyKey.self] }
        set { self[AlertsyKey.self] = newValue }
    }
}

public extension View {
    /// Adds the shared `AlertManager` to the view's environment and sets up the alert presentation.
    func alertsy(_ manager: AlertManager = .shared) -> some View {
        environment(\.alertsy, manager)
            .withAlertManager(manager)
    }
}
