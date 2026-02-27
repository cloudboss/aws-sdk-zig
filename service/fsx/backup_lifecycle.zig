/// The lifecycle status of the backup.
///
/// * `AVAILABLE` - The backup is fully available.
///
/// * `PENDING` - For user-initiated backups on Lustre file systems only; Amazon
///   FSx hasn't started creating the backup.
///
/// * `CREATING` - Amazon FSx is creating the new user-initiated backup.
///
/// * `TRANSFERRING` - For user-initiated backups on Lustre file systems only;
///   Amazon FSx is backing up the file
/// system.
///
/// * `COPYING` - Amazon FSx is copying the backup.
///
/// * `DELETED` - Amazon FSx deleted the backup and it's no longer
/// available.
///
/// * `FAILED` - Amazon FSx couldn't finish the backup.
pub const BackupLifecycle = enum {
    available,
    creating,
    transferring,
    deleted,
    failed,
    pending,
    copying,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .creating = "CREATING",
        .transferring = "TRANSFERRING",
        .deleted = "DELETED",
        .failed = "FAILED",
        .pending = "PENDING",
        .copying = "COPYING",
    };
};
