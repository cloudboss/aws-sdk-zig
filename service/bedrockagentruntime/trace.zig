const CustomOrchestrationTrace = @import("custom_orchestration_trace.zig").CustomOrchestrationTrace;
const FailureTrace = @import("failure_trace.zig").FailureTrace;
const GuardrailTrace = @import("guardrail_trace.zig").GuardrailTrace;
const OrchestrationTrace = @import("orchestration_trace.zig").OrchestrationTrace;
const PostProcessingTrace = @import("post_processing_trace.zig").PostProcessingTrace;
const PreProcessingTrace = @import("pre_processing_trace.zig").PreProcessingTrace;
const RoutingClassifierTrace = @import("routing_classifier_trace.zig").RoutingClassifierTrace;

/// Contains one part of the agent's reasoning process and results from calling
/// API actions and querying knowledge bases. You can use the trace to
/// understand how the agent arrived at the response it provided the customer.
/// For more information, see [Trace
/// enablement](https://docs.aws.amazon.com/bedrock/latest/userguide/agents-test.html#trace-enablement).
pub const Trace = union(enum) {
    /// Details about the custom orchestration step in which the agent determines
    /// the order in which actions are executed.
    custom_orchestration_trace: ?CustomOrchestrationTrace,
    /// Contains information about the failure of the interaction.
    failure_trace: ?FailureTrace,
    /// The trace details for a trace defined in the Guardrail filter.
    guardrail_trace: ?GuardrailTrace,
    /// Details about the orchestration step, in which the agent determines the
    /// order in which actions are executed and which knowledge bases are retrieved.
    orchestration_trace: ?OrchestrationTrace,
    /// Details about the post-processing step, in which the agent shapes the
    /// response..
    post_processing_trace: ?PostProcessingTrace,
    /// Details about the pre-processing step, in which the agent contextualizes and
    /// categorizes user inputs.
    pre_processing_trace: ?PreProcessingTrace,
    /// A routing classifier's trace.
    routing_classifier_trace: ?RoutingClassifierTrace,

    pub const json_field_names = .{
        .custom_orchestration_trace = "customOrchestrationTrace",
        .failure_trace = "failureTrace",
        .guardrail_trace = "guardrailTrace",
        .orchestration_trace = "orchestrationTrace",
        .post_processing_trace = "postProcessingTrace",
        .pre_processing_trace = "preProcessingTrace",
        .routing_classifier_trace = "routingClassifierTrace",
    };
};
