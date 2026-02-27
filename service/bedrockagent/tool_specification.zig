const ToolInputSchema = @import("tool_input_schema.zig").ToolInputSchema;

/// Contains a specification for a tool. For more information, see [Use a tool
/// to complete an Amazon Bedrock model
/// response](https://docs.aws.amazon.com/bedrock/latest/userguide/tool-use.html).
pub const ToolSpecification = struct {
    /// The description of the tool.
    description: ?[]const u8,

    /// The input schema for the tool.
    input_schema: ToolInputSchema,

    /// The name of the tool.
    name: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .input_schema = "inputSchema",
        .name = "name",
    };
};
