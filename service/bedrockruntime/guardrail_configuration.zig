const GuardrailTrace = @import("guardrail_trace.zig").GuardrailTrace;

/// Configuration information for a guardrail that you use with the
/// [Converse](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_Converse.html) operation.
pub const GuardrailConfiguration = struct {
    /// The identifier for the guardrail.
    guardrail_identifier: []const u8 = "",

    /// The version of the guardrail.
    guardrail_version: []const u8 = "",

    /// The trace behavior for the guardrail.
    trace: GuardrailTrace = .disabled,

    pub const json_field_names = .{
        .guardrail_identifier = "guardrailIdentifier",
        .guardrail_version = "guardrailVersion",
        .trace = "trace",
    };
};
