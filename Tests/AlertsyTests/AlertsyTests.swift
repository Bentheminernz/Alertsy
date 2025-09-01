import Testing
@testable import Alertsy

@MainActor
@Test func alertManagerInitialization() async throws {
    let manager = AlertManager()
    #expect(!manager.isPresented)
    #expect(manager.configuration == nil)
}

@MainActor
@Test func showBasicAlert() async throws {
    let manager = AlertManager()
    
    manager.show(
        title: "Test Alert",
        message: "Test message",
        primaryAction: AlertAction(title: "OK")
    )
    
    #expect(manager.isPresented)
    #expect(manager.configuration?.title == "Test Alert")
    #expect(manager.configuration?.message == "Test message")
    #expect(manager.configuration?.presentationStyle == .alert)
    #expect(manager.configuration?.primaryAction?.title == "OK")
}

@MainActor
@Test func showConfirmationDialog() async throws {
    let manager = AlertManager()
    
    manager.showConfirmationDialog(
        title: "Confirm Action",
        message: "Are you sure?",
        confirmTitle: "Yes",
        cancelTitle: "No",
        onConfirm: {}
    )
    
    #expect(manager.isPresented)
    #expect(manager.configuration?.title == "Confirm Action")
    #expect(manager.configuration?.message == "Are you sure?")
    #expect(manager.configuration?.presentationStyle == .confirmationDialog)
    #expect(manager.configuration?.additionalActions.count == 2)
    #expect(manager.configuration?.additionalActions.first?.title == "Yes")
    #expect(manager.configuration?.additionalActions.last?.title == "No")
    #expect(manager.configuration?.additionalActions.last?.style == .cancel)
}

@MainActor
@Test func showDestructiveConfirmationDialog() async throws {
    let manager = AlertManager()
    
    manager.showDestructiveConfirmationDialog(
        title: "Delete Item",
        message: "This action cannot be undone",
        destructiveTitle: "Delete",
        cancelTitle: "Cancel",
        onConfirm: {}
    )
    
    #expect(manager.isPresented)
    #expect(manager.configuration?.title == "Delete Item")
    #expect(manager.configuration?.message == "This action cannot be undone")
    #expect(manager.configuration?.presentationStyle == .confirmationDialog)
    #expect(manager.configuration?.additionalActions.count == 2)
    #expect(manager.configuration?.additionalActions.first?.title == "Delete")
    #expect(manager.configuration?.additionalActions.first?.style == .destructive)
    #expect(manager.configuration?.additionalActions.last?.title == "Cancel")
    #expect(manager.configuration?.additionalActions.last?.style == .cancel)
}

@MainActor
@Test func showConfirmationDialogWithMultipleActions() async throws {
    let manager = AlertManager()
    
    let actions = [
        AlertAction(title: "Action 1", style: .default, action: {}),
        AlertAction(title: "Action 2", style: .default, action: {}),
        AlertAction(title: "Delete", style: .destructive, action: {}),
        AlertAction(title: "Cancel", style: .cancel, action: {})
    ]
    
    manager.showConfirmationDialog(
        title: "Multiple Actions",
        message: "Choose an option",
        actions: actions
    )
    
    #expect(manager.isPresented)
    #expect(manager.configuration?.title == "Multiple Actions")
    #expect(manager.configuration?.message == "Choose an option")
    #expect(manager.configuration?.presentationStyle == .confirmationDialog)
    #expect(manager.configuration?.additionalActions.count == 4)
    #expect(manager.configuration?.additionalActions[2].style == .destructive)
    #expect(manager.configuration?.additionalActions[3].style == .cancel)
}

@MainActor
@Test func dismissAlert() async throws {
    let manager = AlertManager()
    
    manager.show(title: "Test", message: "Test")
    #expect(manager.isPresented)
    
    manager.dismiss()
    #expect(!manager.isPresented)
    #expect(manager.configuration == nil)
}

@MainActor
@Test func convenienceMethodsAlert() async throws {
    let manager = AlertManager()
    
    // Test error alert
    manager.showError("Error message")
    #expect(manager.isPresented)
    #expect(manager.configuration?.title == "Error")
    #expect(manager.configuration?.message == "Error message")
    #expect(manager.configuration?.presentationStyle == .alert)
    
    manager.dismiss()
    
    // Test success alert
    manager.showSuccess("Success message")
    #expect(manager.isPresented)
    #expect(manager.configuration?.title == "Success")
    #expect(manager.configuration?.message == "Success message")
    #expect(manager.configuration?.presentationStyle == .alert)
}

@MainActor
@Test func backwardCompatibility() async throws {
    let manager = AlertManager()
    
    // Test that existing alert methods still work with .alert presentation style
    manager.showConfirmation(
        title: "Confirm",
        message: "Are you sure?",
        confirmTitle: "Yes",
        cancelTitle: "No",
        onConfirm: {}
    )
    
    #expect(manager.isPresented)
    #expect(manager.configuration?.presentationStyle == .alert)
    #expect(manager.configuration?.primaryAction?.title == "Yes")
    #expect(manager.configuration?.secondaryAction?.title == "No")
}
