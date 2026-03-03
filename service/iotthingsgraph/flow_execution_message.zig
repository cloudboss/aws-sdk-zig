const FlowExecutionEventType = @import("flow_execution_event_type.zig").FlowExecutionEventType;

/// An object that contains information about a flow event.
pub const FlowExecutionMessage = struct {
    /// The type of flow event .
    event_type: ?FlowExecutionEventType = null,

    /// The unique identifier of the message.
    message_id: ?[]const u8 = null,

    /// A string containing information about the flow event.
    payload: ?[]const u8 = null,

    /// The date and time when the message was last updated.
    timestamp: ?i64 = null,

    pub const json_field_names = .{
        .event_type = "eventType",
        .message_id = "messageId",
        .payload = "payload",
        .timestamp = "timestamp",
    };
};
