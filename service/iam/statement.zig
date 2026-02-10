const Position = @import("position.zig").Position;
const PolicySourceType = @import("policy_source_type.zig").PolicySourceType;

/// Contains a reference to a `Statement` element in a policy document that
/// determines the result of the simulation.
///
/// This data type is used by the `MatchedStatements` member of the `
/// [EvaluationResult](https://docs.aws.amazon.com/IAM/latest/APIReference/API_EvaluationResult.html)
/// ` type.
pub const Statement = struct {
    /// The row and column of the end of a `Statement` in an IAM policy.
    end_position: ?Position,

    /// The identifier of the policy that was provided as an input.
    source_policy_id: ?[]const u8,

    /// The type of the policy.
    source_policy_type: ?PolicySourceType,

    /// The row and column of the beginning of the `Statement` in an IAM
    /// policy.
    start_position: ?Position,
};
