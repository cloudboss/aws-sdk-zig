const aws = @import("aws");

/// Configuration for connecting to a remote MCP server.
pub const HarnessRemoteMcpConfig = struct {
    headers: ?[]const aws.map.StringMapEntry = null,

    /// URL of the MCP endpoint.
    url: []const u8,

    pub const json_field_names = .{
        .headers = "headers",
        .url = "url",
    };
};
