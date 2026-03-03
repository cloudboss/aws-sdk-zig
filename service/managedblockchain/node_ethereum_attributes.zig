/// Attributes of an Ethereum node.
pub const NodeEthereumAttributes = struct {
    /// The endpoint on which the Ethereum node listens to run Ethereum API methods
    /// over HTTP connections from a client. Use this endpoint in client code for
    /// smart contracts when using an HTTP connection. Connections to this endpoint
    /// are authenticated using [Signature Version
    /// 4](https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
    http_endpoint: ?[]const u8 = null,

    /// The endpoint on which the Ethereum node listens to run Ethereum JSON-RPC
    /// methods over WebSocket connections from a client. Use this endpoint in
    /// client code for smart contracts when using a WebSocket connection.
    /// Connections to this endpoint are authenticated using [Signature Version
    /// 4](https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html).
    web_socket_endpoint: ?[]const u8 = null,

    pub const json_field_names = .{
        .http_endpoint = "HttpEndpoint",
        .web_socket_endpoint = "WebSocketEndpoint",
    };
};
