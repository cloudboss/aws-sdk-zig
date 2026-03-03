const Operation = @import("operation.zig").Operation;

/// Contains operations that have been updated since the last checkpoint, such
/// as completed asynchronous work like timers or callbacks.
pub const CheckpointUpdatedExecutionState = struct {
    /// Indicates that more results are available. Use this value in a subsequent
    /// call to retrieve the next page of results.
    next_marker: ?[]const u8 = null,

    /// A list of operations that have been updated since the last checkpoint.
    operations: ?[]const Operation = null,

    pub const json_field_names = .{
        .next_marker = "NextMarker",
        .operations = "Operations",
    };
};
