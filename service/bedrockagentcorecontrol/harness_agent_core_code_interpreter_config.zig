/// Configuration for AgentCore Code Interpreter.
pub const HarnessAgentCoreCodeInterpreterConfig = struct {
    /// If not populated, the built-in Code Interpreter ARN is used.
    code_interpreter_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .code_interpreter_arn = "codeInterpreterArn",
    };
};
