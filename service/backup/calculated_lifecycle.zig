/// Contains `DeleteAt` and `MoveToColdStorageAt` timestamps, which
/// are used to specify a lifecycle for a recovery point.
///
/// The lifecycle defines when a protected resource is transitioned to cold
/// storage and when
/// it expires. Backup transitions and expires backups automatically according
/// to
/// the lifecycle that you define.
///
/// Backups transitioned to cold storage must be stored in cold storage for a
/// minimum of 90
/// days. Therefore, the “retention” setting must be 90 days greater than the
/// “transition to
/// cold after days” setting. The “transition to cold after days” setting cannot
/// be changed
/// after a backup has been transitioned to cold.
///
/// Resource types that can transition to cold storage are listed in the
/// [Feature availability
/// by
/// resource](https://docs.aws.amazon.com/aws-backup/latest/devguide/backup-feature-availability.html#features-by-resource) table. Backup ignores this expression for other resource types.
pub const CalculatedLifecycle = struct {
    /// A timestamp that specifies when to delete a recovery point.
    delete_at: ?i64 = null,

    /// A timestamp that specifies when to transition a recovery point to cold
    /// storage.
    move_to_cold_storage_at: ?i64 = null,

    pub const json_field_names = .{
        .delete_at = "DeleteAt",
        .move_to_cold_storage_at = "MoveToColdStorageAt",
    };
};
