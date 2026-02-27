pub const ServerProtocol = enum {
    mcp,
    http,
    a2_a,

    pub const json_field_names = .{
        .mcp = "MCP",
        .http = "HTTP",
        .a2_a = "A2A",
    };
};
