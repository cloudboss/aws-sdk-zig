/// Amazon Web Services credentials for API authentication.
pub const Credentials = struct {
    /// The access key ID that identifies the temporary security credentials.
    access_key_id: []const u8,

    /// The date on which the current credentials expire.
    expiration: i64,

    /// The secret access key that can be used to sign requests.
    secret_access_key: []const u8,

    /// The token that users must pass to the service API to use the temporary
    /// credentials.
    session_token: []const u8,
};
