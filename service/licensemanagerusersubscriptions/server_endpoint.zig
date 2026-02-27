/// A network endpoint through which you can access one or more servers.
pub const ServerEndpoint = struct {
    /// The network address of the endpoint.
    endpoint: ?[]const u8,

    pub const json_field_names = .{
        .endpoint = "Endpoint",
    };
};
