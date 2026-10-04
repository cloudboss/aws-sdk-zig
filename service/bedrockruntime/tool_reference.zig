/// A reference to a tool in the tool configuration. Used with
/// `ToolAdditionBlock` and `ToolRemovalBlock` to identify which tool to add or
/// remove mid-conversation.
pub const ToolReference = struct {
    /// The name of the tool. Must match the name of a tool declared in the
    /// top-level tool configuration.
    name: ?[]const u8 = null,

    /// The name of the MCP server that provides the tool. Required when referencing
    /// an MCP tool.
    server_name: ?[]const u8 = null,

    /// The type of tool reference.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .server_name = "serverName",
        .@"type" = "type",
    };
};
