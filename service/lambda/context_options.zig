/// Configuration options for a durable execution context.
pub const ContextOptions = struct {
    /// Whether the state data of children of the completed context should be
    /// included in the invoke payload and `GetDurableExecutionState` response.
    replay_children: ?bool,
};
