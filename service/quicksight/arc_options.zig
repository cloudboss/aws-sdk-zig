const ArcThickness = @import("arc_thickness.zig").ArcThickness;

/// The options that determine the arc thickness of a `GaugeChartVisual`.
pub const ArcOptions = struct {
    /// The arc thickness of a `GaugeChartVisual`.
    arc_thickness: ?ArcThickness = null,

    pub const json_field_names = .{
        .arc_thickness = "ArcThickness",
    };
};
