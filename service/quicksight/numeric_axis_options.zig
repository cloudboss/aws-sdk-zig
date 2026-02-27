const AxisDisplayRange = @import("axis_display_range.zig").AxisDisplayRange;
const AxisScale = @import("axis_scale.zig").AxisScale;

/// The options for an axis with a numeric field.
pub const NumericAxisOptions = struct {
    /// The range setup of a numeric axis.
    range: ?AxisDisplayRange,

    /// The scale setup of a numeric axis.
    scale: ?AxisScale,

    pub const json_field_names = .{
        .range = "Range",
        .scale = "Scale",
    };
};
