const Visibility = @import("visibility.zig").Visibility;

/// The options that determine the presentation of trend arrows in a KPI visual.
pub const TrendArrowOptions = struct {
    /// The visibility of the trend arrows.
    visibility: ?Visibility = null,

    pub const json_field_names = .{
        .visibility = "Visibility",
    };
};
