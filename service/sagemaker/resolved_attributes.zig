const AutoMLJobObjective = @import("auto_ml_job_objective.zig").AutoMLJobObjective;
const AutoMLJobCompletionCriteria = @import("auto_ml_job_completion_criteria.zig").AutoMLJobCompletionCriteria;
const ProblemType = @import("problem_type.zig").ProblemType;

/// The resolved attributes.
pub const ResolvedAttributes = struct {
    auto_ml_job_objective: ?AutoMLJobObjective = null,

    completion_criteria: ?AutoMLJobCompletionCriteria = null,

    /// The problem type.
    problem_type: ?ProblemType = null,

    pub const json_field_names = .{
        .auto_ml_job_objective = "AutoMLJobObjective",
        .completion_criteria = "CompletionCriteria",
        .problem_type = "ProblemType",
    };
};
