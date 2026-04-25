const MouseButton = @import("mouse_button.zig").MouseButton;

/// Arguments for a mouse drag action.
pub const MouseDragArguments = struct {
    /// The mouse button to use for the drag. Defaults to `LEFT`.
    button: ?MouseButton = null,

    /// The ending X coordinate for the drag.
    end_x: i32,

    /// The ending Y coordinate for the drag.
    end_y: i32,

    /// The starting X coordinate for the drag.
    start_x: i32,

    /// The starting Y coordinate for the drag.
    start_y: i32,

    pub const json_field_names = .{
        .button = "button",
        .end_x = "endX",
        .end_y = "endY",
        .start_x = "startX",
        .start_y = "startY",
    };
};
