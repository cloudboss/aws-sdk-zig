/// Provides information about an Identity and Access Management (IAM) user who
/// performed an action on an affected resource.
pub const IamUser = struct {
    /// The unique identifier for the Amazon Web Services account that's associated
    /// with the IAM user who performed the action.
    account_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the principal that performed the action.
    /// The last section of the ARN contains the name of the user who performed the
    /// action.
    arn: ?[]const u8,

    /// The unique identifier for the IAM user who performed the action.
    principal_id: ?[]const u8,

    /// The username of the IAM user who performed the action.
    user_name: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .arn = "arn",
        .principal_id = "principalId",
        .user_name = "userName",
    };
};
