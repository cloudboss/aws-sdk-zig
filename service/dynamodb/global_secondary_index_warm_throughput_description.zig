const IndexStatus = @import("index_status.zig").IndexStatus;

/// The description of the warm throughput value on a global secondary index.
pub const GlobalSecondaryIndexWarmThroughputDescription = struct {
    /// Represents warm throughput read units per second value for a global
    /// secondary
    /// index.
    read_units_per_second: ?i64,

    /// Represents the warm throughput status being created or updated on a global
    /// secondary
    /// index. The status can only be `UPDATING` or `ACTIVE`.
    status: ?IndexStatus,

    /// Represents warm throughput write units per second value for a global
    /// secondary
    /// index.
    write_units_per_second: ?i64,

    pub const json_field_names = .{
        .read_units_per_second = "ReadUnitsPerSecond",
        .status = "Status",
        .write_units_per_second = "WriteUnitsPerSecond",
    };
};
