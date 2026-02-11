const ContinuousBackupsStatus = @import("continuous_backups_status.zig").ContinuousBackupsStatus;
const PointInTimeRecoveryDescription = @import("point_in_time_recovery_description.zig").PointInTimeRecoveryDescription;

/// Represents the continuous backups and point in time recovery settings on the
/// table.
pub const ContinuousBackupsDescription = struct {
    /// `ContinuousBackupsStatus` can be one of the following states: ENABLED,
    /// DISABLED
    continuous_backups_status: ContinuousBackupsStatus,

    /// The description of the point in time recovery settings applied to the table.
    point_in_time_recovery_description: ?PointInTimeRecoveryDescription,

    pub const json_field_names = .{
        .continuous_backups_status = "ContinuousBackupsStatus",
        .point_in_time_recovery_description = "PointInTimeRecoveryDescription",
    };
};
