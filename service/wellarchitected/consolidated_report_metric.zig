const aws = @import("aws");

const LensMetric = @import("lens_metric.zig").LensMetric;
const MetricType = @import("metric_type.zig").MetricType;

/// A metric that contributes to the consolidated report.
pub const ConsolidatedReportMetric = struct {
    /// The metrics for the lenses in the workload.
    lenses: ?[]const LensMetric,

    /// The total number of lenses applied to the workload.
    lenses_applied_count: ?i32,

    /// The metric type of a metric in the consolidated report. Currently only
    /// WORKLOAD metric types are supported.
    metric_type: ?MetricType,

    risk_counts: ?[]const aws.map.MapEntry(i32),

    updated_at: ?i64,

    workload_arn: ?[]const u8,

    workload_id: ?[]const u8,

    workload_name: ?[]const u8,

    pub const json_field_names = .{
        .lenses = "Lenses",
        .lenses_applied_count = "LensesAppliedCount",
        .metric_type = "MetricType",
        .risk_counts = "RiskCounts",
        .updated_at = "UpdatedAt",
        .workload_arn = "WorkloadArn",
        .workload_id = "WorkloadId",
        .workload_name = "WorkloadName",
    };
};
