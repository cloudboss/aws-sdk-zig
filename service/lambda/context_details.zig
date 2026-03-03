const ErrorObject = @import("error_object.zig").ErrorObject;

/// Details about a durable execution context.
pub const ContextDetails = struct {
    /// Details about the context failure.
    @"error": ?ErrorObject = null,

    /// Whether the state data of child operations of this completed context should
    /// be included in the invoke payload and `GetDurableExecutionState` response.
    replay_children: ?bool = null,

    /// The response payload from the context.
    result: ?[]const u8 = null,

    pub const json_field_names = .{
        .@"error" = "Error",
        .replay_children = "ReplayChildren",
        .result = "Result",
    };
};
