/// Provides information about an Amazon Web Services account and entity that
/// performed an action on an affected resource. The action was performed using
/// the credentials for an Amazon Web Services account other than your own
/// account.
pub const AwsAccount = struct {
    /// The unique identifier for the Amazon Web Services account.
    account_id: ?[]const u8 = null,

    /// The unique identifier for the entity that performed the action.
    principal_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .principal_id = "principalId",
    };
};
