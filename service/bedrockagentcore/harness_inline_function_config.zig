/// Configuration for an inline function tool. When the agent calls this tool,
/// the tool call is returned to the caller for external execution.
pub const HarnessInlineFunctionConfig = struct {
    /// Description of what the tool does, provided to the model.
    description: []const u8,

    /// JSON Schema describing the tool's input parameters.
    input_schema: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .input_schema = "inputSchema",
    };
};
