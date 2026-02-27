const DataReplicationErrorString = @import("data_replication_error_string.zig").DataReplicationErrorString;

/// Error in data replication.
pub const DataReplicationError = struct {
    /// Error in data replication.
    @"error": ?DataReplicationErrorString,

    /// Error in data replication.
    raw_error: ?[]const u8,

    pub const json_field_names = .{
        .@"error" = "error",
        .raw_error = "rawError",
    };
};
