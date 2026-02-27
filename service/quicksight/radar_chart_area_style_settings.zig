const Visibility = @import("visibility.zig").Visibility;

/// The configured style settings of a radar chart.
pub const RadarChartAreaStyleSettings = struct {
    /// The visibility settings of a radar chart.
    visibility: ?Visibility,

    pub const json_field_names = .{
        .visibility = "Visibility",
    };
};
