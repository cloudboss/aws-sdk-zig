const BackintMode = @import("backint_mode.zig").BackintMode;

/// Configuration parameters for AWS Backint Agent for SAP HANA. You can backup
/// your SAP HANA database with AWS Backup or Amazon S3.
pub const BackintConfig = struct {
    /// AWS service for your database backup.
    backint_mode: BackintMode,

    ensure_no_backup_in_process: bool,

    pub const json_field_names = .{
        .backint_mode = "BackintMode",
        .ensure_no_backup_in_process = "EnsureNoBackupInProcess",
    };
};
