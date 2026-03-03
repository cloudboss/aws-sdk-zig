const RDSDBMetricName = @import("rdsdb_metric_name.zig").RDSDBMetricName;

/// Describes the projected metrics of an Amazon Aurora and RDS database
/// recommendation option.
///
/// To determine the performance difference between your current Amazon Aurora
/// and RDS database
/// and the recommended option, compare the metric data of your service against
/// its projected metric data.
pub const RDSDatabaseProjectedMetric = struct {
    /// The name of the projected metric.
    name: ?RDSDBMetricName = null,

    /// The timestamps of the projected metric.
    timestamps: ?[]const i64 = null,

    /// The values for the projected metric.
    values: ?[]const f64 = null,

    pub const json_field_names = .{
        .name = "name",
        .timestamps = "timestamps",
        .values = "values",
    };
};
