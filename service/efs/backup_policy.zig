const Status = @import("status.zig").Status;

/// The backup policy for the file system used to create automatic daily
/// backups. If status has a value of
/// `ENABLED`, the file system is being automatically backed up. For more
/// information, see [Automatic
/// backups](https://docs.aws.amazon.com/efs/latest/ug/awsbackup.html#automatic-backups).
pub const BackupPolicy = struct {
    /// Describes the status of the file system's backup policy.
    ///
    /// * **
    /// `ENABLED`
    /// ** – EFS is automatically
    /// backing up the file system.
    ///
    /// * **
    /// `ENABLING`
    /// ** – EFS is turning on
    /// automatic backups for the file system.
    ///
    /// * **
    /// `DISABLED`
    /// ** – Automatic back ups are turned
    /// off for the file system.
    ///
    /// * **
    /// `DISABLING`
    /// ** – EFS is turning off
    /// automatic backups for the file system.
    status: Status,

    pub const json_field_names = .{
        .status = "Status",
    };
};
