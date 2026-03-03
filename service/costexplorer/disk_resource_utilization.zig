/// The field that contains a list of disk (local storage) metrics that are
/// associated
/// with the current instance.
pub const DiskResourceUtilization = struct {
    /// The maximum read throughput operations per second.
    disk_read_bytes_per_second: ?[]const u8 = null,

    /// The maximum number of read operations per second.
    disk_read_ops_per_second: ?[]const u8 = null,

    /// The maximum write throughput operations per second.
    disk_write_bytes_per_second: ?[]const u8 = null,

    /// The maximum number of write operations per second.
    disk_write_ops_per_second: ?[]const u8 = null,

    pub const json_field_names = .{
        .disk_read_bytes_per_second = "DiskReadBytesPerSecond",
        .disk_read_ops_per_second = "DiskReadOpsPerSecond",
        .disk_write_bytes_per_second = "DiskWriteBytesPerSecond",
        .disk_write_ops_per_second = "DiskWriteOpsPerSecond",
    };
};
