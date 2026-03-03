const HistoryEventExecutionDataDetails = @import("history_event_execution_data_details.zig").HistoryEventExecutionDataDetails;

/// Contains details about the successful completion of a task state.
pub const TaskSucceededEventDetails = struct {
    /// The full JSON response from a resource when a task has succeeded. This
    /// response becomes
    /// the output of the related task. Length constraints apply to the payload
    /// size, and are expressed as bytes in UTF-8 encoding.
    output: ?[]const u8 = null,

    /// Contains details about the output of an execution history event.
    output_details: ?HistoryEventExecutionDataDetails = null,

    /// The action of the resource called by a task state.
    resource: []const u8,

    /// The service name of the resource in a task state.
    resource_type: []const u8,

    pub const json_field_names = .{
        .output = "output",
        .output_details = "outputDetails",
        .resource = "resource",
        .resource_type = "resourceType",
    };
};
