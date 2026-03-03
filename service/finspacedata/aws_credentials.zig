/// The credentials required to access the external Dataview from the S3
/// location.
pub const AwsCredentials = struct {
    /// The unique identifier for the security credentials.
    access_key_id: ?[]const u8 = null,

    /// The Epoch time when the current credentials expire.
    expiration: i64 = 0,

    /// The secret access key that can be used to sign requests.
    secret_access_key: ?[]const u8 = null,

    /// The token that users must pass to use the credentials.
    session_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_key_id = "accessKeyId",
        .expiration = "expiration",
        .secret_access_key = "secretAccessKey",
        .session_token = "sessionToken",
    };
};
