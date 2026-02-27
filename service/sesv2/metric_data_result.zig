/// The result of a single metric data query.
pub const MetricDataResult = struct {
    /// The query identifier.
    id: ?[]const u8,

    /// A list of timestamps for the metric data results.
    timestamps: ?[]const i64,

    /// A list of values (cumulative / sum) for the metric data results.
    values: ?[]const i64,

    pub const json_field_names = .{
        .id = "Id",
        .timestamps = "Timestamps",
        .values = "Values",
    };
};
