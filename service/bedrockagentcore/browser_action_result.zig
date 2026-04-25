const KeyPressResult = @import("key_press_result.zig").KeyPressResult;
const KeyShortcutResult = @import("key_shortcut_result.zig").KeyShortcutResult;
const KeyTypeResult = @import("key_type_result.zig").KeyTypeResult;
const MouseClickResult = @import("mouse_click_result.zig").MouseClickResult;
const MouseDragResult = @import("mouse_drag_result.zig").MouseDragResult;
const MouseMoveResult = @import("mouse_move_result.zig").MouseMoveResult;
const MouseScrollResult = @import("mouse_scroll_result.zig").MouseScrollResult;
const ScreenshotResult = @import("screenshot_result.zig").ScreenshotResult;

/// The result of a browser action execution. Exactly one member is set,
/// matching the action that was performed.
pub const BrowserActionResult = union(enum) {
    /// The result of a key press action.
    key_press: ?KeyPressResult,
    /// The result of a key shortcut action.
    key_shortcut: ?KeyShortcutResult,
    /// The result of a key type action.
    key_type: ?KeyTypeResult,
    /// The result of a mouse click action.
    mouse_click: ?MouseClickResult,
    /// The result of a mouse drag action.
    mouse_drag: ?MouseDragResult,
    /// The result of a mouse move action.
    mouse_move: ?MouseMoveResult,
    /// The result of a mouse scroll action.
    mouse_scroll: ?MouseScrollResult,
    /// The result of a screenshot action.
    screenshot: ?ScreenshotResult,

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
