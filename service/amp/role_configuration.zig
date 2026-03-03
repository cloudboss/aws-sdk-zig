/// Use this structure to enable cross-account access, so that you can use a
/// target account to access Prometheus metrics from source accounts.
pub const RoleConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the role used in the source account to
    /// enable cross-account scraping. For information about the contents of this
    /// policy, see [Cross-account
    /// setup](https://docs.aws.amazon.com/prometheus/latest/userguide/AMP-collector-how-to.html#cross-account-remote-write).
    source_role_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the role used in the target account to
    /// enable cross-account scraping. For information about the contents of this
    /// policy, see [Cross-account
    /// setup](https://docs.aws.amazon.com/prometheus/latest/userguide/AMP-collector-how-to.html#cross-account-remote-write).
    target_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .source_role_arn = "sourceRoleArn",
        .target_role_arn = "targetRoleArn",
    };
};
