const GuardrailTraceAssessment = @import("guardrail_trace_assessment.zig").GuardrailTraceAssessment;
const PromptRouterTrace = @import("prompt_router_trace.zig").PromptRouterTrace;

/// The trace object in a response from
/// [ConverseStream](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_ConverseStream.html).
pub const ConverseStreamTrace = struct {
    /// The guardrail trace object.
    guardrail: ?GuardrailTraceAssessment = null,

    /// The request's prompt router.
    prompt_router: ?PromptRouterTrace = null,

    pub const json_field_names = .{
        .guardrail = "guardrail",
        .prompt_router = "promptRouter",
    };
};
