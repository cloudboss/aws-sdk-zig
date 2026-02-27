/// Provides information about the role credentials that are assigned to the
/// user.
pub const RoleCredentials = struct {
    /// The identifier used for the temporary security credentials. For more
    /// information, see
    /// [Using Temporary Security Credentials to Request Access to AWS
    /// Resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_use-resources.html) in the
    /// *AWS IAM User Guide*.
    access_key_id: ?[]const u8,

    /// The date on which temporary security credentials expire.
    expiration: i64 = 0,

    /// The key that is used to sign the request. For more information, see [Using
    /// Temporary Security Credentials to Request Access to AWS
    /// Resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_use-resources.html) in the
    /// *AWS IAM User Guide*.
    secret_access_key: ?[]const u8,

    /// The token used for temporary credentials. For more information, see [Using
    /// Temporary Security Credentials to Request Access to AWS
    /// Resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_use-resources.html) in the
    /// *AWS IAM User Guide*.
    session_token: ?[]const u8,

    pub const json_field_names = .{
        .access_key_id = "accessKeyId",
        .expiration = "expiration",
        .secret_access_key = "secretAccessKey",
        .session_token = "sessionToken",
    };
};
