/// Provides information about an Amazon Web Services account and entity that
/// performed an action on an affected resource. The action was performed using
/// the credentials for your Amazon Web Services account.
pub const UserIdentityRoot = struct {
    /// The unique identifier for the Amazon Web Services account.
    account_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the principal that performed the action.
    /// The last section of the ARN contains the name of the user or role that
    /// performed the action.
    arn: ?[]const u8 = null,

    /// The unique identifier for the entity that performed the action.
    principal_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .arn = "arn",
        .principal_id = "principalId",
    };
};
