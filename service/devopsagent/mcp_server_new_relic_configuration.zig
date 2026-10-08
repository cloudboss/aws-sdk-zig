/// Mixin for webhook update support.
pub const MCPServerNewRelicConfiguration = struct {
    /// New Relic Account ID
    account_id: []const u8,

    /// MCP server endpoint URL (e.g., https://mcp.newrelic.com/mcp/)
    endpoint: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .endpoint = "endpoint",
    };
};
