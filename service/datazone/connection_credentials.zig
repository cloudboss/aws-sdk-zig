/// The credentials of a connection.
pub const ConnectionCredentials = struct {
    /// The access key ID of a connection.
    access_key_id: ?[]const u8 = null,

    /// The expiration of the connection credentials.
    expiration: ?i64 = null,

    /// The secret access key of a connection.
    secret_access_key: ?[]const u8 = null,

    /// The session token of a connection credentials.
    session_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_key_id = "accessKeyId",
        .expiration = "expiration",
        .secret_access_key = "secretAccessKey",
        .session_token = "sessionToken",
    };
};
