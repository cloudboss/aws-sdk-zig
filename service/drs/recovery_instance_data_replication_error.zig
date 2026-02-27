const FailbackReplicationError = @import("failback_replication_error.zig").FailbackReplicationError;

/// Error in data replication.
pub const RecoveryInstanceDataReplicationError = struct {
    /// Error in data replication.
    @"error": ?FailbackReplicationError,

    /// Error in data replication.
    raw_error: ?[]const u8,

    pub const json_field_names = .{
        .@"error" = "error",
        .raw_error = "rawError",
    };
};
