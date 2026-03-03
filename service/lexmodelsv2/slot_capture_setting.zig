const ConditionalSpecification = @import("conditional_specification.zig").ConditionalSpecification;
const DialogState = @import("dialog_state.zig").DialogState;
const ResponseSpecification = @import("response_specification.zig").ResponseSpecification;
const DialogCodeHookInvocationSetting = @import("dialog_code_hook_invocation_setting.zig").DialogCodeHookInvocationSetting;
const ElicitationCodeHookInvocationSetting = @import("elicitation_code_hook_invocation_setting.zig").ElicitationCodeHookInvocationSetting;

/// Settings used when Amazon Lex successfully captures a slot
/// value from a user.
pub const SlotCaptureSetting = struct {
    /// A list of conditional branches to evaluate after the slot value is
    /// captured.
    capture_conditional: ?ConditionalSpecification = null,

    /// Specifies the next step that the bot runs when the slot value is
    /// captured before the code hook times out.
    capture_next_step: ?DialogState = null,

    capture_response: ?ResponseSpecification = null,

    /// Code hook called after Amazon Lex successfully captures a
    /// slot value.
    code_hook: ?DialogCodeHookInvocationSetting = null,

    /// Code hook called when Amazon Lex doesn't capture a slot
    /// value.
    elicitation_code_hook: ?ElicitationCodeHookInvocationSetting = null,

    /// A list of conditional branches to evaluate when the slot value isn't
    /// captured.
    failure_conditional: ?ConditionalSpecification = null,

    /// Specifies the next step that the bot runs when the slot value code
    /// is not recognized.
    failure_next_step: ?DialogState = null,

    failure_response: ?ResponseSpecification = null,

    pub const json_field_names = .{
        .capture_conditional = "captureConditional",
        .capture_next_step = "captureNextStep",
        .capture_response = "captureResponse",
        .code_hook = "codeHook",
        .elicitation_code_hook = "elicitationCodeHook",
        .failure_conditional = "failureConditional",
        .failure_next_step = "failureNextStep",
        .failure_response = "failureResponse",
    };
};
