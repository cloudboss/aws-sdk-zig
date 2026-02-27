const WarmThroughputStatus = @import("warm_throughput_status.zig").WarmThroughputStatus;

/// Contains the current warm throughput settings for a table, including the
/// configured capacity units and the current status of the warm throughput
/// configuration.
pub const WarmThroughputSpecificationSummary = struct {
    /// The number of read capacity units per second currently configured for warm
    /// throughput.
    read_units_per_second: i64,

    /// The current status of the warm throughput configuration. Valid values are
    /// `AVAILABLE` when the configuration is active, and `UPDATING` when changes
    /// are being applied.
    status: WarmThroughputStatus,

    /// The number of write capacity units per second currently configured for warm
    /// throughput.
    write_units_per_second: i64,

    pub const json_field_names = .{
        .read_units_per_second = "readUnitsPerSecond",
        .status = "status",
        .write_units_per_second = "writeUnitsPerSecond",
    };
};
