const VisualType = @import("visual_type.zig").VisualType;

/// Defines the visual representation settings for widget data, including the
/// visualization type, styling options, and display preferences for different
/// metric types.
pub const GraphDisplayConfig = struct {
    /// The type of visualization to use for the data.
    visual_type: VisualType,

    pub const json_field_names = .{
        .visual_type = "visualType",
    };
};
