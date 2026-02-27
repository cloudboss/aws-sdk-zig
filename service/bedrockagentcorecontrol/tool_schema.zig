const ToolDefinition = @import("tool_definition.zig").ToolDefinition;
const S3Configuration = @import("s3_configuration.zig").S3Configuration;

/// A tool schema for a gateway target. This structure defines the schema for a
/// tool that the target exposes through the Model Context Protocol.
pub const ToolSchema = union(enum) {
    /// The inline payload of the tool schema. This payload contains the schema
    /// definition directly in the request.
    inline_payload: ?[]const ToolDefinition,
    /// The Amazon S3 location of the tool schema. This location contains the schema
    /// definition file.
    s_3: ?S3Configuration,

    pub const json_field_names = .{
        .inline_payload = "inlinePayload",
        .s_3 = "s3",
    };
};
