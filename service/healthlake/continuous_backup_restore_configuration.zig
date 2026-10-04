/// Configuration for continuous backup (point-in-time) restore.
pub const ContinuousBackupRestoreConfiguration = struct {
    /// The point in time to restore the data store to, specified as a UTC
    /// timestamp.
    restore_point_time: ?i64 = null,

    pub const json_field_names = .{
        .restore_point_time = "RestorePointTime",
    };
};
