const ActiveContext = @import("active_context.zig").ActiveContext;
const UserTurnIntentOutput = @import("user_turn_intent_output.zig").UserTurnIntentOutput;

/// Contains results that are output for the user turn by the test execution.
pub const UserTurnOutputSpecification = struct {
    /// The contexts that are active in the turn.
    active_contexts: ?[]const ActiveContext = null,

    /// Contains information about the intent.
    intent: UserTurnIntentOutput,

    /// The transcript that is output for the user turn by the test execution.
    transcript: ?[]const u8 = null,

    pub const json_field_names = .{
        .active_contexts = "activeContexts",
        .intent = "intent",
        .transcript = "transcript",
    };
};
