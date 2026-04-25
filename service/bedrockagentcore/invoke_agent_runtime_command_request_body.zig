/// The request body structure for the `InvokeAgentRuntimeCommand` operation,
/// containing the command to execute and optional configuration parameters.
pub const InvokeAgentRuntimeCommandRequestBody = struct {
    /// The shell command to execute on the agent runtime. This command is executed
    /// in the runtime environment and its output is streamed back to the caller.
    command: []const u8,

    /// The maximum duration in seconds to wait for the command to complete. If the
    /// command execution exceeds this timeout, it will be terminated. Default is
    /// 300 seconds. Minimum is 1 second. Maximum is 3600 seconds.
    timeout: ?i32 = null,

    pub const json_field_names = .{
        .command = "command",
        .timeout = "timeout",
    };
};
