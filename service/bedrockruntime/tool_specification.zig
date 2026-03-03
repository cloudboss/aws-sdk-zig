const ToolInputSchema = @import("tool_input_schema.zig").ToolInputSchema;

/// The specification for the tool. For more information, see [Call a tool with
/// the Converse
/// API](https://docs.aws.amazon.com/bedrock/latest/userguide/tool-use.html) in
/// the Amazon Bedrock User Guide.
pub const ToolSpecification = struct {
    /// The description for the tool.
    description: ?[]const u8 = null,

    /// The input schema for the tool in JSON format.
    input_schema: ToolInputSchema,

    /// The name for the tool.
    name: []const u8,

    /// Flag to enable structured output enforcement on a tool usage response.
    strict: ?bool = null,

    pub const json_field_names = .{
        .description = "description",
        .input_schema = "inputSchema",
        .name = "name",
        .strict = "strict",
    };
};
