/// Threshold to be used for the isoline calculation. Up to 5 thresholds per
/// provided type can be requested.
pub const IsolineThresholds = struct {
    /// Distance to be used for the isoline calculation.
    distance: ?[]const i64,

    /// Time to be used for the isoline calculation.
    time: ?[]const i64,

    pub const json_field_names = .{
        .distance = "Distance",
        .time = "Time",
    };
};
