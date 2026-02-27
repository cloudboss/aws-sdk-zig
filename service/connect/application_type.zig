pub const ApplicationType = enum {
    mcp,
    third_party_application,

    pub const json_field_names = .{
        .mcp = "MCP",
        .third_party_application = "THIRD_PARTY_APPLICATION",
    };
};
