const Condition = @import("condition.zig").Condition;
const DialogState = @import("dialog_state.zig").DialogState;
const ResponseSpecification = @import("response_specification.zig").ResponseSpecification;

/// A set of actions that Amazon Lex should run if the condition
/// is matched.
pub const ConditionalBranch = struct {
    /// Contains the expression to evaluate. If the condition is true, the
    /// branch's actions are taken.
    condition: Condition,

    /// The name of the branch.
    name: []const u8,

    /// The next step in the conversation.
    next_step: DialogState,

    response: ?ResponseSpecification = null,

    pub const json_field_names = .{
        .condition = "condition",
        .name = "name",
        .next_step = "nextStep",
        .response = "response",
    };
};
