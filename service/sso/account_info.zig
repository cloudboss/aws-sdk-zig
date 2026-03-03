/// Provides information about your AWS account.
pub const AccountInfo = struct {
    /// The identifier of the AWS account that is assigned to the user.
    account_id: ?[]const u8 = null,

    /// The display name of the AWS account that is assigned to the user.
    account_name: ?[]const u8 = null,

    /// The email address of the AWS account that is assigned to the user.
    email_address: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .account_name = "accountName",
        .email_address = "emailAddress",
    };
};
