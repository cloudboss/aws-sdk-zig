const ListingMode = @import("listing_mode.zig").ListingMode;
const McpToolSchemaConfiguration = @import("mcp_tool_schema_configuration.zig").McpToolSchemaConfiguration;

/// The target configuration for the MCP server.
pub const McpServerTargetConfiguration = struct {
    /// The endpoint for the MCP server target configuration.
    endpoint: []const u8,

    /// The listing mode for the MCP server target configuration. MCP resources for
    /// default targets are cached at the control plane for faster access. MCP
    /// resources for dynamic targets will be dynamically retrieved when listing
    /// tools.
    listing_mode: ?ListingMode = null,

    /// The tool schema configuration for the MCP server target. Supported only when
    /// the credential provider is configured with an authorization code grant type.
    /// Dynamic tool discovery/synchronization will be disabled when target is
    /// configured with mcpToolSchema.
    mcp_tool_schema: ?McpToolSchemaConfiguration = null,

    /// Priority for resolving MCP server targets with shared resource URIs. Lower
    /// values take precedence. Defaults to 1000 when not set.
    resource_priority: ?i32 = null,

    pub const json_field_names = .{
        .endpoint = "endpoint",
        .listing_mode = "listingMode",
        .mcp_tool_schema = "mcpToolSchema",
        .resource_priority = "resourcePriority",
    };
};
