const SchemaDefinition = @import("schema_definition.zig").SchemaDefinition;

/// A tool definition for a gateway target. This structure defines a tool that
/// the target exposes through the Model Context Protocol.
pub const ToolDefinition = struct {
    /// The description of the tool. This description provides information about the
    /// purpose and usage of the tool.
    description: []const u8,

    /// The input schema for the tool. This schema defines the structure of the
    /// input that the tool accepts.
    input_schema: SchemaDefinition,

    /// The name of the tool. This name identifies the tool in the Model Context
    /// Protocol.
    name: []const u8,

    /// The output schema for the tool. This schema defines the structure of the
    /// output that the tool produces.
    output_schema: ?SchemaDefinition,

    pub const json_field_names = .{
        .description = "description",
        .input_schema = "inputSchema",
        .name = "name",
        .output_schema = "outputSchema",
    };
};
