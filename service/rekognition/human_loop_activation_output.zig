/// Shows the results of the human in the loop evaluation. If there is no
/// HumanLoopArn, the
/// input did not trigger human review.
pub const HumanLoopActivationOutput = struct {
    /// Shows the result of condition evaluations, including those conditions which
    /// activated a
    /// human review.
    human_loop_activation_conditions_evaluation_results: ?[]const u8,

    /// Shows if and why human review was needed.
    human_loop_activation_reasons: ?[]const []const u8,

    /// The Amazon Resource Name (ARN) of the HumanLoop created.
    human_loop_arn: ?[]const u8,

    pub const json_field_names = .{
        .human_loop_activation_conditions_evaluation_results = "HumanLoopActivationConditionsEvaluationResults",
        .human_loop_activation_reasons = "HumanLoopActivationReasons",
        .human_loop_arn = "HumanLoopArn",
    };
};
