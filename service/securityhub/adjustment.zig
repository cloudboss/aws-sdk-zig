/// An adjustment to the CVSS metric.
pub const Adjustment = struct {
    /// The metric to adjust.
    metric: ?[]const u8 = null,

    /// The reason for the adjustment.
    reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .metric = "Metric",
        .reason = "Reason",
    };
};
