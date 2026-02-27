/// A data point for a top contributor network flow in a scope. Network Flow
/// Monitor returns information about the network flows with the top values for
/// each metric type, which are called top contributors.
pub const WorkloadInsightsTopContributorsDataPoint = struct {
    /// The label identifying the data point.
    label: []const u8,

    /// An array of the timestamps for the data point.
    timestamps: []const i64,

    /// The values for the data point.
    values: []const f64,

    pub const json_field_names = .{
        .label = "label",
        .timestamps = "timestamps",
        .values = "values",
    };
};
