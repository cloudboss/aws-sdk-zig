const EvaluationContent = @import("evaluation_content.zig").EvaluationContent;
const GroundTruthTurnInput = @import("ground_truth_turn_input.zig").GroundTruthTurnInput;

/// Ground truth data for a single conversation turn.
pub const GroundTruthTurn = struct {
    /// The expected response for this conversation turn.
    expected_response: ?EvaluationContent = null,

    /// The input for this conversation turn.
    input: ?GroundTruthTurnInput = null,

    pub const json_field_names = .{
        .expected_response = "expectedResponse",
        .input = "input",
    };
};
