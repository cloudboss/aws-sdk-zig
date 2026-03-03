/// Describes a target account configuration for an experiment.
pub const ExperimentTargetAccountConfiguration = struct {
    /// The Amazon Web Services account ID of the target account.
    account_id: ?[]const u8 = null,

    /// The description of the target account.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of an IAM role for the target account.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .description = "description",
        .role_arn = "roleArn",
    };
};
