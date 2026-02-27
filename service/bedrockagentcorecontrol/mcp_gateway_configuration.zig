const SearchType = @import("search_type.zig").SearchType;

/// The configuration for a Model Context Protocol (MCP) gateway. This structure
/// defines how the gateway implements the MCP protocol.
pub const MCPGatewayConfiguration = struct {
    /// The instructions for using the Model Context Protocol gateway. These
    /// instructions provide guidance on how to interact with the gateway.
    instructions: ?[]const u8,

    /// The search type for the Model Context Protocol gateway. This field specifies
    /// how the gateway handles search operations.
    search_type: ?SearchType,

    /// The supported versions of the Model Context Protocol. This field specifies
    /// which versions of the protocol the gateway can use.
    supported_versions: ?[]const []const u8,

    pub const json_field_names = .{
        .instructions = "instructions",
        .search_type = "searchType",
        .supported_versions = "supportedVersions",
    };
};
