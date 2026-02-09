const ErrorObject = @import("error_object.zig").ErrorObject;

/// Details about a durable execution context.
pub const ContextDetails = struct {
    /// Details about the context failure.
    @"error": ?ErrorObject,

    /// Whether the state data of child operations of this completed context should
    /// be included in the invoke payload and `GetDurableExecutionState` response.
    replay_children: ?bool,

    /// The response payload from the context.
    result: ?[]const u8,
};
