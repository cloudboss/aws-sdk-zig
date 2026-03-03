/// Short term API credentials.
pub const Credentials = struct {
    /// The access key identifier.
    access_key_id: ?[]const u8 = null,

    /// The access key.
    secret_access_key: ?[]const u8 = null,

    /// The session token.
    session_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_key_id = "accessKeyId",
        .secret_access_key = "secretAccessKey",
        .session_token = "sessionToken",
    };
};
