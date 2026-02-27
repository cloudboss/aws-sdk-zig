/// The credentials of a connection.
pub const ConnectionCredentials = struct {
    /// The access key ID of a connection.
    access_key_id: ?[]const u8,

    /// The expiration of the connection credentials.
    expiration: ?i64,

    /// The secret access key of a connection.
    secret_access_key: ?[]const u8,

    /// The session token of a connection credentials.
    session_token: ?[]const u8,

    pub const json_field_names = .{
        .access_key_id = "accessKeyId",
        .expiration = "expiration",
        .secret_access_key = "secretAccessKey",
        .session_token = "sessionToken",
    };
};
