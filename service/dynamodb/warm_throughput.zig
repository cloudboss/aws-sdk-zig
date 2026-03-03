/// Provides visibility into the number of read and write operations your table
/// or
/// secondary index can instantaneously support. The settings can be modified
/// using the
/// `UpdateTable` operation to meet the throughput requirements of an
/// upcoming peak event.
pub const WarmThroughput = struct {
    /// Represents the number of read operations your base table can instantaneously
    /// support.
    read_units_per_second: ?i64 = null,

    /// Represents the number of write operations your base table can
    /// instantaneously
    /// support.
    write_units_per_second: ?i64 = null,

    pub const json_field_names = .{
        .read_units_per_second = "ReadUnitsPerSecond",
        .write_units_per_second = "WriteUnitsPerSecond",
    };
};
