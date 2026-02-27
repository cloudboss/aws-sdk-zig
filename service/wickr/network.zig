const AccessLevel = @import("access_level.zig").AccessLevel;

/// Represents a Wickr network with all its configuration and status
/// information.
pub const Network = struct {
    /// The access level of the network (STANDARD or PREMIUM), which determines
    /// available features and capabilities.
    access_level: AccessLevel,

    /// The Amazon Web Services account ID that owns the network.
    aws_account_id: []const u8,

    /// The ARN of the Amazon Web Services KMS customer managed key used for
    /// encrypting sensitive data in the network.
    encryption_key_arn: ?[]const u8,

    /// The expiration date and time for the network's free trial period, if
    /// applicable.
    free_trial_expiration: ?[]const u8,

    /// The SSO redirect URI migration state, managed by the SSO redirect migration
    /// wizard. Values: 0 (not started), 1 (in progress), or 2 (completed).
    migration_state: ?i32,

    /// The Amazon Resource Name (ARN) of the network.
    network_arn: []const u8,

    /// The unique identifier of the network.
    network_id: []const u8,

    /// The name of the network.
    network_name: []const u8,

    /// The current standing or status of the network.
    standing: ?i32,

    pub const json_field_names = .{
        .access_level = "accessLevel",
        .aws_account_id = "awsAccountId",
        .encryption_key_arn = "encryptionKeyArn",
        .free_trial_expiration = "freeTrialExpiration",
        .migration_state = "migrationState",
        .network_arn = "networkArn",
        .network_id = "networkId",
        .network_name = "networkName",
        .standing = "standing",
    };
};
