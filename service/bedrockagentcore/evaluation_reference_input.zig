const EvaluationContent = @import("evaluation_content.zig").EvaluationContent;
const Context = @import("context.zig").Context;
const EvaluationExpectedTrajectory = @import("evaluation_expected_trajectory.zig").EvaluationExpectedTrajectory;

/// A reference input containing ground truth data for evaluation, scoped to a
/// specific context level (session or trace) through its span context.
pub const EvaluationReferenceInput = struct {
    /// A list of assertion statements for session-level evaluation. Each assertion
    /// describes an expected behavior or outcome the agent should demonstrate
    /// during the session.
    assertions: ?[]const EvaluationContent = null,

    context: Context,

    /// The expected response for trace-level evaluation. Built-in evaluators that
    /// support this field compare the agent's actual response against this value
    /// for assessment. Custom evaluators can access it through the
    /// `{expected_response}` placeholder in their instructions.
    expected_response: ?EvaluationContent = null,

    /// The expected tool call sequence for session-level trajectory evaluation.
    /// Contains a list of tool names representing the tools the agent is expected
    /// to invoke.
    expected_trajectory: ?EvaluationExpectedTrajectory = null,

    pub const json_field_names = .{
        .assertions = "assertions",
        .context = "context",
        .expected_response = "expectedResponse",
        .expected_trajectory = "expectedTrajectory",
    };
};
