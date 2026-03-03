const EncryptionConflictResolutionStrategy = @import("encryption_conflict_resolution_strategy.zig").EncryptionConflictResolutionStrategy;
const EncryptionStrategy = @import("encryption_strategy.zig").EncryptionStrategy;

/// Configuration for encrypting centralized log groups. This configuration is
/// only applied to destination log groups for which the corresponding source
/// log groups are encrypted using Customer Managed KMS Keys.
pub const LogsEncryptionConfiguration = struct {
    /// Conflict resolution strategy for centralization if the encryption strategy
    /// is set to CUSTOMER_MANAGED and the destination log group is encrypted with
    /// an AWS_OWNED KMS Key. ALLOW lets centralization go through while SKIP
    /// prevents centralization into the destination log group.
    encryption_conflict_resolution_strategy: ?EncryptionConflictResolutionStrategy = null,

    /// Configuration that determines the encryption strategy of the destination log
    /// groups. CUSTOMER_MANAGED uses the configured KmsKeyArn to encrypt newly
    /// created destination log groups.
    encryption_strategy: EncryptionStrategy,

    /// KMS Key ARN belonging to the primary destination account and region, to
    /// encrypt newly created central log groups in the primary destination.
    kms_key_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .encryption_conflict_resolution_strategy = "EncryptionConflictResolutionStrategy",
        .encryption_strategy = "EncryptionStrategy",
        .kms_key_arn = "KmsKeyArn",
    };
};
