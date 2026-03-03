const ConditionalSpecification = @import("conditional_specification.zig").ConditionalSpecification;
const DialogState = @import("dialog_state.zig").DialogState;
const ResponseSpecification = @import("response_specification.zig").ResponseSpecification;

/// Provides a setting that determines whether the post-fulfillment
/// response is sent to the user. For more information, see
/// [https://docs.aws.amazon.com/lexv2/latest/dg/streaming-progress.html#progress-complete](https://docs.aws.amazon.com/lexv2/latest/dg/streaming-progress.html#progress-complete)
pub const PostFulfillmentStatusSpecification = struct {
    /// A list of conditional branches to evaluate after the fulfillment
    /// code hook throws an exception or returns with the `State`
    /// field of the `Intent` object set to
    /// `Failed`.
    failure_conditional: ?ConditionalSpecification = null,

    /// Specifies the next step the bot runs after the fulfillment code hook
    /// throws an exception or returns with the `State` field of the
    /// `Intent` object set to `Failed`.
    failure_next_step: ?DialogState = null,

    failure_response: ?ResponseSpecification = null,

    /// A list of conditional branches to evaluate after the fulfillment
    /// code hook finishes successfully.
    success_conditional: ?ConditionalSpecification = null,

    /// Specifies the next step in the conversation that Amazon Lex
    /// invokes when the fulfillment code hook completes successfully.
    success_next_step: ?DialogState = null,

    success_response: ?ResponseSpecification = null,

    /// A list of conditional branches to evaluate if the fulfillment code
    /// hook times out.
    timeout_conditional: ?ConditionalSpecification = null,

    /// Specifies the next step that the bot runs when the fulfillment code
    /// hook times out.
    timeout_next_step: ?DialogState = null,

    timeout_response: ?ResponseSpecification = null,

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
