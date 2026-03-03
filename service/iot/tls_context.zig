/// Specifies the TLS context to use for the test authorizer request.
pub const TlsContext = struct {
    /// The value of the `serverName` key in a TLS authorization request.
    server_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .server_name = "serverName",
    };
};
