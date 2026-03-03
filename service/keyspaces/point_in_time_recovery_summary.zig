const PointInTimeRecoveryStatus = @import("point_in_time_recovery_status.zig").PointInTimeRecoveryStatus;

/// The point-in-time recovery status of the specified table.
pub const PointInTimeRecoverySummary = struct {
    /// Specifies the earliest possible restore point of the table in ISO 8601
    /// format.
    earliest_restorable_timestamp: ?i64 = null,

    /// Shows if point-in-time recovery is enabled or disabled for the specified
    /// table.
    status: PointInTimeRecoveryStatus,

    pub const json_field_names = .{
        .earliest_restorable_timestamp = "earliestRestorableTimestamp",
        .status = "status",
    };
};
