/// The Identity and Access Management credentials.
pub const AwsCredentials = struct {
    /// The IAM access key ID.
    access_key_id: []const u8,

    /// The expiration date and time of the IAM credentials.
    expiration: i64,

    /// The IAM secret access key.
    secret_access_key: []const u8,

    /// The IAM session token
    session_token: []const u8,

    pub const json_field_names = .{
        .access_key_id = "accessKeyId",
        .expiration = "expiration",
        .secret_access_key = "secretAccessKey",
        .session_token = "sessionToken",
    };
};
