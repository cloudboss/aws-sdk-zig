const GuardrailCoverage = @import("guardrail_coverage.zig").GuardrailCoverage;
const GuardrailUsage = @import("guardrail_usage.zig").GuardrailUsage;

/// The invocation metrics for the guardrail.
pub const GuardrailInvocationMetrics = struct {
    /// The coverage details for the guardrail invocation metrics.
    guardrail_coverage: ?GuardrailCoverage = null,

    /// The processing latency details for the guardrail invocation metrics.
    guardrail_processing_latency: ?i64 = null,

    /// The usage details for the guardrail invocation metrics.
    usage: ?GuardrailUsage = null,

    pub const json_field_names = .{
        .guardrail_coverage = "guardrailCoverage",
        .guardrail_processing_latency = "guardrailProcessingLatency",
        .usage = "usage",
    };
};
