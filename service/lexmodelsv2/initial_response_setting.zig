const DialogCodeHookInvocationSetting = @import("dialog_code_hook_invocation_setting.zig").DialogCodeHookInvocationSetting;
const ConditionalSpecification = @import("conditional_specification.zig").ConditionalSpecification;
const ResponseSpecification = @import("response_specification.zig").ResponseSpecification;
const DialogState = @import("dialog_state.zig").DialogState;

/// Configuration setting for a response sent to the user before Amazon Lex
/// starts eliciting slots.
pub const InitialResponseSetting = struct {
    code_hook: ?DialogCodeHookInvocationSetting,

    conditional: ?ConditionalSpecification,

    initial_response: ?ResponseSpecification,

    /// The next step in the conversation.
    next_step: ?DialogState,

    pub const json_field_names = .{
        .code_hook = "codeHook",
        .conditional = "conditional",
        .initial_response = "initialResponse",
        .next_step = "nextStep",
    };
};
