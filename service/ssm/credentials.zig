/// The temporary security credentials, which include an access key ID, a secret
/// access key, and
/// a security (or session) token.
pub const Credentials = struct {
    /// The access key ID that identifies the temporary security credentials.
    access_key_id: []const u8,

    /// The datetime on which the current credentials expire.
    expiration_time: i64,

    /// The secret access key that can be used to sign requests.
    secret_access_key: []const u8,

    /// The token that users must pass to the service API to use the temporary
    /// credentials.
    session_token: []const u8,

    pub const json_field_names = .{
        .access_key_id = "AccessKeyId",
        .expiration_time = "ExpirationTime",
        .secret_access_key = "SecretAccessKey",
        .session_token = "SessionToken",
    };
};
