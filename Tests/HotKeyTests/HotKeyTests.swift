import Carbon
import XCTest
@testable import HotKey

final class HotKeyTests: XCTestCase {
    let keyEventPublisher = KeyEventPublisher()
    
    func testEventKeyCheck() throws {
        let letters = [
            kVK_ANSI_A, kVK_ANSI_B, kVK_ANSI_C, kVK_ANSI_D, kVK_ANSI_E,
            kVK_ANSI_F, kVK_ANSI_G, kVK_ANSI_H, kVK_ANSI_I, kVK_ANSI_J,
            kVK_ANSI_K, kVK_ANSI_L, kVK_ANSI_M, kVK_ANSI_N, kVK_ANSI_O,
            kVK_ANSI_P, kVK_ANSI_Q, kVK_ANSI_R, kVK_ANSI_S, kVK_ANSI_T,
            kVK_ANSI_U, kVK_ANSI_V, kVK_ANSI_W, kVK_ANSI_X, kVK_ANSI_Y,
            kVK_ANSI_Z
        ]
        let keys = [
            Key.a, Key.b, Key.c, Key.d, Key.e,
            Key.f, Key.g, Key.h, Key.i, Key.j,
            Key.k, Key.l, Key.m, Key.n, Key.o,
            Key.p, Key.q, Key.r, Key.s, Key.t,
            Key.u, Key.v, Key.w, Key.x, Key.y,
            Key.z
        ]
        
        let modifiers: [NSEvent.ModifierFlags] = [
            [], .capsLock, .shift, .control, .option, .command,
            .numericPad, .help, .function
        ]
        
        for (letter, key) in zip(letters, keys) {
            for modifier in modifiers {
                let event = keyEventPublisher.keyEvent(letter, keyDown: true, modifierFlags: modifier)
                XCTAssertEqual(event.hotKey, HotKey(key, modifier))
            }
        }        
    }
    
    func testHotKey() throws {
        XCTAssertEqual(
            keyEventPublisher.keyEvent(kVK_ANSI_C, modifierFlags: .command).hotKey,
            HotKey.copy
        )
        XCTAssertEqual(
            keyEventPublisher.keyEvent(kVK_ANSI_V, modifierFlags: .command).hotKey,
            HotKey.paste
        )
        XCTAssertEqual(
            keyEventPublisher.keyEvent(kVK_ANSI_X, modifierFlags: .command).hotKey,
            HotKey.cut
        )
        XCTAssertEqual(
            keyEventPublisher.keyEvent(kVK_ANSI_Z, modifierFlags: .command).hotKey,
            HotKey.undo
        )
        XCTAssertEqual(
            keyEventPublisher.keyEvent(kVK_ANSI_Z, modifierFlags: [.command, .shift]).hotKey,
            HotKey.redo
        )
    }
}
