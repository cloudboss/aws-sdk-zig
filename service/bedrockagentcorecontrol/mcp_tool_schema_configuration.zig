const S3Configuration = @import("s3_configuration.zig").S3Configuration;

/// The MCP tool schema configuration for an MCP server target. The tool schema
/// must be aligned with the MCP specification.
pub const McpToolSchemaConfiguration = union(enum) {
    /// The inline payload containing the MCP tool schema definition.
    inline_payload: ?[]const u8,
    /// The Amazon S3 location of the tool schema. This location contains the schema
    /// definition file.
    s_3: ?S3Configuration,

    pub const json_field_names = .{
        .inline_payload = "inlinePayload",
        .s_3 = "s3",
    };
};
