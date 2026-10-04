const PartitionStrategy = @import("partition_strategy.zig").PartitionStrategy;
const PartitionSource = @import("partition_source.zig").PartitionSource;

/// Partition specification for an Apache Iceberg destination table.
pub const PartitionSpec = struct {
    /// The partitioning strategy applied to records written to the table.
    partition_strategy: PartitionStrategy,

    /// The source columns used by the partitioning strategy. For TIME_HOUR, must
    /// contain exactly one source column whose value is a timestamp.
    source_list: ?[]const PartitionSource = null,

    pub const json_field_names = .{
        .partition_strategy = "PartitionStrategy",
        .source_list = "SourceList",
    };
};
