const IdentityCenterConfiguration = @import("identity_center_configuration.zig").IdentityCenterConfiguration;

/// Parameters for Amazon Athena.
pub const AthenaParameters = struct {
    /// Use `ConsumerAccountRoleArn` to perform cross-account Athena access. This is
    /// an IAM role ARN in the same AWS account as the Athena resources you want to
    /// access. Provide this along with `RoleArn` to enable role-chaining, where
    /// Amazon Quick Sight first assumes the `RoleArn` and then assumes the
    /// `ConsumerAccountRoleArn` to access Athena resources.
    consumer_account_role_arn: ?[]const u8 = null,

    /// An optional parameter that configures IAM Identity Center authentication to
    /// grant Quick Sight access to your workgroup.
    ///
    /// This parameter can only be specified if your Quick Sight account is
    /// configured with IAM Identity Center.
    identity_center_configuration: ?IdentityCenterConfiguration = null,

    /// Use the `RoleArn` structure to override an account-wide role for a specific
    /// Athena data source. For example, say an account administrator has turned off
    /// all Athena access with an account-wide role. The administrator can then use
    /// `RoleArn` to bypass the account-wide role and allow Athena access for the
    /// single Athena data source that is specified in the structure, even if the
    /// account-wide role forbidding Athena access is still active.
    role_arn: ?[]const u8 = null,

    /// The workgroup that Amazon Athena uses.
    work_group: ?[]const u8 = null,

    pub const json_field_names = .{
        .consumer_account_role_arn = "ConsumerAccountRoleArn",
        .identity_center_configuration = "IdentityCenterConfiguration",
        .role_arn = "RoleArn",
        .work_group = "WorkGroup",
    };
};
