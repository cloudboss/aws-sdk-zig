/// A representation of a linked account.
pub const AccountAssociationsListElement = struct {
    /// The Amazon Web Services account email.
    account_email: ?[]const u8,

    /// The associating array of account IDs.
    account_id: ?[]const u8,

    /// The Amazon Web Services account name.
    account_name: ?[]const u8,

    /// The Billing Group Arn that the linked account is associated to.
    billing_group_arn: ?[]const u8,

    pub const json_field_names = .{
        .account_email = "AccountEmail",
        .account_id = "AccountId",
        .account_name = "AccountName",
        .billing_group_arn = "BillingGroupArn",
    };
};
