/// The credentials that a chat participant uses to connect to the Connect
/// Customer Participant Service.
pub const ConnectionCredentials = struct {
    /// The connection token used by the chat participant to call the Connect
    /// Customer Participant Service.
    connection_token: ?[]const u8 = null,

    /// The expiration of the token. It's specified in ISO 8601 format:
    /// yyyy-MM-ddThh:mm:ss.SSSZ. For example,
    /// 2019-11-08T02:41:28.172Z.
    expiry: ?[]const u8 = null,

    pub const json_field_names = .{
        .connection_token = "ConnectionToken",
        .expiry = "Expiry",
    };
};
