const HistoryEventExecutionDataDetails = @import("history_event_execution_data_details.zig").HistoryEventExecutionDataDetails;

/// Contains details about an activity that successfully terminated during an
/// execution.
pub const ActivitySucceededEventDetails = struct {
    /// The JSON data output by the activity task. Length constraints apply to the
    /// payload size, and are expressed as bytes in UTF-8 encoding.
    output: ?[]const u8 = null,

    /// Contains details about the output of an execution history event.
    output_details: ?HistoryEventExecutionDataDetails = null,

    pub const json_field_names = .{
        .output = "output",
        .output_details = "outputDetails",
    };
};
