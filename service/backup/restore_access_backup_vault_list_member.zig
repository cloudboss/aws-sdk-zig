const LatestRevokeRequest = @import("latest_revoke_request.zig").LatestRevokeRequest;
const VaultState = @import("vault_state.zig").VaultState;

/// Contains information about a restore access backup vault.
pub const RestoreAccessBackupVaultListMember = struct {
    /// The date and time when the restore access backup vault was approved.
    approval_date: ?i64,

    /// The date and time when the restore access backup vault was created.
    creation_date: ?i64,

    /// Information about the latest request to revoke access to this backup vault.
    latest_revoke_request: ?LatestRevokeRequest,

    /// The ARN of the restore access backup vault.
    restore_access_backup_vault_arn: ?[]const u8,

    /// The current state of the restore access backup vault.
    vault_state: ?VaultState,

    pub const json_field_names = .{
        .approval_date = "ApprovalDate",
        .creation_date = "CreationDate",
        .latest_revoke_request = "LatestRevokeRequest",
        .restore_access_backup_vault_arn = "RestoreAccessBackupVaultArn",
        .vault_state = "VaultState",
    };
};
