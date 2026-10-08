const MCPToolDetail = @import("mcp_tool_detail.zig").MCPToolDetail;

/// Mixin for webhook update support.
pub const MCPServerDatadogConfiguration = struct {
    /// The subset of elevated-access tools enabled for this integration.
    enabled_elevated_tools: ?[]const MCPToolDetail = null,

    pub const json_field_names = .{
        .enabled_elevated_tools = "enabledElevatedTools",
    };
};
