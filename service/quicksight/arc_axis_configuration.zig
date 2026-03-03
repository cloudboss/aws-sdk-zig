const ArcAxisDisplayRange = @import("arc_axis_display_range.zig").ArcAxisDisplayRange;

/// The arc axis configuration of a `GaugeChartVisual`.
pub const ArcAxisConfiguration = struct {
    /// The arc axis range of a `GaugeChartVisual`.
    range: ?ArcAxisDisplayRange = null,

    /// The reserved range of the arc axis.
    reserve_range: i32 = 0,

    pub const json_field_names = .{
        .range = "Range",
        .reserve_range = "ReserveRange",
    };
};
