const ToolInputSchema = @import("tool_input_schema.zig").ToolInputSchema;

/// Specification for a tool that acts can invoke, including its name,
/// description, and input schema.
pub const ToolSpec = struct {
    /// A description of what the tool does and how it should be used.
    description: []const u8,

    /// The JSON schema that defines the expected input format for the tool.
    input_schema: ToolInputSchema,

    /// The unique name of the tool that acts will use to invoke it.
    name: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .input_schema = "inputSchema",
        .name = "name",
    };
};
