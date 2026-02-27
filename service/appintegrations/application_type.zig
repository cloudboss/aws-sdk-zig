/// The type of application
pub const ApplicationType = enum {
    standard,
    service,
    mcp_server,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .service = "SERVICE",
        .mcp_server = "MCP_SERVER",
    };
};
