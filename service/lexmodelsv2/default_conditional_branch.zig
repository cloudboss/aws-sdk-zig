const DialogState = @import("dialog_state.zig").DialogState;
const ResponseSpecification = @import("response_specification.zig").ResponseSpecification;

/// A set of actions that Amazon Lex should run if none of the
/// other conditions are met.
pub const DefaultConditionalBranch = struct {
    /// The next step in the conversation.
    next_step: ?DialogState,

    response: ?ResponseSpecification,

    pub const json_field_names = .{
        .next_step = "nextStep",
        .response = "response",
    };
};
