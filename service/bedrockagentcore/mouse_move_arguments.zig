/// Arguments for a mouse move action.
pub const MouseMoveArguments = struct {
    /// The target X coordinate on screen.
    x: i32,

    /// The target Y coordinate on screen.
    y: i32,

    pub const json_field_names = .{
        .x = "x",
        .y = "y",
    };
};
