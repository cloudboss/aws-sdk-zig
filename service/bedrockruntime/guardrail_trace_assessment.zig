const aws = @import("aws");

const GuardrailAssessment = @import("guardrail_assessment.zig").GuardrailAssessment;

/// A Top level guardrail trace object. For more information, see
/// [ConverseTrace](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_runtime_ConverseTrace.html).
pub const GuardrailTraceAssessment = struct {
    /// Provides the reason for the action taken when harmful content is detected.
    action_reason: ?[]const u8 = null,

    /// The input assessment.
    input_assessment: ?[]const aws.map.MapEntry(GuardrailAssessment) = null,

    /// The output from the model.
    model_output: ?[]const []const u8 = null,

    /// the output assessments.
    output_assessments: ?[]const aws.map.MapEntry([]const GuardrailAssessment) = null,

    pub const json_field_names = .{
        .action_reason = "actionReason",
        .input_assessment = "inputAssessment",
        .model_output = "modelOutput",
        .output_assessments = "outputAssessments",
    };
};
