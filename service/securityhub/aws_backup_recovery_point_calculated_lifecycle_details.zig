/// Specifies how long in days before a recovery point transitions to cold
/// storage or is deleted.
pub const AwsBackupRecoveryPointCalculatedLifecycleDetails = struct {
    /// Specifies the number of days after creation that a recovery point is
    /// deleted. Must be greater
    /// than 90 days plus `MoveToColdStorageAfterDays`.
    delete_at: ?[]const u8,

    /// Specifies the number of days after creation that a recovery point is moved
    /// to cold storage.
    move_to_cold_storage_at: ?[]const u8,

    pub const json_field_names = .{
        .delete_at = "DeleteAt",
        .move_to_cold_storage_at = "MoveToColdStorageAt",
    };
};
