const HistoryEventExecutionDataDetails = @import("history_event_execution_data_details.zig").HistoryEventExecutionDataDetails;

/// Contains details about the successful termination of the execution.
pub const ExecutionSucceededEventDetails = struct {
    /// The JSON data output by the execution. Length constraints apply to the
    /// payload size, and are expressed as bytes in UTF-8 encoding.
    output: ?[]const u8,

    /// Contains details about the output of an execution history event.
    output_details: ?HistoryEventExecutionDataDetails,

    pub const json_field_names = .{
        .output = "output",
        .output_details = "outputDetails",
    };
};
