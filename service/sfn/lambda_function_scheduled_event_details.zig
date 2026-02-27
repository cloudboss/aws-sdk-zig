const HistoryEventExecutionDataDetails = @import("history_event_execution_data_details.zig").HistoryEventExecutionDataDetails;
const TaskCredentials = @import("task_credentials.zig").TaskCredentials;

/// Contains details about a Lambda function scheduled during an execution.
pub const LambdaFunctionScheduledEventDetails = struct {
    /// The JSON data input to the Lambda function. Length constraints apply to the
    /// payload size, and are expressed as bytes in UTF-8 encoding.
    input: ?[]const u8,

    /// Contains details about input for an execution history event.
    input_details: ?HistoryEventExecutionDataDetails,

    /// The Amazon Resource Name (ARN) of the scheduled Lambda function.
    resource: []const u8,

    /// The credentials that Step Functions uses for the task.
    task_credentials: ?TaskCredentials,

    /// The maximum allowed duration of the Lambda function.
    timeout_in_seconds: ?i64,

    pub const json_field_names = .{
        .input = "input",
        .input_details = "inputDetails",
        .resource = "resource",
        .task_credentials = "taskCredentials",
        .timeout_in_seconds = "timeoutInSeconds",
    };
};
