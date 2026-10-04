const EncryptionConflictResolutionStrategy = @import("encryption_conflict_resolution_strategy.zig").EncryptionConflictResolutionStrategy;
const EncryptionScope = @import("encryption_scope.zig").EncryptionScope;
const EncryptionStrategy = @import("encryption_strategy.zig").EncryptionStrategy;

/// Configuration for encrypting centralized destination log groups. By default,
/// this configuration applies only to destination log groups whose
/// corresponding source log groups are encrypted using customer managed KMS
/// keys. To encrypt all destination log groups created by the rule, set
/// `EncryptionScope` to `NEW_DESTINATION_LOG_GROUPS`.
pub const LogsEncryptionConfiguration = struct {
    /// Conflict resolution strategy for centralization if the encryption strategy
    /// is set to CUSTOMER_MANAGED and the destination log group is encrypted with
    /// an AWS_OWNED KMS Key. ALLOW lets centralization go through while SKIP
    /// prevents centralization into the destination log group.
    encryption_conflict_resolution_strategy: ?EncryptionConflictResolutionStrategy = null,

    /// Determines which newly created destination log groups are encrypted with the
    /// configured `KmsKeyArn` when `EncryptionStrategy` is `CUSTOMER_MANAGED`.
    ///
    /// If you set this to `ENCRYPTED_SOURCE_ONLY` (the default), only destination
    /// log groups whose source log group is encrypted with a customer managed KMS
    /// key use the configured `KmsKeyArn`. Destination log groups derived from
    /// Amazon Web Services owned encrypted source log groups remain Amazon Web
    /// Services owned encrypted.
    ///
    /// If you set this to `NEW_DESTINATION_LOG_GROUPS`, every new destination log
    /// group created by this rule uses the configured `KmsKeyArn`, regardless of
    /// the source log group's encryption posture.
    ///
    /// This field is not valid when `EncryptionStrategy` is `AWS_OWNED`.
    encryption_scope: ?EncryptionScope = null,

    /// Configuration that determines the encryption strategy of the destination log
    /// groups. CUSTOMER_MANAGED uses the configured KmsKeyArn to encrypt newly
    /// created destination log groups.
    encryption_strategy: EncryptionStrategy,

    /// KMS Key ARN belonging to the primary destination account and region, to
    /// encrypt newly created central log groups in the primary destination.
    kms_key_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .encryption_conflict_resolution_strategy = "EncryptionConflictResolutionStrategy",
        .encryption_scope = "EncryptionScope",
        .encryption_strategy = "EncryptionStrategy",
        .kms_key_arn = "KmsKeyArn",
    };
};
