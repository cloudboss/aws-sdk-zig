const InputContentBlock = @import("input_content_block.zig").InputContentBlock;
const ProgrammingLanguage = @import("programming_language.zig").ProgrammingLanguage;

/// The collection of arguments that specify the operation to perform and its
/// parameters when invoking a tool in Amazon Bedrock AgentCore. Different tools
/// require different arguments, and this structure provides a flexible way to
/// pass the appropriate arguments to each tool type.
pub const ToolArguments = struct {
    /// Whether to clear the context for the tool.
    clear_context: ?bool = null,

    /// The code to execute in a code interpreter session. This is the source code
    /// in the specified programming language that will be executed by the code
    /// interpreter.
    code: ?[]const u8 = null,

    /// The command to execute with the tool.
    command: ?[]const u8 = null,

    /// The content for the tool operation.
    content: ?[]const InputContentBlock = null,

    /// The directory path for the tool operation.
    directory_path: ?[]const u8 = null,

    /// The programming language of the code to execute. This tells the code
    /// interpreter which language runtime to use for execution. Common values
    /// include 'python', 'javascript', and 'r'.
    language: ?ProgrammingLanguage = null,

    /// The path for the tool operation.
    path: ?[]const u8 = null,

    /// The paths for the tool operation.
    paths: ?[]const []const u8 = null,

    /// The identifier of the task for the tool operation.
    task_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .clear_context = "clearContext",
        .code = "code",
        .command = "command",
        .content = "content",
        .directory_path = "directoryPath",
        .language = "language",
        .path = "path",
        .paths = "paths",
        .task_id = "taskId",
    };
};
