/// Provides insights into the table with the most sub-optimal spatial range
/// scanned by your query.
pub const QuerySpatialCoverageMax = struct {
    /// The partition key used for partitioning, which can be a default
    /// `measure_name` or a [customer defined partition
    /// key](https://docs.aws.amazon.com/timestream/latest/developerguide/customer-defined-partition-keys.html).
    partition_key: ?[]const []const u8,

    /// The Amazon Resource Name (ARN) of the table with the most sub-optimal
    /// spatial pruning.
    table_arn: ?[]const u8,

    /// The maximum ratio of spatial coverage.
    value: f64 = 0,

    pub const json_field_names = .{
        .partition_key = "PartitionKey",
        .table_arn = "TableArn",
        .value = "Value",
    };
};
