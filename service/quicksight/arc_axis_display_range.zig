/// The arc axis range of a `GaugeChartVisual`.
pub const ArcAxisDisplayRange = struct {
    /// The maximum value of the arc axis range.
    max: ?f64 = null,

    /// The minimum value of the arc axis range.
    min: ?f64 = null,

    pub const json_field_names = .{
        .max = "Max",
        .min = "Min",
    };
};
