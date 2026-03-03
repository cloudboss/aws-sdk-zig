const DialogCodeHookInvocationSetting = @import("dialog_code_hook_invocation_setting.zig").DialogCodeHookInvocationSetting;
const ConditionalSpecification = @import("conditional_specification.zig").ConditionalSpecification;
const ResponseSpecification = @import("response_specification.zig").ResponseSpecification;
const DialogState = @import("dialog_state.zig").DialogState;

/// Configuration setting for a response sent to the user before Amazon Lex
/// starts eliciting slots.
pub const InitialResponseSetting = struct {
    code_hook: ?DialogCodeHookInvocationSetting = null,

    conditional: ?ConditionalSpecification = null,

    initial_response: ?ResponseSpecification = null,

    /// The next step in the conversation.
    next_step: ?DialogState = null,

    pub const json_field_names = .{
        .code_hook = "codeHook",
        .conditional = "conditional",
        .initial_response = "initialResponse",
        .next_step = "nextStep",
    };
};
