const aws = @import("aws");

/// Configuration for authenticating to an MCP server with custom HTTP headers.
pub const MCPServerCustomHeadersConfig = struct {
    headers: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .headers = "headers",
    };
};
