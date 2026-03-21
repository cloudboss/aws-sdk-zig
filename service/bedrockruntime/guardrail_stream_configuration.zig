const GuardrailStreamProcessingMode = @import("guardrail_stream_processing_mode.zig").GuardrailStreamProcessingMode;
const GuardrailTrace = @import("guardrail_trace.zig").GuardrailTrace;

/// Configuration information for a guardrail that you use with the
/// [ConverseStream](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_ConverseStream.html) action.
pub const GuardrailStreamConfiguration = struct {
    /// The identifier for the guardrail.
    guardrail_identifier: []const u8 = "",

    /// The version of the guardrail.
    guardrail_version: []const u8 = "",

    /// The processing mode.
    ///
    /// The processing mode. For more information, see *Configure streaming response
    /// behavior* in the *Amazon Bedrock User Guide*.
    stream_processing_mode: GuardrailStreamProcessingMode = .sync,

    /// The trace behavior for the guardrail.
    trace: GuardrailTrace = .disabled,

    pub const json_field_names = .{
        .guardrail_identifier = "guardrailIdentifier",
        .guardrail_version = "guardrailVersion",
        .stream_processing_mode = "streamProcessingMode",
        .trace = "trace",
    };
};
