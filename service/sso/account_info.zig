/// Provides information about your AWS account.
pub const AccountInfo = struct {
    /// The identifier of the AWS account that is assigned to the user.
    account_id: ?[]const u8,

    /// The display name of the AWS account that is assigned to the user.
    account_name: ?[]const u8,

    /// The email address of the AWS account that is assigned to the user.
    email_address: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .account_name = "accountName",
        .email_address = "emailAddress",
    };
};
