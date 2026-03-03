/// The TLS configuration for a private integration. If you specify a TLS
/// configuration, private integration traffic uses the HTTPS protocol.
/// Supported only for HTTP APIs.
pub const TlsConfigInput = struct {
    /// If you specify a server name, API Gateway uses it to verify the hostname on
    /// the integration's certificate. The server name is also included in the TLS
    /// handshake to support Server Name Indication (SNI) or virtual hosting.
    server_name_to_verify: ?[]const u8 = null,

    pub const json_field_names = .{
        .server_name_to_verify = "ServerNameToVerify",
    };
};
