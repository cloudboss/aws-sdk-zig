const DialogCodeHookInvocationSetting = @import("dialog_code_hook_invocation_setting.zig").DialogCodeHookInvocationSetting;
const ConditionalSpecification = @import("conditional_specification.zig").ConditionalSpecification;
const DialogState = @import("dialog_state.zig").DialogState;
const ResponseSpecification = @import("response_specification.zig").ResponseSpecification;
const ElicitationCodeHookInvocationSetting = @import("elicitation_code_hook_invocation_setting.zig").ElicitationCodeHookInvocationSetting;
const PromptSpecification = @import("prompt_specification.zig").PromptSpecification;

/// Provides a prompt for making sure that the user is ready for the
/// intent to be fulfilled.
pub const IntentConfirmationSetting = struct {
    /// Specifies whether the intent's confirmation is sent to the user.
    /// When this field is false, confirmation and declination responses aren't
    /// sent. If the `active` field isn't specified, the default is
    /// true.
    active: ?bool,

    /// The `DialogCodeHookInvocationSetting` object associated
    /// with intent's confirmation step. The dialog code hook is triggered
    /// based on these invocation settings when the confirmation next step or
    /// declination next step or failure next step is
    /// `InvokeDialogCodeHook`.
    code_hook: ?DialogCodeHookInvocationSetting,

    /// A list of conditional branches to evaluate after the intent is
    /// closed.
    confirmation_conditional: ?ConditionalSpecification,

    /// Specifies the next step that the bot executes when the customer
    /// confirms the intent.
    confirmation_next_step: ?DialogState,

    confirmation_response: ?ResponseSpecification,

    /// A list of conditional branches to evaluate after the intent is
    /// declined.
    declination_conditional: ?ConditionalSpecification,

    /// Specifies the next step that the bot executes when the customer
    /// declines the intent.
    declination_next_step: ?DialogState,

    /// When the user answers "no" to the question defined in
    /// `promptSpecification`, Amazon Lex responds with this response
    /// to acknowledge that the intent was canceled.
    declination_response: ?ResponseSpecification,

    /// The `DialogCodeHookInvocationSetting` used when the code
    /// hook is invoked during confirmation prompt retries.
    elicitation_code_hook: ?ElicitationCodeHookInvocationSetting,

    failure_conditional: ?ConditionalSpecification,

    /// The next step to take in the conversation if the confirmation step
    /// fails.
    failure_next_step: ?DialogState,

    failure_response: ?ResponseSpecification,

    /// Prompts the user to confirm the intent. This question should have a
    /// yes or no answer.
    ///
    /// Amazon Lex uses this prompt to ensure that the user acknowledges that the
    /// intent is ready for fulfillment. For example, with the
    /// `OrderPizza` intent, you might want to confirm that the
    /// order is correct before placing it. For other intents, such as intents
    /// that simply respond to user questions, you might not need to ask the
    /// user for confirmation before providing the information.
    prompt_specification: PromptSpecification,

    pub const json_field_names = .{
        .active = "active",
        .code_hook = "codeHook",
        .confirmation_conditional = "confirmationConditional",
        .confirmation_next_step = "confirmationNextStep",
        .confirmation_response = "confirmationResponse",
        .declination_conditional = "declinationConditional",
        .declination_next_step = "declinationNextStep",
        .declination_response = "declinationResponse",
        .elicitation_code_hook = "elicitationCodeHook",
        .failure_conditional = "failureConditional",
        .failure_next_step = "failureNextStep",
        .failure_response = "failureResponse",
        .prompt_specification = "promptSpecification",
    };
};
