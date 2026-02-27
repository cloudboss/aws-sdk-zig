/// AWS credentials structure containing temporary access credentials
///
/// The scoped-down, 15 minute duration AWS credentials.
/// Scoping down will be based on CLI policy (CLI team needs to create it).
/// Similar to cloud shell implementation.
pub const AccessToken = struct {
    /// AWS access key ID for temporary credentials
    access_key_id: []const u8,

    /// AWS secret access key for temporary credentials
    secret_access_key: []const u8,

    /// AWS session token for temporary credentials
    session_token: []const u8,

    pub const json_field_names = .{
        .access_key_id = "accessKeyId",
        .secret_access_key = "secretAccessKey",
        .session_token = "sessionToken",
    };
};
