const GuardrailAction = @import("guardrail_action.zig").GuardrailAction;
const GuardrailAssessment = @import("guardrail_assessment.zig").GuardrailAssessment;
const Metadata = @import("metadata.zig").Metadata;

/// The trace details used in the Guardrail.
pub const GuardrailTrace = struct {
    /// The trace action details used with the Guardrail.
    action: ?GuardrailAction = null,

    /// The details of the input assessments used in the Guardrail Trace.
    input_assessments: ?[]const GuardrailAssessment = null,

    /// Contains information about the Guardrail output.
    metadata: ?Metadata = null,

    /// The details of the output assessments used in the Guardrail Trace.
    output_assessments: ?[]const GuardrailAssessment = null,

    /// The details of the trace Id used in the Guardrail Trace.
    trace_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .action = "action",
        .input_assessments = "inputAssessments",
        .metadata = "metadata",
        .output_assessments = "outputAssessments",
        .trace_id = "traceId",
    };
};
