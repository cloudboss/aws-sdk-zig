const Lifecycle = @import("lifecycle.zig").Lifecycle;

/// The details of the copy operation.
pub const CopyAction = struct {
    /// An Amazon Resource Name (ARN) that uniquely identifies the destination
    /// backup vault for
    /// the copied backup. For example,
    /// `arn:aws:backup:us-east-1:123456789012:backup-vault:aBackupVault`.
    destination_backup_vault_arn: []const u8,

    lifecycle: ?Lifecycle = null,

    pub const json_field_names = .{
        .destination_backup_vault_arn = "DestinationBackupVaultArn",
        .lifecycle = "Lifecycle",
    };
};
