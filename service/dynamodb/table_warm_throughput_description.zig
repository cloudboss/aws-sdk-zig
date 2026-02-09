const TableStatus = @import("table_status.zig").TableStatus;

/// Represents the warm throughput value (in read units per second and write
/// units per
/// second) of the table. Warm throughput is applicable for DynamoDB Standard-IA
/// tables and
/// specifies the minimum provisioned capacity maintained for immediate data
/// access.
pub const TableWarmThroughputDescription = struct {
    /// Represents the base table's warm throughput value in read units per second.
    read_units_per_second: ?i64,

    /// Represents warm throughput value of the base table.
    status: ?TableStatus,

    /// Represents the base table's warm throughput value in write units per second.
    write_units_per_second: ?i64,
};
