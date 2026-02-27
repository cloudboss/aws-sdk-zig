/// Contains an array of Transition objects specifying how long in days before a
/// recovery point transitions to cold storage or is deleted.
pub const AwsBackupRecoveryPointLifecycleDetails = struct {
    /// Specifies the number of days after creation that a recovery point is
    /// deleted. Must be greater
    /// than 90 days plus `MoveToColdStorageAfterDays`.
    delete_after_days: ?i64,

    /// Specifies the number of days after creation that a recovery point is moved
    /// to cold storage.
    move_to_cold_storage_after_days: ?i64,

    pub const json_field_names = .{
        .delete_after_days = "DeleteAfterDays",
        .move_to_cold_storage_after_days = "MoveToColdStorageAfterDays",
    };
};
