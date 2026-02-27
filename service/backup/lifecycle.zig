const LifecycleDeleteAfterEvent = @import("lifecycle_delete_after_event.zig").LifecycleDeleteAfterEvent;

/// Specifies the time period, in days, before a recovery point transitions to
/// cold storage
/// or is deleted.
///
/// Backups transitioned to cold storage must be stored in cold storage for a
/// minimum of 90
/// days. Therefore, on the console, the retention setting must be 90 days
/// greater than the
/// transition to cold after days setting. The transition to cold after days
/// setting can't
/// be changed after a backup has been transitioned to cold.
///
/// Resource types that can transition to cold storage are listed in the
/// [Feature
/// availability by
/// resource](https://docs.aws.amazon.com/aws-backup/latest/devguide/backup-feature-availability.html#features-by-resource) table. Backup ignores this expression for
/// other resource types.
///
/// To remove the existing lifecycle and retention periods and keep your
/// recovery points indefinitely,
/// specify -1 for `MoveToColdStorageAfterDays` and `DeleteAfterDays`.
pub const Lifecycle = struct {
    /// The number of days after creation that a recovery point is deleted. This
    /// value must be
    /// at least 90 days after the number of days specified in
    /// `MoveToColdStorageAfterDays`.
    delete_after_days: ?i64,

    /// The event after which a recovery point is deleted. A recovery point with
    /// both
    /// `DeleteAfterDays` and `DeleteAfterEvent` will delete after
    /// whichever condition is satisfied first. Not valid as an input.
    delete_after_event: ?LifecycleDeleteAfterEvent,

    /// The number of days after creation that a recovery point is moved to cold
    /// storage.
    move_to_cold_storage_after_days: ?i64,

    /// If the value is true, your backup plan transitions supported resources to
    /// archive (cold) storage tier in accordance with your lifecycle settings.
    opt_in_to_archive_for_supported_resources: ?bool,

    pub const json_field_names = .{
        .delete_after_days = "DeleteAfterDays",
        .delete_after_event = "DeleteAfterEvent",
        .move_to_cold_storage_after_days = "MoveToColdStorageAfterDays",
        .opt_in_to_archive_for_supported_resources = "OptInToArchiveForSupportedResources",
    };
};
