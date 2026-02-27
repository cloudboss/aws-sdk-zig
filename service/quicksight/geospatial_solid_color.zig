const GeospatialColorState = @import("geospatial_color_state.zig").GeospatialColorState;

/// The definition for a solid color.
pub const GeospatialSolidColor = struct {
    /// The color and opacity values for the color.
    color: []const u8,

    /// Enables and disables the view state of the color.
    state: ?GeospatialColorState,

    pub const json_field_names = .{
        .color = "Color",
        .state = "State",
    };
};
