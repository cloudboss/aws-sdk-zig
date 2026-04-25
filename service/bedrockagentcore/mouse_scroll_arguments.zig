/// Arguments for a mouse scroll action.
pub const MouseScrollArguments = struct {
    /// The horizontal scroll delta. Valid range: -1000 to 1000.
    delta_x: ?i32 = null,

    /// The vertical scroll delta. Valid range: -1000 to 1000. Negative values
    /// scroll down.
    delta_y: ?i32 = null,

    /// The X coordinate on screen where the scroll occurs.
    x: i32,

    /// The Y coordinate on screen where the scroll occurs.
    y: i32,

    pub const json_field_names = .{
        .delta_x = "deltaX",
        .delta_y = "deltaY",
        .x = "x",
        .y = "y",
    };
};
