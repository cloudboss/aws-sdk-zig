const ExecutionBlockType = @import("execution_block_type.zig").ExecutionBlockType;
const ExecutionEventType = @import("execution_event_type.zig").ExecutionEventType;

/// Represents an event that occurred during a plan execution. These events
/// provide a detailed timeline of the execution process.
pub const ExecutionEvent = struct {
    /// The description for an execution event.
    description: ?[]const u8,

    /// Errors for an execution event.
    @"error": ?[]const u8,

    /// The event ID for an execution event.
    event_id: []const u8,

    /// The execution block type for an execution event.
    execution_block_type: ?ExecutionBlockType,

    /// The event ID of the previous execution event.
    previous_event_id: ?[]const u8,

    /// The resources for an execution event.
    resources: ?[]const []const u8,

    /// The step name for an execution event.
    step_name: ?[]const u8,

    /// The timestamp for an execution event.
    timestamp: ?i64,

    /// The type of an execution event.
    type: ?ExecutionEventType,

    pub const json_field_names = .{
        .description = "description",
        .@"error" = "error",
        .event_id = "eventId",
        .execution_block_type = "executionBlockType",
        .previous_event_id = "previousEventId",
        .resources = "resources",
        .step_name = "stepName",
        .timestamp = "timestamp",
        .type = "type",
    };
};
