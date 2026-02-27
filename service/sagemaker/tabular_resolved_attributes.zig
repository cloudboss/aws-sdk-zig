const ProblemType = @import("problem_type.zig").ProblemType;

/// The resolved attributes specific to the tabular problem type.
pub const TabularResolvedAttributes = struct {
    /// The type of supervised learning problem available for the model candidates
    /// of the AutoML job V2 (Binary Classification, Multiclass Classification,
    /// Regression). For more information, see [ SageMaker Autopilot problem
    /// types](https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-datasets-problem-types.html#autopilot-problem-types).
    problem_type: ?ProblemType,

    pub const json_field_names = .{
        .problem_type = "ProblemType",
    };
};
