const PointInTimeRecoveryStatus = @import("point_in_time_recovery_status.zig").PointInTimeRecoveryStatus;

/// Point-in-time recovery (PITR) helps protect your Amazon Keyspaces tables
/// from accidental write or delete operations by providing you continuous
/// backups of your table data.
///
/// For more information, see [Point-in-time
/// recovery](https://docs.aws.amazon.com/keyspaces/latest/devguide/PointInTimeRecovery.html) in the *Amazon Keyspaces Developer Guide*.
pub const PointInTimeRecovery = struct {
    /// The options are:
    ///
    /// * `status=ENABLED`
    /// * `status=DISABLED`
    status: PointInTimeRecoveryStatus,

    pub const json_field_names = .{
        .status = "status",
    };
};
