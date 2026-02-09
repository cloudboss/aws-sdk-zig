const EventInput = @import("event_input.zig").EventInput;

/// Details about a durable execution that started.
pub const ExecutionStartedDetails = struct {
    /// The maximum amount of time that the durable execution is allowed to run, in
    /// seconds.
    execution_timeout: i32,

    /// The input payload provided for the durable execution.
    input: EventInput,
};
