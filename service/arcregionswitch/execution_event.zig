const ExecutionBlockType = @import("execution_block_type.zig").ExecutionBlockType;
const ExecutionEventType = @import("execution_event_type.zig").ExecutionEventType;

/// Represents an event that occurred during a plan execution. These events
/// provide a detailed timeline of the execution process.
pub const ExecutionEvent = struct {
    /// The description for an execution event.
    description: ?[]const u8 = null,

    /// Errors for an execution event.
    @"error": ?[]const u8 = null,

    /// The event ID for an execution event.
    event_id: []const u8,

    /// The execution block type for an execution event.
    execution_block_type: ?ExecutionBlockType = null,

    /// The event ID of the previous execution event.
    previous_event_id: ?[]const u8 = null,

    /// The resources for an execution event.
    resources: ?[]const []const u8 = null,

    /// The step name for an execution event.
    step_name: ?[]const u8 = null,

    /// The timestamp for an execution event.
    timestamp: ?i64 = null,

    /// The type of an execution event.
    @"type": ?ExecutionEventType = null,

    pub const json_field_names = .{
        .description = "description",
        .@"error" = "error",
        .event_id = "eventId",
        .execution_block_type = "executionBlockType",
        .previous_event_id = "previousEventId",
        .resources = "resources",
        .step_name = "stepName",
        .timestamp = "timestamp",
        .@"type" = "type",
    };
};
