const ResponseSpecification = @import("response_specification.zig").ResponseSpecification;
const ConditionalSpecification = @import("conditional_specification.zig").ConditionalSpecification;
const DialogState = @import("dialog_state.zig").DialogState;

/// Provides a statement the Amazon Lex conveys to the user when the intent
/// is successfully fulfilled.
pub const IntentClosingSetting = struct {
    /// Specifies whether an intent's closing response is used. When this
    /// field is false, the closing response isn't sent to the user. If the
    /// `active` field isn't specified, the default is
    /// true.
    active: ?bool = null,

    /// The response that Amazon Lex sends to the user when the intent is
    /// complete.
    closing_response: ?ResponseSpecification = null,

    /// A list of conditional branches associated with the intent's closing
    /// response. These branches are executed when the `nextStep`
    /// attribute is set to `EvalutateConditional`.
    conditional: ?ConditionalSpecification = null,

    /// Specifies the next step that the bot executes after playing the
    /// intent's closing response.
    next_step: ?DialogState = null,

    pub const json_field_names = .{
        .active = "active",
        .closing_response = "closingResponse",
        .conditional = "conditional",
        .next_step = "nextStep",
    };
};
