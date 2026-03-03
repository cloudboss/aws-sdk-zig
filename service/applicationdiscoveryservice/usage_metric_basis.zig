/// Specifies the performance metrics to use for the server that is used for
/// recommendations.
pub const UsageMetricBasis = struct {
    /// A utilization metric that is used by the recommendations.
    name: ?[]const u8 = null,

    /// Specifies the percentage of the specified utilization metric that is used by
    /// the recommendations.
    percentage_adjust: ?f64 = null,

    pub const json_field_names = .{
        .name = "name",
        .percentage_adjust = "percentageAdjust",
    };
};
