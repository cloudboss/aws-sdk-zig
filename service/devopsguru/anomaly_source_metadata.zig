/// Metadata about the detection source that generates proactive anomalies. The
/// anomaly is
/// detected using analysis of the metric data  over a period of time
pub const AnomalySourceMetadata = struct {
    /// The source of the anomaly.
    source: ?[]const u8 = null,

    /// The name of the anomaly's resource.
    source_resource_name: ?[]const u8 = null,

    /// The anomaly's resource type.
    source_resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .source = "Source",
        .source_resource_name = "SourceResourceName",
        .source_resource_type = "SourceResourceType",
    };
};
