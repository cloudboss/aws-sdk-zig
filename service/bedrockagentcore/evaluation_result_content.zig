const Context = @import("context.zig").Context;
const TokenUsage = @import("token_usage.zig").TokenUsage;

/// The comprehensive result of an evaluation containing the score, explanation,
/// evaluator metadata, and execution details. Provides both quantitative
/// ratings and qualitative insights about agent performance.
pub const EvaluationResultContent = struct {
    /// The contextual information associated with this evaluation result, including
    /// span context details that identify the specific traces and sessions that
    /// were evaluated.
    context: Context,

    /// The error code indicating the type of failure that occurred during
    /// evaluation. Used to programmatically identify and handle different
    /// categories of evaluation errors.
    error_code: ?[]const u8,

    /// The error message describing what went wrong if the evaluation failed.
    /// Provides detailed information about evaluation failures to help diagnose and
    /// resolve issues with evaluator configuration or input data.
    error_message: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the evaluator used to generate this
    /// result. For custom evaluators, this is the full ARN; for built-in
    /// evaluators, this follows the pattern `Builtin.{EvaluatorName}`.
    evaluator_arn: []const u8,

    /// The unique identifier of the evaluator that produced this result. This
    /// matches the `evaluatorId` provided in the evaluation request and can be used
    /// to identify which evaluator generated specific results.
    evaluator_id: []const u8,

    /// The human-readable name of the evaluator used for this evaluation. For
    /// built-in evaluators, this is the descriptive name (e.g., "Helpfulness",
    /// "Correctness"); for custom evaluators, this is the user-defined name.
    evaluator_name: []const u8,

    /// The detailed explanation provided by the evaluator describing the reasoning
    /// behind the assigned score. This qualitative feedback helps understand why
    /// specific ratings were given and provides actionable insights for
    /// improvement.
    explanation: ?[]const u8,

    /// The categorical label assigned by the evaluator when using a categorical
    /// rating scale. This provides a human-readable description of the evaluation
    /// result (e.g., "Excellent", "Good", "Poor") corresponding to the numerical
    /// value. For numerical scales, this field is optional and provides a natural
    /// language explanation of what the value means (e.g., value 0.5 = "Somewhat
    /// Helpful").
    label: ?[]const u8,

    /// The token consumption statistics for this evaluation, including input
    /// tokens, output tokens, and total tokens used by the underlying language
    /// model during the evaluation process.
    token_usage: ?TokenUsage,

    /// The numerical score assigned by the evaluator according to its configured
    /// rating scale. For numerical scales, this is a decimal value within the
    /// defined range. This field is not allowed for categorical scales.
    value: ?f64,

    pub const json_field_names = .{
        .context = "context",
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .evaluator_arn = "evaluatorArn",
        .evaluator_id = "evaluatorId",
        .evaluator_name = "evaluatorName",
        .explanation = "explanation",
        .label = "label",
        .token_usage = "tokenUsage",
        .value = "value",
    };
};
