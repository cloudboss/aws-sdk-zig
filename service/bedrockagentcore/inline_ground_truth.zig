const EvaluationContent = @import("evaluation_content.zig").EvaluationContent;
const EvaluationExpectedTrajectory = @import("evaluation_expected_trajectory.zig").EvaluationExpectedTrajectory;
const GroundTruthTurn = @import("ground_truth_turn.zig").GroundTruthTurn;

/// Inline ground truth data containing assertions, expected trajectories, and
/// per-turn expected responses.
pub const InlineGroundTruth = struct {
    /// Assertions for evaluation, reuses common model EvaluationContentList.
    assertions: ?[]const EvaluationContent = null,

    /// The expected tool call sequence for trajectory evaluation.
    expected_trajectory: ?EvaluationExpectedTrajectory = null,

    /// A list of per-turn ground truth data, each containing an input prompt and
    /// expected response.
    turns: ?[]const GroundTruthTurn = null,

    pub const json_field_names = .{
        .assertions = "assertions",
        .expected_trajectory = "expectedTrajectory",
        .turns = "turns",
    };
};
