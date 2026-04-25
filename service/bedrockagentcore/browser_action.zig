const KeyPressArguments = @import("key_press_arguments.zig").KeyPressArguments;
const KeyShortcutArguments = @import("key_shortcut_arguments.zig").KeyShortcutArguments;
const KeyTypeArguments = @import("key_type_arguments.zig").KeyTypeArguments;
const MouseClickArguments = @import("mouse_click_arguments.zig").MouseClickArguments;
const MouseDragArguments = @import("mouse_drag_arguments.zig").MouseDragArguments;
const MouseMoveArguments = @import("mouse_move_arguments.zig").MouseMoveArguments;
const MouseScrollArguments = @import("mouse_scroll_arguments.zig").MouseScrollArguments;
const ScreenshotArguments = @import("screenshot_arguments.zig").ScreenshotArguments;

/// The browser action to perform. Exactly one member must be set per request.
pub const BrowserAction = union(enum) {
    /// Press a key one or more times.
    key_press: ?KeyPressArguments,
    /// Press a key combination.
    key_shortcut: ?KeyShortcutArguments,
    /// Type a string of text.
    key_type: ?KeyTypeArguments,
    /// Click at the specified coordinates.
    mouse_click: ?MouseClickArguments,
    /// Drag from a start position to an end position.
    mouse_drag: ?MouseDragArguments,
    /// Move the cursor to the specified coordinates.
    mouse_move: ?MouseMoveArguments,
    /// Scroll at the specified position.
    mouse_scroll: ?MouseScrollArguments,
    /// Capture a full-screen screenshot.
    screenshot: ?ScreenshotArguments,

    pub const json_field_names = .{
        .key_press = "keyPress",
        .key_shortcut = "keyShortcut",
        .key_type = "keyType",
        .mouse_click = "mouseClick",
        .mouse_drag = "mouseDrag",
        .mouse_move = "mouseMove",
        .mouse_scroll = "mouseScroll",
        .screenshot = "screenshot",
    };
};
