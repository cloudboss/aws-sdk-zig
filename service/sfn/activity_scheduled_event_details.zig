const HistoryEventExecutionDataDetails = @import("history_event_execution_data_details.zig").HistoryEventExecutionDataDetails;

/// Contains details about an activity scheduled during an execution.
pub const ActivityScheduledEventDetails = struct {
    /// The maximum allowed duration between two heartbeats for the activity task.
    heartbeat_in_seconds: ?i64 = null,

    /// The JSON data input to the activity task. Length constraints apply to the
    /// payload size, and are expressed as bytes in UTF-8 encoding.
    input: ?[]const u8 = null,

    /// Contains details about the input for an execution history event.
    input_details: ?HistoryEventExecutionDataDetails = null,

    /// The Amazon Resource Name (ARN) of the scheduled activity.
    resource: []const u8,

    /// The maximum allowed duration of the activity task.
    timeout_in_seconds: ?i64 = null,

    pub const json_field_names = .{
        .heartbeat_in_seconds = "heartbeatInSeconds",
        .input = "input",
        .input_details = "inputDetails",
        .resource = "resource",
        .timeout_in_seconds = "timeoutInSeconds",
    };
};
