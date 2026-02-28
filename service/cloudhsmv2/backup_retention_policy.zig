const BackupRetentionType = @import("backup_retention_type.zig").BackupRetentionType;

/// A policy that defines the number of days to retain backups.
pub const BackupRetentionPolicy = struct {
    /// The type of backup retention policy. For the `DAYS` type, the value is
    /// the number of days to retain backups.
    type: ?BackupRetentionType,

    /// Use a value between 7 - 379.
    value: ?[]const u8,

    pub const json_field_names = .{
        .type = "Type",
        .value = "Value",
    };
};
