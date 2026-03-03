/// Credentials for the provided identity ID.
pub const Credentials = struct {
    /// The Access Key portion of the credentials.
    access_key_id: ?[]const u8 = null,

    /// The date at which these credentials will expire.
    expiration: ?i64 = null,

    /// The Secret Access Key portion of the credentials
    secret_key: ?[]const u8 = null,

    /// The Session Token portion of the credentials
    session_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_key_id = "AccessKeyId",
        .expiration = "Expiration",
        .secret_key = "SecretKey",
        .session_token = "SessionToken",
    };
};
