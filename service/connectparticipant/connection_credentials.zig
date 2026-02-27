/// Connection credentials.
pub const ConnectionCredentials = struct {
    /// The connection token.
    connection_token: ?[]const u8,

    /// The expiration of the token.
    ///
    /// It's specified in ISO 8601 format: yyyy-MM-ddThh:mm:ss.SSSZ. For example,
    /// 2019-11-08T02:41:28.172Z.
    expiry: ?[]const u8,

    pub const json_field_names = .{
        .connection_token = "ConnectionToken",
        .expiry = "Expiry",
    };
};
