const HistoryEventExecutionDataDetails = @import("history_event_execution_data_details.zig").HistoryEventExecutionDataDetails;

/// Contains details about the start of the execution.
pub const ExecutionStartedEventDetails = struct {
    /// The JSON data input to the execution. Length constraints apply to the
    /// payload size, and are expressed as bytes in UTF-8 encoding.
    input: ?[]const u8 = null,

    /// Contains details about the input for an execution history event.
    input_details: ?HistoryEventExecutionDataDetails = null,

    /// The Amazon Resource Name (ARN) of the IAM role used for executing Lambda
    /// tasks.
    role_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) that identifies a state machine alias used
    /// for starting the state machine execution.
    state_machine_alias_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) that identifies a state machine version used
    /// for starting the state machine execution.
    state_machine_version_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .input = "input",
        .input_details = "inputDetails",
        .role_arn = "roleArn",
        .state_machine_alias_arn = "stateMachineAliasArn",
        .state_machine_version_arn = "stateMachineVersionArn",
    };
};
