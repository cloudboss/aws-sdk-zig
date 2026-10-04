const SearchType = @import("search_type.zig").SearchType;
const SessionConfiguration = @import("session_configuration.zig").SessionConfiguration;
const StreamingConfiguration = @import("streaming_configuration.zig").StreamingConfiguration;

/// The configuration for a Model Context Protocol (MCP) gateway. This structure
/// defines how the gateway implements the MCP protocol.
pub const MCPGatewayConfiguration = struct {
    /// Specifies whether pagination is disabled for the Model Context Protocol
    /// (MCP) `tools/list` operation. When set to `true`, the gateway returns the
    /// complete list of tools in a single response without a pagination cursor.
    /// When set to `false` or omitted, the gateway returns tools in paginated
    /// responses.
    disable_mcp_list_tools_pagination: ?bool = null,

    /// The instructions for using the Model Context Protocol gateway. These
    /// instructions provide guidance on how to interact with the gateway.
    instructions: ?[]const u8 = null,

    /// The search type for the Model Context Protocol gateway. This field specifies
    /// how the gateway handles search operations.
    search_type: ?SearchType = null,

    /// The session configuration for the MCP gateway. This configuration controls
    /// session behavior, including session timeout settings.
    session_configuration: ?SessionConfiguration = null,

    /// The streaming configuration for the MCP gateway. This configuration controls
    /// whether response streaming is enabled for the gateway.
    streaming_configuration: ?StreamingConfiguration = null,

    /// The supported versions of the Model Context Protocol. This field specifies
    /// which versions of the protocol the gateway can use.
    supported_versions: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .disable_mcp_list_tools_pagination = "disableMcpListToolsPagination",
        .instructions = "instructions",
        .search_type = "searchType",
        .session_configuration = "sessionConfiguration",
        .streaming_configuration = "streamingConfiguration",
        .supported_versions = "supportedVersions",
    };
};
