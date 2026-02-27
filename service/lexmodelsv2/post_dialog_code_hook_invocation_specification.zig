const ConditionalSpecification = @import("conditional_specification.zig").ConditionalSpecification;
const DialogState = @import("dialog_state.zig").DialogState;
const ResponseSpecification = @import("response_specification.zig").ResponseSpecification;

/// Specifies next steps to run after the dialog code hook
/// finishes.
pub const PostDialogCodeHookInvocationSpecification = struct {
    /// A list of conditional branches to evaluate after the dialog code
    /// hook throws an exception or returns with the `State` field
    /// of the `Intent` object set to `Failed`.
    failure_conditional: ?ConditionalSpecification,

    /// Specifies the next step the bot runs after the dialog code hook
    /// throws an exception or returns with the `State` field of the
    /// `Intent` object set to `Failed`.
    failure_next_step: ?DialogState,

    failure_response: ?ResponseSpecification,

    /// A list of conditional branches to evaluate after the dialog code
    /// hook finishes successfully.
    success_conditional: ?ConditionalSpecification,

    /// Specifics the next step the bot runs after the dialog code hook
    /// finishes successfully.
    success_next_step: ?DialogState,

    success_response: ?ResponseSpecification,

    /// A list of conditional branches to evaluate if the code hook times
    /// out.
    timeout_conditional: ?ConditionalSpecification,

    /// Specifies the next step that the bot runs when the code hook times
    /// out.
    timeout_next_step: ?DialogState,

    timeout_response: ?ResponseSpecification,

    pub const json_field_names = .{
        .failure_conditional = "failureConditional",
        .failure_next_step = "failureNextStep",
        .failure_response = "failureResponse",
        .success_conditional = "successConditional",
        .success_next_step = "successNextStep",
        .success_response = "successResponse",
        .timeout_conditional = "timeoutConditional",
        .timeout_next_step = "timeoutNextStep",
        .timeout_response = "timeoutResponse",
    };
};
