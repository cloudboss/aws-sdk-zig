/// Provides lifecycle details for the backup plan. A lifecycle defines when a
/// backup is transitioned to cold storage and when it expires.
pub const AwsBackupBackupPlanLifecycleDetails = struct {
    /// Specifies the number of days after creation that a recovery point is
    /// deleted. Must be greater than 90 days plus `MoveToColdStorageAfterDays`.
    delete_after_days: ?i64 = null,

    /// Specifies the number of days after creation that a recovery point is moved
    /// to cold storage.
    move_to_cold_storage_after_days: ?i64 = null,

    pub const json_field_names = .{
        .delete_after_days = "DeleteAfterDays",
        .move_to_cold_storage_after_days = "MoveToColdStorageAfterDays",
    };
};
