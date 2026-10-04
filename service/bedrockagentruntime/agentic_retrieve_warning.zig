const AgenticRetrieveGuardrailWarning = @import("agentic_retrieve_guardrail_warning.zig").AgenticRetrieveGuardrailWarning;
const AgenticRetrieveWarningMessage = @import("agentic_retrieve_warning_message.zig").AgenticRetrieveWarningMessage;

/// A warning generated during agentic retrieval.
pub const AgenticRetrieveWarning = union(enum) {
    /// A warning from a guardrail evaluation.
    guardrail: ?AgenticRetrieveGuardrailWarning,
    /// A general warning message.
    message: ?AgenticRetrieveWarningMessage,

    pub const json_field_names = .{
        .guardrail = "guardrail",
        .message = "message",
    };
};
