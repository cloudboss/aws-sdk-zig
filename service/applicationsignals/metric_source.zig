const aws = @import("aws");

/// Identifies the metric source for SLOs on resources other than Application
/// Signals services.
pub const MetricSource = struct {
    /// Additional attributes for the metric source.
    metric_source_attributes: ?[]const aws.map.StringMapEntry = null,

    /// Key attributes that identify the metric source.
    metric_source_key_attributes: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .metric_source_attributes = "MetricSourceAttributes",
        .metric_source_key_attributes = "MetricSourceKeyAttributes",
    };
};
