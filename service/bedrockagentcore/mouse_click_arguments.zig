const MouseButton = @import("mouse_button.zig").MouseButton;

/// Arguments for a mouse click action.
pub const MouseClickArguments = struct {
    /// The mouse button to use. Defaults to `LEFT`.
    button: ?MouseButton = null,

    /// The number of clicks to perform. Valid range: 1–10. Defaults to 1.
    click_count: ?i32 = null,

    /// The X coordinate on screen where the click occurs.
    x: i32,

    /// The Y coordinate on screen where the click occurs.
    y: i32,

    pub const json_field_names = .{
        .button = "button",
        .click_count = "clickCount",
        .x = "x",
        .y = "y",
    };
};
