//
//  KeyEventPublisher.swift
//  
//
//  Created by yuki on 2023/12/15.
//

import AppKit

final class KeyEventPublisher {
    func keyEvent(_ key: Int, keyDown: Bool = true, modifierFlags: NSEvent.ModifierFlags = []) -> NSEvent {
        let flags = convert(modifierFlags)
        let event = createCGEvent(CGKeyCode(key), keyDown: keyDown, modifierFlags: flags)
        guard let nsEvent = NSEvent(cgEvent: event) else {
            fatalError("Failed to create NSEvent")
        }
        return nsEvent
    }
    
    private func convert(_ modifierFlags: NSEvent.ModifierFlags) -> CGEventFlags {
        var flags: CGEventFlags = []
        if modifierFlags.contains(.capsLock) {
            flags.insert(.maskAlphaShift)
        }
        if modifierFlags.contains(.shift) {
            flags.insert(.maskShift)
        }
        if modifierFlags.contains(.control) {
            flags.insert(.maskControl)
        }
        if modifierFlags.contains(.option) {
            flags.insert(.maskAlternate)
        }
        if modifierFlags.contains(.command) {
            flags.insert(.maskCommand)
        }
        if modifierFlags.contains(.numericPad) {
            flags.insert(.maskNumericPad)
        }
        if modifierFlags.contains(.help) {
            flags.insert(.maskHelp)
        }
        if modifierFlags.contains(.function) {
            flags.insert(.maskSecondaryFn)
        }
        return flags
    }
    
    private func createCGEvent(_ key: CGKeyCode, keyDown: Bool, modifierFlags: CGEventFlags) -> CGEvent {
        let source = CGEventSource(stateID: .hidSystemState)
        guard let event = CGEvent(keyboardEventSource: source, virtualKey: key, keyDown: keyDown) else {
            fatalError("Failed to create CGEvent")
        }
        event.flags = modifierFlags
        return event
    }
}
