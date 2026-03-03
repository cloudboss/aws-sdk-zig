const aws = @import("aws");

/// An object that includes the requested dimension key values and aggregated
/// metric values
/// within a dimension group.
pub const DimensionKeyDescription = struct {
    /// A map that contains the value for each additional metric.
    additional_metrics: ?[]const aws.map.MapEntry(f64) = null,

    /// A map of name-value pairs for the dimensions in the group.
    dimensions: ?[]const aws.map.StringMapEntry = null,

    /// If `PartitionBy` was specified, `PartitionKeys` contains the dimensions that
    /// were.
    partitions: ?[]const f64 = null,

    /// The aggregated metric value for the dimensions, over the requested time
    /// range.
    total: ?f64 = null,

    pub const json_field_names = .{
        .additional_metrics = "AdditionalMetrics",
        .dimensions = "Dimensions",
        .partitions = "Partitions",
        .total = "Total",
    };
};
