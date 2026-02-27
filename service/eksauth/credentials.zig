/// The *Amazon Web Services Signature Version 4* type of temporary
/// credentials.
pub const Credentials = struct {
    /// The access key ID that identifies the temporary security credentials.
    access_key_id: []const u8,

    /// The Unix epoch timestamp in seconds when the current credentials expire.
    expiration: i64,

    /// The secret access key that applications inside the pods use to sign
    /// requests.
    secret_access_key: []const u8,

    /// The token that applications inside the pods must pass to any service API to
    /// use the
    /// temporary credentials.
    session_token: []const u8,

    pub const json_field_names = .{
        .access_key_id = "accessKeyId",
        .expiration = "expiration",
        .secret_access_key = "secretAccessKey",
        .session_token = "sessionToken",
    };
};
