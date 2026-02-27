/// A `SignupResponse` object that contains a summary of a newly created
/// account.
pub const SignupResponse = struct {
    /// The name of your Quick Sight account.
    account_name: ?[]const u8,

    /// The type of Active Directory that is being used to authenticate the Amazon
    /// Quick Sight
    /// account. Valid values are `SIMPLE_AD`, `AD_CONNECTOR`, and
    /// `MICROSOFT_AD`.
    directory_type: ?[]const u8,

    /// A Boolean that is `TRUE` if the Amazon Quick Sight uses IAM as an
    /// authentication method.
    iam_user: bool = false,

    /// The user login name for your Amazon Quick Sight account.
    user_login_name: ?[]const u8,

    pub const json_field_names = .{
        .account_name = "accountName",
        .directory_type = "directoryType",
        .iam_user = "IAMUser",
        .user_login_name = "userLoginName",
    };
};
