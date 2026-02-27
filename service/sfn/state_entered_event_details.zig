const HistoryEventExecutionDataDetails = @import("history_event_execution_data_details.zig").HistoryEventExecutionDataDetails;

/// Contains details about a state entered during an execution.
pub const StateEnteredEventDetails = struct {
    /// The string that contains the JSON input data for the state. Length
    /// constraints apply to the payload size, and are expressed as bytes in UTF-8
    /// encoding.
    input: ?[]const u8,

    /// Contains details about the input for an execution history event.
    input_details: ?HistoryEventExecutionDataDetails,

    /// The name of the state.
    name: []const u8,

    pub const json_field_names = .{
        .input = "input",
        .input_details = "inputDetails",
        .name = "name",
    };
};
