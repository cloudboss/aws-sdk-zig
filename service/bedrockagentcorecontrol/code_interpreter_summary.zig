const CodeInterpreterStatus = @import("code_interpreter_status.zig").CodeInterpreterStatus;

/// Contains summary information about a code interpreter. A code interpreter
/// enables Amazon Bedrock AgentCore Agent to execute code.
pub const CodeInterpreterSummary = struct {
    /// The Amazon Resource Name (ARN) of the code interpreter.
    code_interpreter_arn: []const u8,

    /// The unique identifier of the code interpreter.
    code_interpreter_id: []const u8,

    /// The timestamp when the code interpreter was created.
    created_at: i64,

    /// The description of the code interpreter.
    description: ?[]const u8 = null,

    /// The timestamp when the code interpreter was last updated.
    last_updated_at: ?i64 = null,

    /// The name of the code interpreter.
    name: ?[]const u8 = null,

    /// The current status of the code interpreter.
    status: CodeInterpreterStatus,

    pub const json_field_names = .{
        .code_interpreter_arn = "codeInterpreterArn",
        .code_interpreter_id = "codeInterpreterId",
        .created_at = "createdAt",
        .description = "description",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .status = "status",
    };
};
