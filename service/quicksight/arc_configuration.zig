const ArcThicknessOptions = @import("arc_thickness_options.zig").ArcThicknessOptions;

/// The arc configuration of a `GaugeChartVisual`.
pub const ArcConfiguration = struct {
    /// The option that determines the arc angle of a `GaugeChartVisual`.
    arc_angle: ?f64,

    /// The options that determine the arc thickness of a `GaugeChartVisual`.
    arc_thickness: ?ArcThicknessOptions,

    pub const json_field_names = .{
        .arc_angle = "ArcAngle",
        .arc_thickness = "ArcThickness",
    };
};
